package com.sgu.tuyensinh.controller;

import com.sgu.tuyensinh.model.ToHopMonThi;
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

    @GetMapping("/tinh-diem")
    public String hienThiTrangChu() {
        return "tinhdiem"; 
    }

    @PostMapping("/tinh-diem")
    public String tinhDiem(
            @RequestParam("phuongThuc") String phuongThuc,
            @RequestParam("maNganh") String maNganh,
            @RequestParam("maToHop") String maToHop,
            @RequestParam(value = "diemMon1", required = false) Double diemMon1,
            @RequestParam(value = "diemMon2", required = false) Double diemMon2,
            @RequestParam(value = "diemMon3", required = false) Double diemMon3,
            @RequestParam(value = "diemDGNL", required = false) Double diemDGNL,
            @RequestParam(value = "diemCong", required = false) Double diemCongNhap,
            @RequestParam(value = "khuVucUuTien", required = false) String khuVucUuTien,
            @RequestParam(value = "doiTuongUuTien", required = false) String doiTuongUuTien,
            Model model) {

        String maNganhChuan = maNganh == null ? "" : maNganh.trim();
        String maToHopChuan = maToHop == null ? "" : maToHop.trim().toUpperCase();

        model.addAttribute("phuongThucNhap", phuongThuc);
        model.addAttribute("maNganhNhap", maNganhChuan);
        model.addAttribute("maToHopNhap", maToHopChuan);
        model.addAttribute("diem1Nhap", diemMon1);
        model.addAttribute("diem2Nhap", diemMon2);
        model.addAttribute("diem3Nhap", diemMon3);
        model.addAttribute("diemDGNLNhap", diemDGNL);

        double diemCong = diemCongNhap == null ? 0.0 : diemCongNhap;
        double diemKhuVuc = tinhDiemKhuVuc(khuVucUuTien);
        double diemDoiTuong = tinhDiemDoiTuong(doiTuongUuTien);
        double diemUuTienGoc = diemKhuVuc + diemDoiTuong;

        model.addAttribute("diemCongNhap", lamTron2So(diemCong));
        model.addAttribute("khuVucUuTienNhap", khuVucUuTien == null ? "KV3" : khuVucUuTien.trim().toUpperCase());
        model.addAttribute("doiTuongUuTienNhap", doiTuongUuTien == null ? "0" : doiTuongUuTien.trim().toUpperCase());

        ToHopMonThi th = toHopRepo.findByMaNganhAndMaToHop(maNganhChuan, maToHopChuan);

        if (th == null) {
            model.addAttribute("error", "Không tìm thấy thông tin tổ hợp cho ngành này!");
            return "tinhdiem";
        }

        model.addAttribute("tenMon1", th.getThMon1());
        model.addAttribute("tenMon2", th.getThMon2());
        model.addAttribute("tenMon3", th.getThMon3());
        model.addAttribute("hs1", th.getHsMon1());
        model.addAttribute("hs2", th.getHsMon2());
        model.addAttribute("hs3", th.getHsMon3());

        if ("DGNL".equalsIgnoreCase(phuongThuc)) {
            if (diemDGNL == null) {
                model.addAttribute("error", "Vui lòng nhập điểm ĐGNL.");
                return "tinhdiem";
            }

            KetQuaQuyDoiChiTiet chiTietDGNL = tinhDiemService.quyDoiDiemDGNLChiTiet(maToHopChuan, diemDGNL);
            if (chiTietDGNL.getDiemQuyDoi() == null) {
                model.addAttribute("error", "Không tìm thấy mốc quy đổi ĐGNL cho tổ hợp hoặc điểm đã nhập.");
                return "tinhdiem";
            }

            model.addAttribute("chiTietDGNL", chiTietDGNL);
            model.addAttribute("diemDGNLNhapLamTron", lamTron2So(diemDGNL));

            double diemNenXetTuyen = chiTietDGNL.getDiemQuyDoi();
            double diemNenCong = diemNenXetTuyen + diemCong;
            double diemUuTienSauDieuChinh = tinhDiemUuTienSauDieuChinh(diemNenCong, diemUuTienGoc);
            double tongDiemXetTuyen = diemNenCong + diemUuTienSauDieuChinh;

            model.addAttribute("diemNenXetTuyen", lamTron2So(diemNenXetTuyen));
            model.addAttribute("diemCong", lamTron2So(diemCong));
            model.addAttribute("diemKhuVuc", lamTron2So(diemKhuVuc));
            model.addAttribute("diemDoiTuong", lamTron2So(diemDoiTuong));
            model.addAttribute("diemUuTienGoc", lamTron2So(diemUuTienGoc));
            model.addAttribute("diemUuTienSauDieuChinh", lamTron2So(diemUuTienSauDieuChinh));
            model.addAttribute("tongDiemXetTuyen", lamTron2So(tongDiemXetTuyen));
            model.addAttribute("congThucDiemUuTien", taoCongThucDiemUuTien(diemNenCong, diemUuTienGoc, diemUuTienSauDieuChinh));

            model.addAttribute("kieuKetQua", "DGNL");
            model.addAttribute("tongDiem", lamTron2So(tongDiemXetTuyen));
            return "tinhdiem";
        }

        if (diemMon1 == null || diemMon2 == null || diemMon3 == null) {
            model.addAttribute("error", "Vui lòng nhập đủ 3 điểm môn.");
            return "tinhdiem";
        }

        double diemQuyDoi1;
        double diemQuyDoi2;
        double diemQuyDoi3;
        List<Map<String, Object>> chiTietMonList = new ArrayList<>();

        if ("THPT".equalsIgnoreCase(phuongThuc)) {
            diemQuyDoi1 = lamTron2So(diemMon1);
            diemQuyDoi2 = lamTron2So(diemMon2);
            diemQuyDoi3 = lamTron2So(diemMon3);

            chiTietMonList.add(taoChiTietMon(th.getThMon1(), th.getHsMon1(), diemMon1, diemQuyDoi1,
                "Giữ nguyên điểm THPT",
                "Không áp dụng mốc quy đổi",
                "Điểm quy đổi = Điểm THPT",
                String.format("Điểm quy đổi = %s = %s", fmt(diemMon1), fmt(diemQuyDoi1)),
                "Phương thức THPT dùng trực tiếp điểm thang 10."));

            chiTietMonList.add(taoChiTietMon(th.getThMon2(), th.getHsMon2(), diemMon2, diemQuyDoi2,
                "Giữ nguyên điểm THPT",
                "Không áp dụng mốc quy đổi",
                "Điểm quy đổi = Điểm THPT",
                String.format("Điểm quy đổi = %s = %s", fmt(diemMon2), fmt(diemQuyDoi2)),
                "Phương thức THPT dùng trực tiếp điểm thang 10."));

            chiTietMonList.add(taoChiTietMon(th.getThMon3(), th.getHsMon3(), diemMon3, diemQuyDoi3,
                "Giữ nguyên điểm THPT",
                "Không áp dụng mốc quy đổi",
                "Điểm quy đổi = Điểm THPT",
                String.format("Điểm quy đổi = %s = %s", fmt(diemMon3), fmt(diemQuyDoi3)),
                "Phương thức THPT dùng trực tiếp điểm thang 10."));
        } else {
            KetQuaQuyDoiChiTiet qd1 = tinhDiemService.quyDoiDiemVSATChiTiet(th.getThMon1(), diemMon1);
            KetQuaQuyDoiChiTiet qd2 = tinhDiemService.quyDoiDiemVSATChiTiet(th.getThMon2(), diemMon2);
            KetQuaQuyDoiChiTiet qd3 = tinhDiemService.quyDoiDiemVSATChiTiet(th.getThMon3(), diemMon3);

            if (qd1.getDiemQuyDoi() == null || qd2.getDiemQuyDoi() == null || qd3.getDiemQuyDoi() == null) {
                model.addAttribute("error", "Không tìm thấy mốc quy đổi V-SAT cho một trong các môn của tổ hợp này.");
                return "tinhdiem";
            }

            diemQuyDoi1 = qd1.getDiemQuyDoi();
            diemQuyDoi2 = qd2.getDiemQuyDoi();
            diemQuyDoi3 = qd3.getDiemQuyDoi();

            chiTietMonList.add(taoChiTietMon(th.getThMon1(), th.getHsMon1(), diemMon1, diemQuyDoi1,
                qd1.getCachTinh(), qd1.getMocQuyDoi(), qd1.getCongThucTongQuat(), qd1.getCongThucThaySo(), qd1.getGhiChu()));
            chiTietMonList.add(taoChiTietMon(th.getThMon2(), th.getHsMon2(), diemMon2, diemQuyDoi2,
                qd2.getCachTinh(), qd2.getMocQuyDoi(), qd2.getCongThucTongQuat(), qd2.getCongThucThaySo(), qd2.getGhiChu()));
            chiTietMonList.add(taoChiTietMon(th.getThMon3(), th.getHsMon3(), diemMon3, diemQuyDoi3,
                qd3.getCachTinh(), qd3.getMocQuyDoi(), qd3.getCongThucTongQuat(), qd3.getCongThucThaySo(), qd3.getGhiChu()));
        }

        double tongDiem = (diemQuyDoi1 * th.getHsMon1())
                + (diemQuyDoi2 * th.getHsMon2())
                + (diemQuyDoi3 * th.getHsMon3());
        double tongHeSo = th.getHsMon1() + th.getHsMon2() + th.getHsMon3();
        double tongDiemQuyVeThang30 = tongHeSo == 0 ? 0 : (tongDiem / tongHeSo) * 3;

        model.addAttribute("chiTietMonList", chiTietMonList);
        model.addAttribute("congThucTongDiem",
            String.format("(%s x %s) + (%s x %s) + (%s x %s) = %s",
                fmt(diemQuyDoi1), fmt(th.getHsMon1()),
                fmt(diemQuyDoi2), fmt(th.getHsMon2()),
                fmt(diemQuyDoi3), fmt(th.getHsMon3()),
                fmt(tongDiem)));
        model.addAttribute("congThucTongHeSo",
            String.format("%s + %s + %s = %s",
                fmt(th.getHsMon1()), fmt(th.getHsMon2()), fmt(th.getHsMon3()), fmt(tongHeSo)));
        model.addAttribute("congThucQuyVe30",
            String.format("(%s / %s) x 3 = %s",
                fmt(tongDiem), fmt(tongHeSo), fmt(tongDiemQuyVeThang30)));

        double diemNenXetTuyen = tongDiemQuyVeThang30;
        double diemNenCong = diemNenXetTuyen + diemCong;
        double diemUuTienSauDieuChinh = tinhDiemUuTienSauDieuChinh(diemNenCong, diemUuTienGoc);
        double tongDiemXetTuyen = diemNenCong + diemUuTienSauDieuChinh;

        model.addAttribute("diemNenXetTuyen", lamTron2So(diemNenXetTuyen));
        model.addAttribute("diemCong", lamTron2So(diemCong));
        model.addAttribute("diemKhuVuc", lamTron2So(diemKhuVuc));
        model.addAttribute("diemDoiTuong", lamTron2So(diemDoiTuong));
        model.addAttribute("diemUuTienGoc", lamTron2So(diemUuTienGoc));
        model.addAttribute("diemUuTienSauDieuChinh", lamTron2So(diemUuTienSauDieuChinh));
        model.addAttribute("tongDiemXetTuyen", lamTron2So(tongDiemXetTuyen));
        model.addAttribute("congThucDiemUuTien", taoCongThucDiemUuTien(diemNenCong, diemUuTienGoc, diemUuTienSauDieuChinh));

        model.addAttribute("kieuKetQua", "MON");
        model.addAttribute("diemQuyDoi1", diemQuyDoi1);
        model.addAttribute("diemQuyDoi2", diemQuyDoi2);
        model.addAttribute("diemQuyDoi3", diemQuyDoi3);
        model.addAttribute("tongDiem", lamTron2So(tongDiem));
        model.addAttribute("tongHeSo", lamTron2So(tongHeSo));
        model.addAttribute("tongDiemThang30", lamTron2So(tongDiemQuyVeThang30));

        return "tinhdiem"; 
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