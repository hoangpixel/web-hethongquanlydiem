package com.sgu.tuyensinh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import com.sgu.tuyensinh.model.NguyenVongXetTuyen;
import com.sgu.tuyensinh.model.ThiSinh;
import com.sgu.tuyensinh.repository.NguyenVongRepository;
import com.sgu.tuyensinh.repository.ThiSinhRepository;

@Service
public class TuyensinhService {

    @Autowired
    private ThiSinhRepository thiSinhRepository;

    @Autowired
    private NguyenVongRepository nguyenVongRepository;

    // Hàm kiểm tra Đăng nhập
    public ThiSinh kiemTraDangNhap(String cccd, String ngaySinh) {
        ThiSinh ts = thiSinhRepository.findByCccd(cccd);
        if (ts != null && ts.getNgaySinh() != null && ngaySinh != null) {
            try {
                LocalDate inputDate = parseNgaySinh(ngaySinh.trim());
                LocalDate storedDate = ts.getNgaySinh().toLocalDate();
                if (inputDate != null && storedDate.equals(inputDate)) {
                    return ts; // Đăng nhập thành công
                }
            } catch (DateTimeParseException ex) {
                return null;
            }
        }
        return null; // Sai thông tin
    }

    private LocalDate parseNgaySinh(String raw) {
        try {
            return LocalDate.parse(raw, DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        } catch (DateTimeParseException ex) {
            return LocalDate.parse(raw, DateTimeFormatter.ISO_LOCAL_DATE);
        }
    }

    // Hàm lấy danh sách Nguyện vọng
    public Page<NguyenVongXetTuyen> getNguyenVongByThiSinh(String cccd, int page, int size) {
        return nguyenVongRepository.findByNnCccdOrderByNvTtAsc(cccd, PageRequest.of(page, size));
    }
}