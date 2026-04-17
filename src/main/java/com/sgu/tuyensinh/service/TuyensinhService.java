package com.sgu.tuyensinh.service;

import com.sgu.tuyensinh.model.NguyenVongXetTuyen;
import com.sgu.tuyensinh.model.ThiSinh;
import com.sgu.tuyensinh.repository.NguyenVongRepository;
import com.sgu.tuyensinh.repository.ThiSinhRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TuyensinhService {

    @Autowired
    private ThiSinhRepository thiSinhRepository;

    @Autowired
    private NguyenVongRepository nguyenVongRepository;

    // Hàm kiểm tra Đăng nhập
    public ThiSinh kiemTraDangNhap(String cccd, String matKhau) {
        ThiSinh ts = thiSinhRepository.findByCccd(cccd);
        // Nếu tìm thấy thí sinh VÀ mật khẩu khớp nhau
        if (ts != null && ts.getPassword().equals(matKhau)) {
            return ts; // Đăng nhập thành công
        }
        return null; // Sai thông tin
    }

    // Hàm lấy danh sách Nguyện vọng
    public List<NguyenVongXetTuyen> layDanhSachNguyenVong(String cccd) {
        return nguyenVongRepository.findByNnCccdOrderByNvTtAsc(cccd);
    }
}