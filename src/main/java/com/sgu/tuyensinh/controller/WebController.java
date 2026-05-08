package com.sgu.tuyensinh.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sgu.tuyensinh.model.DiemThiSinh;
import com.sgu.tuyensinh.model.Nganh;
import com.sgu.tuyensinh.model.NguyenVongXetTuyen;
import com.sgu.tuyensinh.model.ThiSinh;
import com.sgu.tuyensinh.model.ToHopMonThi;
import com.sgu.tuyensinh.repository.DiemThiSinhRepository;
import com.sgu.tuyensinh.repository.NganhRepository;
import com.sgu.tuyensinh.repository.ToHopMonThiRepository;
import com.sgu.tuyensinh.service.TinhDiemService;
import com.sgu.tuyensinh.service.TuyensinhService;

import jakarta.servlet.http.HttpSession;

@Controller
public class WebController {

    @Autowired
    private TuyensinhService tuyensinhService;

    @Autowired
    private DiemThiSinhRepository diemThiSinhRepository;

    @Autowired
    private NganhRepository nganhRepository;

    @Autowired
    private ToHopMonThiRepository toHopRepository;

    @Autowired
    private TinhDiemService tinhDiemService;

    // 1. KHI NGƯỜI DÙNG GÕ localhost:8080/login -> HIỆN TRANG ĐĂNG NHẬP
    @GetMapping("/login")
    public String hienThiTrangDangNhap() {
        return "login"; // Trả về file login.jsp
    }

    // 2. KHI BẤM NÚT "TRA CỨU KẾT QUẢ" TRÊN FORM
    @PostMapping("/check-login")
    public String xuLyDangNhap(@RequestParam("cccd") String cccd, 
                               @RequestParam("password") String password, 
                               HttpSession session, 
                               Model model) {
        
        // Nhờ Bếp trưởng kiểm tra
        ThiSinh ts = tuyensinhService.kiemTraDangNhap(cccd, password);
        
        if (ts != null) {
            // Lưu thông tin thí sinh vào Session (phiên làm việc) để nhớ là đã đăng nhập
            session.setAttribute("thiSinhDangNhap", ts);
            return "redirect:/ketqua"; // Chuyển hướng sang trang Kết quả
        } else {
            // Báo lỗi nếu sai CCCD hoặc Mật khẩu
            model.addAttribute("error", "Sai số CCCD hoặc mật khẩu. Vui lòng thử lại!");
            return "login"; // Ở lại trang login.jsp và hiện lỗi
        }
    }

    // 3. TRANG HIỂN THỊ BẢNG KẾT QUẢ NGUYỆN VỌNG
  @GetMapping("/ketqua")
public String hienThiTrangKetQua(HttpSession session, Model model,
                                 @RequestParam(defaultValue = "0") int page) {
    ThiSinh ts = (ThiSinh) session.getAttribute("thiSinhDangNhap");
    if (ts == null) return "redirect:/login";

    int size = 10;
    Page<NguyenVongXetTuyen> pageNV = tuyensinhService.getNguyenVongByThiSinh(ts.getCccd(), page, size);
    DiemThiSinh diemTs = diemThiSinhRepository.findByCccd(ts.getCccd());

    // ── Build Map cho từng nguyện vọng ──
    List<Map<String, Object>> danhSachNV = new ArrayList<>();
    for (NguyenVongXetTuyen nv : pageNV.getContent()) {
        danhSachNV.add(buildChiTietMap(nv, diemTs));
    }

    model.addAttribute("thiSinh", ts);
    model.addAttribute("diemThiSinh", diemTs);
    model.addAttribute("danhSachNV", danhSachNV);
    model.addAttribute("currentPage", page);
    model.addAttribute("totalPages", pageNV.getTotalPages());

    return "ketqua";
}

