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
import org.springframework.data.domain.Sort;

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
    public String hienThiTrangChu(Model model) {
        model.addAttribute("dsNganh", nganhRepository.findAll(Sort.by(Sort.Direction.ASC, "maNganh")));
        model.addAttribute("maNganhHienThi", "");
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
            // THPT mở rộng (chỉ hiện trên UI khi chọn THPT)
            @RequestParam(value = "diemCNCN", required = false) Double dCNCN,
            @RequestParam(value = "diemCNNN", required = false) Double dCNNN,
            @RequestParam(value = "diemTI", required = false) Double dTI,
            @RequestParam(value = "diemKTPL", required = false) Double dKTPL,
            @RequestParam(value = "diemNK1", required = false) Double dNK1,
            @RequestParam(value = "diemNK2", required = false) Double dNK2,
            @RequestParam(value = "diemNK3", required = false) Double dNK3,
            @RequestParam(value = "diemNK4", required = false) Double dNK4,
            @RequestParam(value = "diemNK5", required = false) Double dNK5,
            @RequestParam(value = "diemNK6", required = false) Double dNK6,
            @RequestParam(value = "diemDGNL", required = false) Double diemDGNL,
            @RequestParam(value = "diemCong", required = false) Double diemCongNhap,
            @RequestParam(value = "khuVucUuTien", required = false) String khuVucUuTien,
            @RequestParam(value = "doiTuongUuTien", required = false) String doiTuongUuTien,
            Model model) {

        model.addAttribute("dsNganh", nganhRepository.findAll(Sort.by(Sort.Direction.ASC, "maNganh")));

        boolean isThpt = "THPT".equalsIgnoreCase(phuongThuc);
        if (!isThpt) {
            dCNCN = null;
            dCNNN = null;
            dTI = null;
            dKTPL = null;
            dNK1 = null;
            dNK2 = null;
            dNK3 = null;
            dNK4 = null;
            dNK5 = null;
            dNK6 = null;
        }

        String maNganhChuan = maNganh == null ? "" : maNganh.trim();

        // Giữ lại dữ liệu để hiển thị trên form (nếu cần)
        model.addAttribute("phuongThucNhap", phuongThuc);
        model.addAttribute("maNganhNhap", maNganhChuan);
        model.addAttribute("dToan", dToan); model.addAttribute("dVan", dVan);
        model.addAttribute("dAnh", dAnh); model.addAttribute("dLy", dLy);
        model.addAttribute("dHoa", dHoa); model.addAttribute("dSinh", dSinh);
        model.addAttribute("dSu", dSu); model.addAttribute("dDia", dDia);
        model.addAttribute("dCNCN", dCNCN);
        model.addAttribute("dCNNN", dCNNN);
        model.addAttribute("dTI", dTI);
        model.addAttribute("dKTPL", dKTPL);
        model.addAttribute("dNK1", dNK1);
        model.addAttribute("dNK2", dNK2);
        model.addAttribute("dNK3", dNK3);
        model.addAttribute("dNK4", dNK4);
        model.addAttribute("dNK5", dNK5);
        model.addAttribute("dNK6", dNK6);
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
        if (nganhThongTin != null && nganhThongTin.getTenNganh() != null && !nganhThongTin.getTenNganh().isBlank()) {
            model.addAttribute("maNganhHienThi", maNganhChuan + " - " + nganhThongTin.getTenNganh());
        } else {
            model.addAttribute("maNganhHienThi", maNganhChuan);
        }
        Double diemSan = null;
        Double diemChuan = null;
        if (nganhThongTin != null) {
            if ("THPT".equalsIgnoreCase(phuongThuc)) diemSan = nganhThongTin.getDiemSanThpt();
            else if ("VSAT".equalsIgnoreCase(phuongThuc)) diemSan = nganhThongTin.getDiemSanVsat();
            else if ("DGNL".equalsIgnoreCase(phuongThuc)) diemSan = nganhThongTin.getDiemSanDgnl();

            if ("THPT".equalsIgnoreCase(phuongThuc)) diemChuan = nganhThongTin.getDiemChuanThpt();
            else if ("VSAT".equalsIgnoreCase(phuongThuc)) diemChuan = nganhThongTin.getDiemChuanVsat();
            else if ("DGNL".equalsIgnoreCase(phuongThuc)) diemChuan = nganhThongTin.getDiemChuanDgnl();
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

                double tongDiemXetTuyenLamTron = lamTron2So(tongDiemXetTuyen);
                tongDiemXetTuyenLamTron = Math.min(30.0, tongDiemXetTuyenLamTron);

                // So sánh và đẩy điểm chuẩn ra
                model.addAttribute("diemChuan", diemChuan);
                model.addAttribute("datDiemChuan", (diemChuan == null || tongDiemXetTuyenLamTron >= diemChuan));
            model.addAttribute("chiTietDGNL", chiTietDGNL);
            model.addAttribute("diemDGNLNhapLamTron", lamTron2So(diemDGNL));
            model.addAttribute("diemNenXetTuyen", lamTron2So(diemNenXetTuyen));
            model.addAttribute("diemCong", lamTron2So(diemCong));
            model.addAttribute("diemKhuVuc", lamTron2So(diemKhuVuc));
            model.addAttribute("diemDoiTuong", lamTron2So(diemDoiTuong));
            model.addAttribute("diemUuTienGoc", lamTron2So(diemUuTienGoc));
            model.addAttribute("diemUuTienSauDieuChinh", lamTron2So(diemUuTienSauDieuChinh));
                model.addAttribute("tongDiemXetTuyen", tongDiemXetTuyenLamTron);
            model.addAttribute("congThucDiemUuTien", taoCongThucDiemUuTien(diemNenXetTuyen, diemCong, diemUuTienGoc, diemUuTienSauDieuChinh));
            model.addAttribute("kieuKetQua", "DGNL");
                model.addAttribute("tongDiem", tongDiemXetTuyenLamTron); // Giữ biến tongDiem để hiển thị khối KQ
            
            return "tinhdiem";
        }

        // XỬ LÝ PHƯƠNG THỨC THPT VÀ V-SAT CHO TẤT CẢ TỔ HỢP
        List<Map<String, Object>> ketQuaTatCaToHop = new ArrayList<>();

        Map<String, Double> diemTheoMa = taoMapDiemTheoMa(
            dToan, dVan, dAnh, dLy, dHoa, dSinh, dSu, dDia,
            dCNCN, dCNNN, dTI, dKTPL,
            dNK1, dNK2, dNK3, dNK4, dNK5, dNK6
        );

        for (ToHopMonThi th : danhSachToHop) {
            Double diemMon1 = getDiemTheoMa(th.getThMon1(), diemTheoMa);
            Double diemMon2 = getDiemTheoMa(th.getThMon2(), diemTheoMa);
            Double diemMon3 = getDiemTheoMa(th.getThMon3(), diemTheoMa);

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

            double tongDiemXetTuyenLamTron = lamTron2So(tongDiemXetTuyen);
            tongDiemXetTuyenLamTron = Math.min(30.0, tongDiemXetTuyenLamTron);

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
            kqToHop.put("congThucDiemUuTien", taoCongThucDiemUuTien(diemNenXetTuyen, diemCong, diemUuTienGoc, diemUuTienSauDieuChinh));
            
            kqToHop.put("diemNenXetTuyen", lamTron2So(diemNenXetTuyen));
            kqToHop.put("diemUuTienSauDieuChinh", lamTron2So(diemUuTienSauDieuChinh));
            kqToHop.put("tongDiemXetTuyen", tongDiemXetTuyenLamTron); // Điểm chốt hạ

            kqToHop.put("diemChuan", diemChuan);
            kqToHop.put("datDiemChuan", (diemChuan == null || tongDiemXetTuyenLamTron >= diemChuan));

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
    private Map<String, Double> taoMapDiemTheoMa(
            Double dToan,
            Double dVan,
            Double dAnh,
            Double dLy,
            Double dHoa,
            Double dSinh,
            Double dSu,
            Double dDia,
            Double dCNCN,
            Double dCNNN,
            Double dTI,
            Double dKTPL,
            Double dNK1,
            Double dNK2,
            Double dNK3,
            Double dNK4,
            Double dNK5,
            Double dNK6
    ) {
        Map<String, Double> diemTheoMa = new HashMap<>();
        diemTheoMa.put("TO", dToan);
        diemTheoMa.put("VA", dVan);
        diemTheoMa.put("N1", dAnh);
        diemTheoMa.put("LI", dLy);
        diemTheoMa.put("HO", dHoa);
        diemTheoMa.put("SI", dSinh);
        diemTheoMa.put("SU", dSu);
        diemTheoMa.put("DI", dDia);

        diemTheoMa.put("CNCN", dCNCN);
        diemTheoMa.put("CNNN", dCNNN);
        diemTheoMa.put("TI", dTI);
        diemTheoMa.put("KTPL", dKTPL);

        diemTheoMa.put("NK1", dNK1);
        diemTheoMa.put("NK2", dNK2);
        diemTheoMa.put("NK3", dNK3);
        diemTheoMa.put("NK4", dNK4);
        diemTheoMa.put("NK5", dNK5);
        diemTheoMa.put("NK6", dNK6);
        return diemTheoMa;
    }

    private Double getDiemTheoMa(String maMon, Map<String, Double> diemTheoMa) {
        if (maMon == null || maMon.trim().isEmpty() || diemTheoMa == null) return null;

        switch (maMon.trim().toUpperCase()) {
            case "TO":
            case "TOÁN":
                return diemTheoMa.get("TO");
            case "VA":
            case "VĂN":
                return diemTheoMa.get("VA");

            // THÊM MÃ "N1" VÀO DÒNG NÀY ĐỂ NÓ NHẬN DIỆN MÔN TIẾNG ANH NHÉ ĐỆ TỬ
            case "AN":
            case "ANH":
            case "N1":
                return diemTheoMa.get("N1");

            case "LI":
            case "LÍ":
            case "LÝ":
                return diemTheoMa.get("LI");
            case "HO":
            case "HÓA":
                return diemTheoMa.get("HO");
            case "SI":
            case "SINH":
                return diemTheoMa.get("SI");
            case "SU":
            case "SỬ":
                return diemTheoMa.get("SU");
            case "DI":
            case "ĐỊA":
                return diemTheoMa.get("DI");

            case "CNCN":
                return diemTheoMa.get("CNCN");
            case "CNNN":
                return diemTheoMa.get("CNNN");
            case "TI":
                return diemTheoMa.get("TI");
            case "KTPL":
                return diemTheoMa.get("KTPL");

            case "NK1":
                return diemTheoMa.get("NK1");
            case "NK2":
                return diemTheoMa.get("NK2");
            case "NK3":
                return diemTheoMa.get("NK3");
            case "NK4":
                return diemTheoMa.get("NK4");
            case "NK5":
                return diemTheoMa.get("NK5");
            case "NK6":
                return diemTheoMa.get("NK6");

            default:
                return null;
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

    private String taoCongThucDiemUuTien(double diemNenXetTuyen, double diemCong, double diemUuTienGoc, double diemUuTienSauDieuChinh) {
        double diemNenCong = diemNenXetTuyen + diemCong;
        if (diemUuTienGoc <= 0) {
            return "Không có điểm ưu tiên nên điểm ưu tiên áp dụng = 0.00";
        }
        if (diemNenCong < 22.5) {
            return String.format("Vì (%s + %s) = %s < 22.50 nên cộng ưu tiên bình thường: %s",
                    fmt(diemNenXetTuyen), fmt(diemCong), fmt(diemNenCong), fmt(diemUuTienSauDieuChinh));
        }

        double heSoDieuChinh = Math.max(0.0, (30.0 - diemNenCong) / 7.5);
        return String.format("Điểm ưu tiên điều chỉnh = ((30 - %s - %s) / 7.5) x %s = %s",
                fmt(diemNenXetTuyen), fmt(diemCong), fmt(diemUuTienGoc), fmt(heSoDieuChinh * diemUuTienGoc));
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