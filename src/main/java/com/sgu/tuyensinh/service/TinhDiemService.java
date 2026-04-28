package com.sgu.tuyensinh.service;
import com.sgu.tuyensinh.model.BangQuyDoi;
import com.sgu.tuyensinh.repository.BangQuyDoiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TinhDiemService {

    public static class KetQuaQuyDoiChiTiet {
        private final Double diemQuyDoi;
        private final String cachTinh;
        private final String mocQuyDoi;
        private final String congThucTongQuat;
        private final String congThucThaySo;
        private final String ghiChu;

        public KetQuaQuyDoiChiTiet(Double diemQuyDoi,
                                   String cachTinh,
                                   String mocQuyDoi,
                                   String congThucTongQuat,
                                   String congThucThaySo,
                                   String ghiChu) {
            this.diemQuyDoi = diemQuyDoi;
            this.cachTinh = cachTinh;
            this.mocQuyDoi = mocQuyDoi;
            this.congThucTongQuat = congThucTongQuat;
            this.congThucThaySo = congThucThaySo;
            this.ghiChu = ghiChu;
        }

        public Double getDiemQuyDoi() {
            return diemQuyDoi;
        }

        public String getCachTinh() {
            return cachTinh;
        }

        public String getMocQuyDoi() {
            return mocQuyDoi;
        }

        public String getCongThucTongQuat() {
            return congThucTongQuat;
        }

        public String getCongThucThaySo() {
            return congThucThaySo;
        }

        public String getGhiChu() {
            return ghiChu;
        }
    }

    @Autowired
    private BangQuyDoiRepository repository;

    // 1. Công thức nội suy tuyến tính
    private double tinhNoiSuy(double x, double a, double b, double c, double d) {
        if (b == a) return c; // Tránh lỗi chia cho 0
        if (x == a) return c;
        if (x == b) return d;
        
        double y = c + ((x - a) / (b - a)) * (d - c);
        return Math.round(y * 100.0) / 100.0; // Làm tròn 2 chữ số
    }

    // 2. Hàm tính điểm 1 môn V-SAT
    public Double quyDoiDiemVSAT(String mon, double diemVSAT) {
        return quyDoiDiemVSATChiTiet(mon, diemVSAT).getDiemQuyDoi();
    }

    // 3. Hàm quy đổi điểm ĐGNL HCM
    public Double quyDoiDiemDGNL(String toHop, double diemDGNL) {
        return quyDoiDiemDGNLChiTiet(toHop, diemDGNL).getDiemQuyDoi();
    }

    public KetQuaQuyDoiChiTiet quyDoiDiemVSATChiTiet(String mon, double diemVSAT) {
        BangQuyDoi moc = repository.timMocQuyDoiVSAT(mon, diemVSAT);

        if (moc == null) {
            if (diemVSAT <= 0) {
                return new KetQuaQuyDoiChiTiet(
                        0.0,
                        "Quy tắc biên V-SAT (điểm <= 0)",
                        "Không áp dụng nội suy",
                        "Điểm quy đổi = 0",
                        "Điểm quy đổi = 0",
                        "Điểm đầu vào nhỏ hơn hoặc bằng 0 nên hệ thống trả về 0."
                );
            }

            BangQuyDoi mocLonNhat = repository.timMocLonNhatVSAT(mon);
            if (mocLonNhat != null && diemVSAT >= mocLonNhat.getDiemB()) {
                double diemQuyDoi = lamTron2So(mocLonNhat.getDiemD());
                return new KetQuaQuyDoiChiTiet(
                        diemQuyDoi,
                        "Quy tắc biên V-SAT (vượt mốc cao nhất)",
                        String.format("x >= %s", fmt(mocLonNhat.getDiemB())),
                        "Điểm quy đổi = d (mốc cao nhất)",
                        String.format("Điểm quy đổi = %s", fmt(diemQuyDoi)),
                        "Điểm đầu vào lớn hơn hoặc bằng cận trên cao nhất nên lấy điểm quy đổi trần."
                );
            }

            BangQuyDoi mocNhoNhat = repository.timMocNhoNhatVSAT(mon);
            if (mocNhoNhat != null && diemVSAT < mocNhoNhat.getDiemA()) {
                return new KetQuaQuyDoiChiTiet(
                        1.0,
                        "Quy tắc biên V-SAT (dưới mốc thấp nhất)",
                        String.format("x < %s", fmt(mocNhoNhat.getDiemA())),
                        "Điểm quy đổi = 1.0",
                        "Điểm quy đổi = 1.0",
                        "Điểm đầu vào nằm dưới mốc nhỏ nhất nên gán mức sàn 1.0."
                );
            }

            return new KetQuaQuyDoiChiTiet(
                    null,
                    "Không tìm thấy mốc quy đổi",
                    "Không có mốc phù hợp trong bảng xt_bangquydoi",
                    "Không thể áp dụng công thức",
                    "-",
                    "Vui lòng kiểm tra dữ liệu bảng quy đổi cho môn này."
            );
        }

        double y = tinhNoiSuy(diemVSAT, moc.getDiemA(), moc.getDiemB(), moc.getDiemC(), moc.getDiemD());
        return new KetQuaQuyDoiChiTiet(
                y,
                "Nội suy tuyến tính theo mốc V-SAT",
                String.format("x trong [%s, %s], y trong [%s, %s]", fmt(moc.getDiemA()), fmt(moc.getDiemB()), fmt(moc.getDiemC()), fmt(moc.getDiemD())),
                "y = c + ((x - a) / (b - a)) * (d - c)",
                String.format("y = %s + ((%s - %s) / (%s - %s)) * (%s - %s) = %s",
                        fmt(moc.getDiemC()), fmt(diemVSAT), fmt(moc.getDiemA()), fmt(moc.getDiemB()), fmt(moc.getDiemA()), fmt(moc.getDiemD()), fmt(moc.getDiemC()), fmt(y)),
                "Kết quả được làm tròn 2 chữ số thập phân."
        );
    }

    public KetQuaQuyDoiChiTiet quyDoiDiemDGNLChiTiet(String toHop, double diemDGNL) {
        BangQuyDoi moc = repository.timMocQuyDoiDGNL(toHop, diemDGNL);
        if (moc == null) {
            return new KetQuaQuyDoiChiTiet(
                    null,
                    "Không tìm thấy mốc quy đổi",
                    "Không có khoảng điểm phù hợp cho tổ hợp đã nhập",
                    "Không thể áp dụng công thức",
                    "-",
                    "Vui lòng kiểm tra bảng xt_bangquydoi (phương thức ĐGNL HCM)."
            );
        }

        double y = tinhNoiSuy(diemDGNL, moc.getDiemA(), moc.getDiemB(), moc.getDiemC(), moc.getDiemD());
        return new KetQuaQuyDoiChiTiet(
                y,
                "Nội suy tuyến tính theo mốc ĐGNL HCM",
                String.format("x trong [%s, %s], y trong [%s, %s]", fmt(moc.getDiemA()), fmt(moc.getDiemB()), fmt(moc.getDiemC()), fmt(moc.getDiemD())),
                "y = c + ((x - a) / (b - a)) * (d - c)",
                String.format("y = %s + ((%s - %s) / (%s - %s)) * (%s - %s) = %s",
                        fmt(moc.getDiemC()), fmt(diemDGNL), fmt(moc.getDiemA()), fmt(moc.getDiemB()), fmt(moc.getDiemA()), fmt(moc.getDiemD()), fmt(moc.getDiemC()), fmt(y)),
                "Kết quả được làm tròn 2 chữ số thập phân."
        );
    }

    private double lamTron2So(double diem) {
        return Math.round(diem * 100.0) / 100.0;
    }

    private String fmt(Double value) {
        if (value == null) {
            return "-";
        }
        return String.format("%.2f", value);
    }
}