    // 4. KHI BẤM NÚT "ĐĂNG XUẤT"
    @GetMapping("/logout")
    public String xuLyDangXuat(HttpSession session) {
        session.invalidate(); // Xóa sạch trí nhớ
        return "redirect:/login"; // Đuổi về trang chủ
    }

// ══════════════════════════════════════════════
//  BUILD MAP CHI TIẾT
// ══════════════════════════════════════════════    
    private Map<String, Object> buildChiTietMap(NguyenVongXetTuyen nv, DiemThiSinh d) {
        Map<String, Object> map = new LinkedHashMap<>();

        map.put("nvTt",         nv.getNvTt());
        map.put("nvMaNganh",    nv.getNvMaNganh());
        map.put("ttPhuongThuc", nv.getTtPhuongThuc());
        map.put("ttThm",        nv.getTtThm());
        map.put("nvKetQua",     nv.getNvKetQua());
        map.put("diemXetTuyen", nv.getDiemXetTuyen());

        double diemThxt = nv.getDiemThxt()     != null ? nv.getDiemThxt()     : 0.0;
        double diemCong = nv.getDiemCong()     != null ? nv.getDiemCong()     : 0.0;
        double diemUtqd = nv.getDiemUtqd()     != null ? nv.getDiemUtqd()     : 0.0;
        double diemXt   = nv.getDiemXetTuyen() != null ? nv.getDiemXetTuyen() : 0.0;

        Nganh nganh = nganhRepository.findByMaNganh(nv.getNvMaNganh());
        String toHopGoc = (nganh != null && nganh.getToHopGoc() != null)
                          ? nganh.getToHopGoc()
                          : nv.getTtThm();

        String toHopThi = nv.getTtThm() != null ? nv.getTtThm().trim().toUpperCase() : "";
        String toHopGocStr = toHopGoc.trim().toUpperCase();

        double mucDoLech = getMucDoLech(toHopGocStr, toHopThi);
        double diemThgxtTinh = lamTron2(diemThxt - mucDoLech);

        map.put("toHopGoc",   toHopGoc);
        map.put("diemThxt",   diemThxt);
        map.put("diemThgxt",  diemThgxtTinh);
        map.put("diemCong",   diemCong);
        map.put("diemUtqd",   diemUtqd);
        map.put("mLechDiem",  mucDoLech);

        String pt = nv.getTtPhuongThuc() != null ? nv.getTtPhuongThuc().toUpperCase() : "";

        // "XÉT THPT", "ĐÁNH GIÁ V-SAT", "ĐGNL HCM"
        boolean isDGNL = pt.contains("DGNL") || pt.contains("ĐGNL");
        boolean isVSAT = pt.contains("V-SAT") || pt.contains("VSAT");

        if (!isDGNL) {
            if (isVSAT) {
                map.put("danhSachMonJson", buildMonJsonVSAT(nv.getNvMaNganh(), nv.getTtThm(), d));
            } else {
                map.put("danhSachMonJson", buildMonJson(nv.getNvMaNganh(), nv.getTtThm(), d));
            }
            map.put("mocQuyDoi",       "");
            map.put("congThucTongQuat","");
            map.put("congThucThaySo",  "");
            map.put("ghiChu",          "");
            map.put("diemDauVao",      0.0);
        } else {
            map.put("danhSachMonJson", "[]");

            // Lấy chi tiết nội suy ĐGNL
            double diemDGNLRaw = d != null && d.getNangLuc() != null ? d.getNangLuc() : 0.0;
            TinhDiemService.KetQuaQuyDoiChiTiet ct =
                tinhDiemService.quyDoiDiemDGNLChiTiet(nv.getTtThm(), diemDGNLRaw);

            map.put("diemDauVao",       diemDGNLRaw);
            map.put("mocQuyDoi",        ct.getMocQuyDoi()        != null ? ct.getMocQuyDoi()        : "");
            map.put("congThucTongQuat", ct.getCongThucTongQuat() != null ? ct.getCongThucTongQuat() : "");
            map.put("congThucThaySo",   ct.getCongThucThaySo()   != null ? ct.getCongThucThaySo()   : "");
            map.put("ghiChu",           ct.getGhiChu()           != null ? ct.getGhiChu()           : "");
        }
        return map;
    }

