package com.sgu.tuyensinh.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
import com.sgu.tuyensinh.service.TuyensinhService;

import jakarta.servlet.http.HttpSession;
import javax.imageio.ImageIO;

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

    // 1. KHI NGƯỜI DÙNG GÕ localhost:8080/login -> HIỆN TRANG ĐĂNG NHẬP
    @GetMapping("/login")
    public String hienThiTrangDangNhap() {
        return "login"; // Trả về file login.jsp
    }

    @GetMapping("/captcha.png")
    public ResponseEntity<byte[]> taoCaptcha(HttpSession session) {
        String captchaText = taoMaCaptcha(5);
        session.setAttribute("captcha", captchaText);

        BufferedImage image = veCaptcha(captchaText);
        byte[] bytes = ghiAnhPng(image);

        return ResponseEntity.ok()
                .header(HttpHeaders.CACHE_CONTROL, "no-store, no-cache, must-revalidate, max-age=0")
                .header(HttpHeaders.PRAGMA, "no-cache")
                .contentType(MediaType.IMAGE_PNG)
                .body(bytes);
    }

    // 2. KHI BẤM NÚT "TRA CỨU KẾT QUẢ" TRÊN FORM
    @PostMapping("/check-login")
    public String xuLyDangNhap(@RequestParam("cccd") String cccd, 
                               @RequestParam("ngaySinh") String ngaySinh,
                               @RequestParam("captcha") String captcha,
                               HttpSession session, 
                               Model model) {
        String captchaSession = (String) session.getAttribute("captcha");
        if (captchaSession == null || captcha == null
                || !captchaSession.equalsIgnoreCase(captcha.trim())) {
            model.addAttribute("error", "Sai CAPTCHA. Vui lòng thử lại!");
            return "login";
        }

        // Nhờ Bếp trưởng kiểm tra
        ThiSinh ts = tuyensinhService.kiemTraDangNhap(cccd, ngaySinh);
        
        if (ts != null) {
            // Lưu thông tin thí sinh vào Session (phiên làm việc) để nhớ là đã đăng nhập
            session.setAttribute("thiSinhDangNhap", ts);
            return "redirect:/ketqua"; // Chuyển hướng sang trang Kết quả
        } else {
            // Báo lỗi nếu sai CCCD hoặc Mật khẩu
            model.addAttribute("error", "Sai số CCCD hoặc ngày sinh. Vui lòng thử lại!");
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

    private String taoMaCaptcha(int length) {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    private BufferedImage veCaptcha(String text) {
        int width = 180;
        int height = 56;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        g.setColor(new Color(245, 247, 250));
        g.fillRect(0, 0, width, height);
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        SecureRandom random = new SecureRandom();
        for (int i = 0; i < 8; i++) {
            g.setColor(new Color(180 + random.nextInt(60), 180 + random.nextInt(60), 180 + random.nextInt(60)));
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            int x2 = random.nextInt(width);
            int y2 = random.nextInt(height);
            g.drawLine(x1, y1, x2, y2);
        }

        g.setFont(new Font("Arial", Font.BOLD, 32));
        g.setColor(new Color(40, 55, 71));
        int x = 18;
        for (char c : text.toCharArray()) {
            int y = 38 + random.nextInt(6);
            g.drawString(String.valueOf(c), x, y);
            x += 28 + random.nextInt(4);
        }

        g.dispose();
        return image;
    }

    private byte[] ghiAnhPng(BufferedImage image) {
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(image, "png", baos);
            return baos.toByteArray();
        } catch (Exception ex) {
            return new byte[0];
        }
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
System.out.println("=== DEBUG ===");
System.out.println("maNganh query: [" + nv.getNvMaNganh() + "]");
System.out.println("nganh found: " + (nganh != null ? nganh.getMaNganh() : "NULL"));
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
        if (!isDGNL) {
            map.put("danhSachMonJson", buildMonJson(nv.getNvMaNganh(), nv.getTtThm(), d));
        } else {
            map.put("danhSachMonJson", "[]");
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

    private Double getDiemTheoMa(String maMon, DiemThiSinh d) {
        if (maMon == null || d == null) return null;
        switch (maMon.trim().toUpperCase()) {
            case "TO": case "TOÁN":            return d.getToan();
            case "VA": case "VĂN":             return d.getVan();
            case "AN": case "ANH": case "N1":  return d.getNgoaiNguThi();
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
}