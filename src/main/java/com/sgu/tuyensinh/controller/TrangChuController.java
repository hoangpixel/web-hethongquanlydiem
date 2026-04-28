package com.sgu.tuyensinh.controller;

import com.sgu.tuyensinh.model.Nganh;
import com.sgu.tuyensinh.model.ToHopMonThi;
import com.sgu.tuyensinh.repository.NganhRepository;
import com.sgu.tuyensinh.repository.ToHopMonThiRepository;
import com.sgu.tuyensinh.service.TinhDiemService;
import com.sgu.tuyensinh.service.TinhDiemService.KetQuaQuyDoiChiTiet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TrangChuController {

    @Autowired
    private TinhDiemService tinhDiemService;

    // Gọi thêm cái Repository này để lôi hệ số môn từ DB lên
    @Autowired
    private ToHopMonThiRepository toHopRepo; 

    @Autowired
    private NganhRepository nganhRepository;

    @GetMapping("/tinh-diem")
    public String hienThiTrangChu() {
        return "tinhdiem"; 
    }

@PostMapping("/tinh-diem")
    public String tinhDiem(
            @RequestParam("phuongThuc") String phuongThuc,
            @RequestParam("maNganh") String maNganh,
            // Nhận 8 đầu điểm (có thể null nếu thí sinh không nhập)
            @RequestParam(value = "diemToan", required = false) Double dToan,
            @RequestParam(value = "diemVan", required = false) Double dVan,
            @RequestParam(value = "diemAnh", required = false) Double dAnh,
            @RequestParam(value = "diemLy", required = false) Double dLy,
            @RequestParam(value = "diemHoa", required = false) Double dHoa,
            @RequestParam(value = "diemSinh", required = false) Double dSinh,
            @RequestParam(value = "diemSu", required = false) Double dSu,
            @RequestParam(value = "diemDia", required = false) Double dDia,
            @RequestParam(value = "diemDGNL", required = false) Double diemDGNL,
            @RequestParam(value = "diemCong", required = false) Double diemCongNhap,
            @RequestParam(value = "khuVucUuTien", required = false) String khuVucUuTien,
            @RequestParam(value = "doiTuongUuTien", required = false) String doiTuongUuTien,
            Model model) {

        String maNganhChuan = maNganh == null ? "" : maNganh.trim();

        // Giữ lại dữ liệu để hiển thị trên form (nếu cần)
        model.addAttribute("phuongThucNhap", phuongThuc);
        model.addAttribute("maNganhNhap", maNganhChuan);
        model.addAttribute("dToan", dToan); model.addAttribute("dVan", dVan);
        model.addAttribute("dAnh", dAnh); model.addAttribute("dLy", dLy);
        model.addAttribute("dHoa", dHoa); model.addAttribute("dSinh", dSinh);
        model.addAttribute("dSu", dSu); model.addAttribute("dDia", dDia);
        model.addAttribute("diemDGNLNhap", diemDGNL);

        double diemCong = diemCongNhap == null ? 0.0 : diemCongNhap;
        double diemKhuVuc = tinhDiemKhuVuc(khuVucUuTien);
        double diemDoiTuong = tinhDiemDoiTuong(doiTuongUuTien);
        double diemUuTienGoc = diemKhuVuc + diemDoiTuong;

        model.addAttribute("diemCong", lamTron2So(diemCong));
        model.addAttribute("diemKhuVuc", lamTron2So(diemKhuVuc));
        model.addAttribute("diemDoiTuong", lamTron2So(diemDoiTuong));

        model.addAttribute("diemCongNhap", lamTron2So(diemCong));
        model.addAttribute("khuVucUuTienNhap", khuVucUuTien == null ? "KV3" : khuVucUuTien.trim().toUpperCase());
        model.addAttribute("doiTuongUuTienNhap", doiTuongUuTien == null ? "0" : doiTuongUuTien.trim().toUpperCase());


        Nganh nganhThongTin = nganhRepository.findByMaNganh(maNganhChuan);
        Double diemSan = null;
        if (nganhThongTin != null) {
            if ("THPT".equalsIgnoreCase(phuongThuc)) diemSan = nganhThongTin.getDiemSanThpt();
            else if ("VSAT".equalsIgnoreCase(phuongThuc)) diemSan = nganhThongTin.getDiemSanVsat();
            else if ("DGNL".equalsIgnoreCase(phuongThuc)) diemSan = nganhThongTin.getDiemSanDgnl();
        }


        // Lấy TẤT CẢ tổ hợp của ngành này từ DB
        // LƯU Ý: Đệ tử phải có hàm findByMaNganh trong ToHopMonThiRepository nhé!
        List<ToHopMonThi> danhSachToHop = toHopRepo.findByMaNganh(maNganhChuan);

        if (danhSachToHop == null || danhSachToHop.isEmpty()) {
            model.addAttribute("error", "Không tìm thấy thông tin tổ hợp nào cho ngành này!");
            return "tinhdiem";
        }

        // XỬ LÝ PHƯƠNG THỨC ĐGNL (Vì ĐGNL thường chỉ có 1 điểm duy nhất)
        if ("DGNL".equalsIgnoreCase(phuongThuc)) {
            if (diemDGNL == null) {
                model.addAttribute("error", "Vui lòng nhập điểm bài thi ĐGNL.");
                return "tinhdiem";
            }
            
            // Nganh nganhThongTin = nganhRepository.findByMaNganh(maNganhChuan);
            String toHopGoc = (nganhThongTin != null && nganhThongTin.getToHopGoc() != null) 
                              ? nganhThongTin.getToHopGoc() 
                              : danhSachToHop.get(0).getMaToHop(); // Fallback nếu ngành quên cài tổ hợp gốc
            
            KetQuaQuyDoiChiTiet chiTietDGNL = tinhDiemService.quyDoiDiemDGNLChiTiet(toHopGoc, diemDGNL);
            model.addAttribute("toHopGocHienThi", toHopGoc);
            if (chiTietDGNL.getDiemQuyDoi() == null) {
                model.addAttribute("error", "Không tìm thấy mốc quy đổi ĐGNL.");
                return "tinhdiem";
            }

            double diemNenXetTuyen = chiTietDGNL.getDiemQuyDoi();
            double diemNenCong = diemNenXetTuyen + diemCong;
            double diemUuTienSauDieuChinh = tinhDiemUuTienSauDieuChinh(diemNenCong, diemUuTienGoc);
            double tongDiemXetTuyen = diemNenCong + diemUuTienSauDieuChinh;

                    // So sánh và đẩy điểm sàn ra
            model.addAttribute("diemSan", diemSan);
            model.addAttribute("datDiemSan", (diemSan == null || tongDiemXetTuyen >= diemSan));
            model.addAttribute("chiTietDGNL", chiTietDGNL);
            model.addAttribute("diemDGNLNhapLamTron", lamTron2So(diemDGNL));
            model.addAttribute("diemNenXetTuyen", lamTron2So(diemNenXetTuyen));
            model.addAttribute("diemCong", lamTron2So(diemCong));
            model.addAttribute("diemKhuVuc", lamTron2So(diemKhuVuc));
            model.addAttribute("diemDoiTuong", lamTron2So(diemDoiTuong));
            model.addAttribute("diemUuTienGoc", lamTron2So(diemUuTienGoc));
            model.addAttribute("diemUuTienSauDieuChinh", lamTron2So(diemUuTienSauDieuChinh));
            model.addAttribute("tongDiemXetTuyen", lamTron2So(tongDiemXetTuyen));
            model.addAttribute("congThucDiemUuTien", taoCongThucDiemUuTien(diemNenCong, diemUuTienGoc, diemUuTienSauDieuChinh));
            model.addAttribute("kieuKetQua", "DGNL");
            model.addAttribute("tongDiem", lamTron2So(tongDiemXetTuyen)); // Giữ biến tongDiem để hiển thị khối KQ
            
            return "tinhdiem";
        }

        // XỬ LÝ PHƯƠNG THỨC THPT VÀ V-SAT CHO TẤT CẢ TỔ HỢP
        List<Map<String, Object>> ketQuaTatCaToHop = new ArrayList<>();

        for (ToHopMonThi th : danhSachToHop) {
            Double diemMon1 = getDiemTheoMa(th.getThMon1(), dToan, dVan, dAnh, dLy, dHoa, dSinh, dSu, dDia);
            Double diemMon2 = getDiemTheoMa(th.getThMon2(), dToan, dVan, dAnh, dLy, dHoa, dSinh, dSu, dDia);
            Double diemMon3 = getDiemTheoMa(th.getThMon3(), dToan, dVan, dAnh, dLy, dHoa, dSinh, dSu, dDia);

            // Nếu thí sinh nhập KHÔNG ĐỦ 3 môn của tổ hợp này -> Bỏ qua tổ hợp này
            if (diemMon1 == null || diemMon2 == null || diemMon3 == null) {
                continue; 
            }

            double diemQuyDoi1, diemQuyDoi2, diemQuyDoi3;
            List<Map<String, Object>> chiTietMonList = new ArrayList<>();

            if ("THPT".equalsIgnoreCase(phuongThuc)) {
                diemQuyDoi1 = lamTron2So(diemMon1);
                diemQuyDoi2 = lamTron2So(diemMon2);
                diemQuyDoi3 = lamTron2So(diemMon3);

                chiTietMonList.add(taoChiTietMon(th.getThMon1(), th.getHsMon1(), diemMon1, diemQuyDoi1, 
                    "Giữ nguyên THPT", "-", "Quy đổi = Điểm THPT", "Điểm quy đổi = " + fmt(diemMon1), "Không cần nội suy"));
                chiTietMonList.add(taoChiTietMon(th.getThMon2(), th.getHsMon2(), diemMon2, diemQuyDoi2, 
                    "Giữ nguyên THPT", "-", "Quy đổi = Điểm THPT", "Điểm quy đổi = " + fmt(diemMon2), "Không cần nội suy"));
                chiTietMonList.add(taoChiTietMon(th.getThMon3(), th.getHsMon3(), diemMon3, diemQuyDoi3, 
                    "Giữ nguyên THPT", "-", "Quy đổi = Điểm THPT", "Điểm quy đổi = " + fmt(diemMon3), "Không cần nội suy"));
                // chiTietMonList.add(taoChiTietMon(th.getThMon1(), th.getHsMon1(), diemMon1, diemQuyDoi1, "Giữ nguyên THPT", "-", "Quy đổi = Điểm", "-", "-"));
                // chiTietMonList.add(taoChiTietMon(th.getThMon2(), th.getHsMon2(), diemMon2, diemQuyDoi2, "Giữ nguyên THPT", "-", "Quy đổi = Điểm", "-", "-"));
                // chiTietMonList.add(taoChiTietMon(th.getThMon3(), th.getHsMon3(), diemMon3, diemQuyDoi3, "Giữ nguyên THPT", "-", "Quy đổi = Điểm", "-", "-"));
            } else {
                KetQuaQuyDoiChiTiet qd1 = tinhDiemService.quyDoiDiemVSATChiTiet(th.getThMon1(), diemMon1);
                KetQuaQuyDoiChiTiet qd2 = tinhDiemService.quyDoiDiemVSATChiTiet(th.getThMon2(), diemMon2);
                KetQuaQuyDoiChiTiet qd3 = tinhDiemService.quyDoiDiemVSATChiTiet(th.getThMon3(), diemMon3);

                if (qd1.getDiemQuyDoi() == null || qd2.getDiemQuyDoi() == null || qd3.getDiemQuyDoi() == null) {
                    continue; // Lỗi quy đổi thì bỏ qua tổ hợp này
                }

                diemQuyDoi1 = qd1.getDiemQuyDoi();
                diemQuyDoi2 = qd2.getDiemQuyDoi();
                diemQuyDoi3 = qd3.getDiemQuyDoi();

                chiTietMonList.add(taoChiTietMon(th.getThMon1(), th.getHsMon1(), diemMon1, diemQuyDoi1, qd1.getCachTinh(), qd1.getMocQuyDoi(), qd1.getCongThucTongQuat(), qd1.getCongThucThaySo(), qd1.getGhiChu()));
                chiTietMonList.add(taoChiTietMon(th.getThMon2(), th.getHsMon2(), diemMon2, diemQuyDoi2, qd2.getCachTinh(), qd2.getMocQuyDoi(), qd2.getCongThucTongQuat(), qd2.getCongThucThaySo(), qd2.getGhiChu()));
                chiTietMonList.add(taoChiTietMon(th.getThMon3(), th.getHsMon3(), diemMon3, diemQuyDoi3, qd3.getCachTinh(), qd3.getMocQuyDoi(), qd3.getCongThucTongQuat(), qd3.getCongThucThaySo(), qd3.getGhiChu()));
            }

            double tongDiem = (diemQuyDoi1 * th.getHsMon1()) + (diemQuyDoi2 * th.getHsMon2()) + (diemQuyDoi3 * th.getHsMon3());
            double tongHeSo = th.getHsMon1() + th.getHsMon2() + th.getHsMon3();
            double tongDiemQuyVeThang30 = tongHeSo == 0 ? 0 : (tongDiem / tongHeSo) * 3;

            double diemNenXetTuyen = tongDiemQuyVeThang30;
            double diemNenCong = diemNenXetTuyen + diemCong;
            double diemUuTienSauDieuChinh = tinhDiemUuTienSauDieuChinh(diemNenCong, diemUuTienGoc);
            double tongDiemXetTuyen = diemNenCong + diemUuTienSauDieuChinh;

            // Gom TẤT CẢ thông tin của tổ hợp này vào một cái Map để gửi ra giao diện
            Map<String, Object> kqToHop = new HashMap<>();
            kqToHop.put("maToHop", th.getMaToHop());
            kqToHop.put("chiTietMonList", chiTietMonList);
            kqToHop.put("tenMon1", th.getThMon1()); kqToHop.put("hs1", th.getHsMon1()); kqToHop.put("diemQuyDoi1", diemQuyDoi1);
            kqToHop.put("tenMon2", th.getThMon2()); kqToHop.put("hs2", th.getHsMon2()); kqToHop.put("diemQuyDoi2", diemQuyDoi2);
            kqToHop.put("tenMon3", th.getThMon3()); kqToHop.put("hs3", th.getHsMon3()); kqToHop.put("diemQuyDoi3", diemQuyDoi3);
            
            kqToHop.put("congThucTongDiem", String.format("(%s x %s) + (%s x %s) + (%s x %s) = %s", fmt(diemQuyDoi1), fmt(th.getHsMon1()), fmt(diemQuyDoi2), fmt(th.getHsMon2()), fmt(diemQuyDoi3), fmt(th.getHsMon3()), fmt(tongDiem)));
            kqToHop.put("congThucTongHeSo", String.format("%s + %s + %s = %s", fmt(th.getHsMon1()), fmt(th.getHsMon2()), fmt(th.getHsMon3()), fmt(tongHeSo)));
            kqToHop.put("congThucQuyVe30", String.format("(%s / %s) x 3 = %s", fmt(tongDiem), fmt(tongHeSo), fmt(tongDiemQuyVeThang30)));
            kqToHop.put("congThucDiemUuTien", taoCongThucDiemUuTien(diemNenCong, diemUuTienGoc, diemUuTienSauDieuChinh));
            
            kqToHop.put("diemNenXetTuyen", lamTron2So(diemNenXetTuyen));
            kqToHop.put("diemUuTienSauDieuChinh", lamTron2So(diemUuTienSauDieuChinh));
            kqToHop.put("tongDiemXetTuyen", lamTron2So(tongDiemXetTuyen)); // Điểm chốt hạ
            
            kqToHop.put("diemSan", diemSan);
            kqToHop.put("datDiemSan", (diemSan == null || tongDiemXetTuyen >= diemSan));

            ketQuaTatCaToHop.add(kqToHop);
        }

        if (ketQuaTatCaToHop.isEmpty()) {
            model.addAttribute("error", "Các môn bạn nhập không khớp với bất kỳ tổ hợp nào của ngành này!");
            return "tinhdiem";
        }

        // BÍ KÍP CỦA SƯ PHỤ: Sắp xếp danh sách kết quả giảm dần theo điểm (tổ hợp nào điểm cao nhất nhảy lên đầu)
        ketQuaTatCaToHop.sort((kq1, kq2) -> Double.compare((Double) kq2.get("tongDiemXetTuyen"), (Double) kq1.get("tongDiemXetTuyen")));

        model.addAttribute("ketQuaTatCaToHop", ketQuaTatCaToHop);
        model.addAttribute("kieuKetQua", "MON");
        model.addAttribute("tongDiem", true); // Kích hoạt khối hiển thị kết quả bên file jsp

        return "tinhdiem"; 
    }

    // --- HÀM BỔ TRỢ ---
    // Sư phụ dùng hàm này để gắp điểm tương ứng với mã môn trong DB
// Sư phụ dùng hàm này để gắp điểm tương ứng với mã môn trong DB
    private Double getDiemTheoMa(String maMon, Double to, Double va, Double an, Double ly, Double ho, Double si, Double su, Double di) {
        if (maMon == null || maMon.trim().isEmpty()) return null;
        switch (maMon.trim().toUpperCase()) {
            case "TO": case "TOÁN": return to;
            case "VA": case "VĂN": return va;
            
            // THÊM MÃ "N1" VÀO DÒNG NÀY ĐỂ NÓ NHẬN DIỆN MÔN TIẾNG ANH NHÉ ĐỆ TỬ
            case "AN": case "ANH": case "N1": return an; 
            
            case "LI": case "LÍ": case "LÝ": return ly;
            case "HO": case "HÓA": return ho;
            case "SI": case "SINH": return si;
            case "SU": case "SỬ": return su;
            case "DI": case "ĐỊA": return di;
            default: return null;
        }
    }

    private double lamTron2So(double diem) {
        return Math.round(diem * 100.0) / 100.0;
    }

    private double tinhDiemKhuVuc(String khuVuc) {
        if (khuVuc == null || khuVuc.isEmpty()) {
            return 0.0;
        }

        switch (khuVuc.trim().toUpperCase()) {
            case "KV1":
                return 0.75;
            case "KV2-NT":
            case "KV2NT":
                return 0.50;
            case "KV2":
                return 0.25;
            case "KV3":
            default:
                return 0.0;
        }
    }

    private double tinhDiemDoiTuong(String doiTuong) {
        if (doiTuong == null || doiTuong.isEmpty()) {
            return 0.0;
        }

        switch (doiTuong.trim().toUpperCase()) {
            case "1":
            case "2":
            case "3":
            case "4":
            case "ĐT1":
            case "ĐT2":
            case "ĐT3":
            case "ĐT4":
                return 2.0;
            case "5":
            case "6":
            case "7":
            case "ĐT5":
            case "ĐT6":
            case "ĐT7":
                return 1.0;
            default:
                return 0.0;
        }
    }

    private double tinhDiemUuTienSauDieuChinh(double diemNenCong, double diemUuTienGoc) {
        if (diemUuTienGoc <= 0) {
            return 0.0;
        }
        if (diemNenCong < 22.5) {
            return lamTron2So(diemUuTienGoc);
        }

        double heSoDieuChinh = Math.max(0.0, (30.0 - diemNenCong) / 7.5);
        return lamTron2So(diemUuTienGoc * heSoDieuChinh);
    }

    private String taoCongThucDiemUuTien(double diemNenCong, double diemUuTienGoc, double diemUuTienSauDieuChinh) {
        if (diemUuTienGoc <= 0) {
            return "Không có điểm ưu tiên nên điểm ưu tiên áp dụng = 0.00";
        }
        if (diemNenCong < 22.5) {
            return String.format("Vì %s < 22.50 nên cộng ưu tiên bình thường: %s",
                    fmt(diemNenCong), fmt(diemUuTienSauDieuChinh));
        }

        double heSoDieuChinh = Math.max(0.0, (30.0 - diemNenCong) / 7.5);
        return String.format("Điểm ưu tiên điều chỉnh = ((30 - %s) / 7.5) x %s = %s",
                fmt(diemNenCong), fmt(diemUuTienGoc), fmt(heSoDieuChinh * diemUuTienGoc));
    }

    private String fmt(Double value) {
        if (value == null) {
            return "-";
        }
        return String.format("%.2f", value);
    }

    private Map<String, Object> taoChiTietMon(String tenMon,
                                              Double heSo,
                                              Double diemNhap,
                                              Double diemQuyDoi,
                                              String cachTinh,
                                              String mocQuyDoi,
                                              String congThucTongQuat,
                                              String congThucThaySo,
                                              String ghiChu) {
        Map<String, Object> chiTiet = new LinkedHashMap<>();
        chiTiet.put("tenMon", tenMon);
        chiTiet.put("heSo", lamTron2So(heSo));
        chiTiet.put("diemNhap", lamTron2So(diemNhap));
        chiTiet.put("diemQuyDoi", lamTron2So(diemQuyDoi));
        chiTiet.put("diemNhanHeSo", lamTron2So(diemQuyDoi * heSo));
        chiTiet.put("cachTinh", cachTinh);
        chiTiet.put("mocQuyDoi", mocQuyDoi);
        chiTiet.put("congThucTongQuat", congThucTongQuat);
        chiTiet.put("congThucThaySo", congThucThaySo);
        chiTiet.put("ghiChu", ghiChu);
        return chiTiet;
    }
}