    // ══════════════════════════════════════════════
    //  BUILD JSON MÔN — CHỈ LẤY TỪ DB
    // ══════════════════════════════════════════════
    private String buildMonJson(String maNganh, String toHop, DiemThiSinh d) {
        if (d == null || toHop == null || maNganh == null) return "[]";

        // Bảng xt_nganh_tohop chỉ lưu mã gốc, không có -CLC
        String maNganhGoc = maNganh.replaceAll("(?i)-CLC.*$", "").trim();

        // Tìm theo ngành + tổ hợp từ DB
        ToHopMonThi th = toHopRepository.findByMaNganhAndMaToHop(maNganhGoc, toHop);

        if (th == null) {
            // Không có trong DB → trả về JSON báo lỗi để JS hiển thị thông báo
            return "{\"error\":\"Không tìm thấy tổ hợp " + toHop + " cho ngành " + maNganh + " trong hệ thống\"}";
        }

        return toJson(
            th.getThMon1(), getDiemTheoMa(th.getThMon1(), d), th.getHsMon1().intValue(),
            th.getThMon2(), getDiemTheoMa(th.getThMon2(), d), th.getHsMon2().intValue(),
            th.getThMon3(), getDiemTheoMa(th.getThMon3(), d), th.getHsMon3().intValue()
        );
    }

    private String toJson(String t1, Double d1, int h1,
                        String t2, Double d2, int h2,
                        String t3, Double d3, int h3) {
        // Dùng &quot; thay cho " để không vỡ HTML attribute
        return String.format(
            "[{&quot;ten&quot;:&quot;%s&quot;,&quot;diem&quot;:%s,&quot;heSo&quot;:%d},"
        + "{&quot;ten&quot;:&quot;%s&quot;,&quot;diem&quot;:%s,&quot;heSo&quot;:%d},"
        + "{&quot;ten&quot;:&quot;%s&quot;,&quot;diem&quot;:%s,&quot;heSo&quot;:%d}]",
            t1, d1 != null ? d1 : 0, h1,
            t2, d2 != null ? d2 : 0, h2,
            t3, d3 != null ? d3 : 0, h3
        );
    }

