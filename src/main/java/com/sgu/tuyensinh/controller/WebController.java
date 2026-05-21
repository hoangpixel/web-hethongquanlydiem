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

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sgu.tuyensinh.model.DiemCongXetTuyen;
import com.sgu.tuyensinh.model.DiemThiSinh;
import com.sgu.tuyensinh.model.GiaiThuong;
import com.sgu.tuyensinh.model.Nganh;
import com.sgu.tuyensinh.model.NguyenVongXetTuyen;
import com.sgu.tuyensinh.model.ThiSinh;
import com.sgu.tuyensinh.model.ToHopMonThi;
import com.sgu.tuyensinh.repository.DiemCongXetTuyenRepository;
import com.sgu.tuyensinh.repository.DiemThiSinhRepository;
import com.sgu.tuyensinh.repository.GiaiThuongRepository;
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

    @Autowired
    private GiaiThuongRepository giaiThuongRepository;
    
    @Autowired
    private DiemCongXetTuyenRepository diemCongXetTuyenRepository;

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
                                 @RequestParam(defaultValue = "0") int page,
                                 @RequestParam(required = false) String nganh,
                                 @RequestParam(required = false) String tohop,
                                 @RequestParam(required = false) String sort) {
    ThiSinh ts = (ThiSinh) session.getAttribute("thiSinhDangNhap");
    if (ts == null) return "redirect:/login";

    int size = 10;
    Page<NguyenVongXetTuyen> pageNV =
    tuyensinhService.getNguyenVongByThiSinhFilter(
        ts.getCccd(),
        nganh,
        tohop,
        sort,
        page,
        size
    );
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

        model.addAttribute("nganhFilter", nganh);
        model.addAttribute("tohopFilter", tohop);
        model.addAttribute("sortFilter", sort);

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
        double diemCong = layDiemCongTuBangDiemCong(nv, d);
        double diemUtqd = nv.getDiemUtqd()     != null ? nv.getDiemUtqd()     : 0.0;
        double diemXt   = nv.getDiemXetTuyen() != null ? nv.getDiemXetTuyen() : 0.0;

        Nganh nganh = nganhRepository.findByMaNganh(nv.getNvMaNganh());
        String toHopGoc = (nganh != null && nganh.getToHopGoc() != null)
                        ? nganh.getToHopGoc()
                        : nv.getTtThm();

        String toHopXetTuyen = nv.getTtThm();

        double mucDoLech = 0.0;

        if (toHopXetTuyen != null && toHopGoc != null
                && !toHopXetTuyen.trim().equalsIgnoreCase(toHopGoc.trim())) {

            mucDoLech = getMucDoLech(nv.getNvMaNganh(), toHopXetTuyen);
        }

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
        boolean isTuyenThang = pt.contains("TUYỂN THẲNG") || pt.contains("TUYEN THANG");

        if (isTuyenThang) {
            // Lấy danh sách giải thưởng theo cccd
            List<GiaiThuong> dsGiai = giaiThuongRepository.findByCccd(
                d != null ? d.getCccd() : ""
            );
            map.put("danhSachMonJson",  "[]");
            map.put("danhSachGiaiJson", buildGiaiThuongJson(dsGiai));
            map.put("mocQuyDoi",        "");
            map.put("congThucTongQuat", "");
            map.put("congThucThaySo",   "");
            map.put("ghiChu",           "");
            map.put("diemDauVao",       0.0);
        } else if (!isDGNL) {
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

        String maNganhGoc = maNganh.replaceAll("(?i)-CLC.*$", "").trim();
        ToHopMonThi th = toHopRepository.findByMaNganhAndMaToHop(maNganhGoc, toHop);

        if (th == null) {
            return "{\"error\":\"Không tìm thấy tổ hợp " + toHop + " cho ngành " + maNganh + " trong hệ thống\"}";
        }

        String[] maMons = { th.getThMon1(), th.getThMon2(), th.getThMon3() };
        int[]    heSos  = { th.getHsMon1().intValue(), th.getHsMon2().intValue(), th.getHsMon3().intValue() };

        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < 3; i++) {
            String maMon = maMons[i];
            boolean isNN = isNgoaiNgu(maMon);

            Double diemThi = isNN ? d.getNgoaiNguThi() : null;
            Double diemCc  = isNN ? d.getNgoaiNguCc()  : null;
            Double diem    = getDiemTheoMa(maMon, d);

            if (i > 0) sb.append(",");
            sb.append("{");
            sb.append("&quot;ten&quot;:&quot;").append(maMon).append("&quot;,");
            sb.append("&quot;diem&quot;:").append(diem != null ? fmt(diem) : "0").append(",");
            sb.append("&quot;heSo&quot;:").append(heSos[i]).append(",");
            sb.append("&quot;isNgoaiNgu&quot;:").append(isNN).append(",");
            if (isNN) {
                sb.append("&quot;diemThi&quot;:").append(diemThi != null ? fmt(diemThi) : "null").append(",");
                sb.append("&quot;diemCc&quot;:").append(diemCc  != null ? fmt(diemCc)  : "null").append(",");
                boolean ccWins = (diemCc != null) && (diemThi == null || diemCc > diemThi);
                sb.append("&quot;ccDuocChon&quot;:").append(ccWins);
            } else {
                sb.append("&quot;diemThi&quot;:null,");
                sb.append("&quot;diemCc&quot;:null,");
                sb.append("&quot;ccDuocChon&quot;:false");
            }
            sb.append("}");
        }
        sb.append("]");
        return sb.toString();
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

    private String buildGiaiThuongJson(List<GiaiThuong> list) {
        if (list == null || list.isEmpty()) return "[]";
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            GiaiThuong g = list.get(i);
            if (i > 0) sb.append(",");
            sb.append("{")
            .append("\"capGiai\":\"").append(escapeJson(g.getCapGiai())).append("\",")
            .append("\"doiTuong\":\"").append(escapeJson(g.getDoiTuong())).append("\",")
            .append("\"maMon\":\"").append(escapeJson(g.getMaMon())).append("\",")
            .append("\"loaiGiai\":\"").append(escapeJson(g.getLoaiGiai())).append("\",")
            .append("\"diemCongCoMon\":").append(g.getDiemCongCoMon() != null ? g.getDiemCongCoMon() : 0).append(",")
            .append("\"diemCongKhongMon\":").append(g.getDiemCongKhongMon() != null ? g.getDiemCongKhongMon() : 0)
            .append("}");
        }
        sb.append("]");
        return java.util.Base64.getEncoder().encodeToString(
            sb.toString().getBytes(java.nio.charset.StandardCharsets.UTF_8)
        );
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

    private double getMucDoLech(String maNganh, String toHopThi) {
        if (maNganh == null || toHopThi == null) return 0.0;

        String maNganhGoc = maNganh.replaceAll("(?i)-CLC.*$", "").trim();
        ToHopMonThi row = toHopRepository.findByMaNganhAndMaToHop(maNganhGoc, toHopThi.trim().toUpperCase());
        
        if (row == null || row.getDoLech() == null) return 0.0;
        return row.getDoLech();
    }

    private double lamTron2(double v) {
        return Math.round(v * 100.0) / 100.0;
    }
    
    private String fmt(double value) {
        return String.format("%.2f", value);
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }

    // Helper nhận diện môn ngoại ngữ
    private boolean isNgoaiNgu(String maMon) {
        if (maMon == null) return false;
        switch (maMon.trim().toUpperCase()) {
            case "AN": case "ANH": case "N1": return true;
            default: return false;
        }
    }

    private double layDiemCongTuBangDiemCong(NguyenVongXetTuyen nv, DiemThiSinh d) {
        if (nv == null || d == null) {
            return 0.0;
        }

        DiemCongXetTuyen dc = diemCongXetTuyenRepository
                .findByCccdAndMaNganhAndMaToHopAndPhuongThuc(
                        d.getCccd(),
                        nv.getNvMaNganh(),
                        nv.getTtThm(),
                        nv.getTtPhuongThuc()
                );

        return dc != null && dc.getDiemTong() != null
                ? dc.getDiemTong()
                : 0.0;
    }
}