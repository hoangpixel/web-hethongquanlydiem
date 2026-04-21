package com.sgu.tuyensinh.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sgu.tuyensinh.model.DiemThiSinh;
import com.sgu.tuyensinh.model.NguyenVongXetTuyen;
import com.sgu.tuyensinh.model.ThiSinh;
import com.sgu.tuyensinh.repository.DiemThiSinhRepository;
import com.sgu.tuyensinh.service.TuyensinhService;

import jakarta.servlet.http.HttpSession;

@Controller
public class WebController {

    @Autowired
    private TuyensinhService tuyensinhService;

    @Autowired
    private DiemThiSinhRepository diemThiSinhRepository;

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
    public String hienThiTrangKetQua(HttpSession session, Model model) {
        // Kiểm tra xem đã đăng nhập chưa, chưa thì đuổi về trang login
        ThiSinh ts = (ThiSinh) session.getAttribute("thiSinhDangNhap");
        if (ts == null) {
            return "redirect:/login"; 
        }

        // Lấy danh sách nguyện vọng từ DB
        List<NguyenVongXetTuyen> danhSachNV = tuyensinhService.layDanhSachNguyenVong(ts.getCccd());

        DiemThiSinh diemThiSinh = diemThiSinhRepository.findByCccd(ts.getCccd());
        model.addAttribute("diemThiSinh", diemThiSinh);

        // Đóng gói đẩy ra file ketqua.jsp
        model.addAttribute("thiSinh", ts);
        model.addAttribute("danhSachNV", danhSachNV);

        return "ketqua"; // Trả về file ketqua.jsp
    }

    // 4. KHI BẤM NÚT "ĐĂNG XUẤT"
    @GetMapping("/logout")
    public String xuLyDangXuat(HttpSession session) {
        session.invalidate(); // Xóa sạch trí nhớ
        return "redirect:/login"; // Đuổi về trang chủ
    }
}