    private String buildMonJsonVSAT(String maNganh, String toHop, DiemThiSinh d) {
        if (d == null || toHop == null || maNganh == null) return "[]";

        String maNganhGoc = maNganh.replaceAll("(?i)-CLC.*$", "").trim();
        ToHopMonThi th = toHopRepository.findByMaNganhAndMaToHop(maNganhGoc, toHop);

        if (th == null) {
            return "{\"error\":\"Không tìm thấy tổ hợp " + toHop + " cho ngành " + maNganh + "\"}";
        }

        String[] maMons = { th.getThMon1(), th.getThMon2(), th.getThMon3() };
        int[]    heSos  = { th.getHsMon1().intValue(), th.getHsMon2().intValue(), th.getHsMon3().intValue() };

        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < 3; i++) {
            String maMon = maMons[i];
            Double diemTho = getDiemTheoMa(maMon, d);   // điểm thô V-SAT (VD: 88.5)
            double diemThoVal = diemTho != null ? diemTho : 0.0;

            // Gọi nội suy để lấy chi tiết
            TinhDiemService.KetQuaQuyDoiChiTiet ct =
                    tinhDiemService.quyDoiDiemVSATChiTiet(maMon, diemThoVal);

            double diemQD = ct.getDiemQuyDoi() != null ? ct.getDiemQuyDoi() : 0.0;
            String moc    = ct.getMocQuyDoi()       != null ? ct.getMocQuyDoi().replace("\"", "&quot;")       : "";
            String tq     = ct.getCongThucTongQuat() != null ? ct.getCongThucTongQuat().replace("\"", "&quot;") : "";
            String ts     = ct.getCongThucThaySo()   != null ? ct.getCongThucThaySo().replace("\"", "&quot;")  : "";
            String gc     = ct.getGhiChu()           != null ? ct.getGhiChu().replace("\"", "&quot;")          : "";

            if (i > 0) sb.append(",");
            sb.append(String.format(
                "{&quot;ten&quot;:&quot;%s&quot;," +
                "&quot;diemTho&quot;:%s," +
                "&quot;diem&quot;:%s," +
                "&quot;heSo&quot;:%d," +
                "&quot;mocQuyDoi&quot;:&quot;%s&quot;," +
                "&quot;congThucTongQuat&quot;:&quot;%s&quot;," +
                "&quot;congThucThaySo&quot;:&quot;%s&quot;," +
                "&quot;ghiChu&quot;:&quot;%s&quot;}",
                maMon,
                fmt(diemThoVal),
                fmt(diemQD),
                heSos[i],
                moc, tq, ts, gc
            ));
        }
        sb.append("]");
        return sb.toString();
    }

    private Double getDiemTheoMa(String maMon, DiemThiSinh d) {
        if (maMon == null || d == null) return null;
        switch (maMon.trim().toUpperCase()) {
            case "TO": case "TOÁN":            return d.getToan();
            case "VA": case "VĂN":             return d.getVan();
            case "AN": case "ANH": case "N1":  {
                // Lấy cái nào lớn hơn giữa điểm thi và điểm chứng chỉ
                Double diemThi = d.getNgoaiNguThi();
                Double diemCc  = d.getNgoaiNguCc();
                if (diemThi == null && diemCc == null) return null;
                if (diemThi == null) return diemCc;
                if (diemCc  == null) return diemThi;
                return Math.max(diemThi, diemCc);
            }
            case "LI": case "LÍ": case "LÝ":  return d.getLy();
            case "HO": case "HÓA":             return d.getHoa();
            case "SI": case "SINH":            return d.getSinh();
            case "SU": case "SỬ":              return d.getSu();
            case "DI": case "ĐỊA":             return d.getDia();
            default: return null;
        }
    }

    private static final Map<String, Map<String, Double>> BANG_DO_LECH;
    static {
        BANG_DO_LECH = new LinkedHashMap<>();

        // Hàng A00 (tổ hợp gốc = A00)
        Map<String, Double> a00 = new LinkedHashMap<>();
        a00.put("A00",  0.00);
        a00.put("A01", -0.69);
        a00.put("B00", -1.21);
        a00.put("C00", +2.32);
        a00.put("C01", +0.94);
        a00.put("D01", -0.68);
        a00.put("D07", -1.62);
        BANG_DO_LECH.put("A00", a00);

        // Hàng A01
        Map<String, Double> a01 = new LinkedHashMap<>();
        a01.put("A00", +0.69);
        a01.put("A01",  0.00);
        a01.put("B00", -0.52);
        a01.put("C00", +3.01);
        a01.put("C01", +1.63);
        a01.put("D01", +0.01);
        a01.put("D07", -0.93);
        BANG_DO_LECH.put("A01", a01);

        // Hàng B00
        Map<String, Double> b00 = new LinkedHashMap<>();
        b00.put("A00", +1.21);
        b00.put("A01", +0.52);
        b00.put("B00",  0.00);
        b00.put("C00", +3.53);
        b00.put("C01", +2.15);
        b00.put("D01", +0.53);
        b00.put("D07", -0.41);
        BANG_DO_LECH.put("B00", b00);

        // Hàng C00
        Map<String, Double> c00 = new LinkedHashMap<>();
        c00.put("A00", -2.32);
        c00.put("A01", -3.01);
        c00.put("B00", -3.53);
        c00.put("C00",  0.00);
        c00.put("C01", -1.38);
        c00.put("D01", -3.00);
        c00.put("D07", -3.94);
        BANG_DO_LECH.put("C00", c00);

        // Hàng C01
        Map<String, Double> c01 = new LinkedHashMap<>();
        c01.put("A00", -0.94);
        c01.put("A01", -1.63);
        c01.put("B00", -2.15);
        c01.put("C00", +1.38);
        c01.put("C01",  0.00);
        c01.put("D01", -1.62);
        c01.put("D07", -2.56);
        BANG_DO_LECH.put("C01", c01);

        // Hàng D01
        Map<String, Double> d01 = new LinkedHashMap<>();
        d01.put("A00", +0.68);
        d01.put("A01", -0.01);
        d01.put("B00", -0.53);
        d01.put("C00", +3.00);
        d01.put("C01", +1.62);
        d01.put("D01",  0.00);
        d01.put("D07", -0.94);
        BANG_DO_LECH.put("D01", d01);
    }

    private double getMucDoLech(String toHopGoc, String toHopThi) {
        if (toHopGoc == null || toHopThi == null) return 0.0;
        String goc = toHopGoc.trim().toUpperCase();
        String thi = toHopThi.trim().toUpperCase();
        Map<String, Double> hang = BANG_DO_LECH.get(goc);
        if (hang == null) return 0.0;
        return hang.getOrDefault(thi, 0.0);
    }

    private double lamTron2(double v) {
        return Math.round(v * 100.0) / 100.0;
    }
    
    private String fmt(double value) {
        return String.format("%.2f", value);
    }

}