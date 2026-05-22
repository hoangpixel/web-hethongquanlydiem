package com.sgu.tuyensinh.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

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

    public Page<NguyenVongXetTuyen> getNguyenVongByThiSinhFilter(
            String cccd,
            String nganh,
            String tohop,
            String sort,
            String trangThai,
            int page,
            int size) {

        Sort sorting = Sort.unsorted();

        if ("asc".equalsIgnoreCase(sort)) {
            sorting = Sort.by("diemXetTuyen").ascending();
        } else if ("desc".equalsIgnoreCase(sort)) {
            sorting = Sort.by("diemXetTuyen").descending();
        }

        Pageable pageable = PageRequest.of(page, size, sorting);

        boolean hasNganh      = nganh      != null && !nganh.isBlank();
        boolean hasToHop      = tohop      != null && !tohop.isBlank();
        boolean hasTrangThai  = trangThai  != null && !trangThai.isBlank();
        boolean isKhongXet    = "Không xét".equals(trangThai);

        // ── Filter kết hợp tất cả tham số ──
        if (hasTrangThai) {
            if (isKhongXet) {
                // "Không xét": nvKetQua IS NULL hoặc không phải 3 giá trị chuẩn
                if (hasNganh && hasToHop) {
                    return nguyenVongRepository.findByNnCccdAndNvMaNganhAndTtThmAndKhongXet(cccd, nganh, tohop, pageable);
                } else if (hasNganh) {
                    return nguyenVongRepository.findByNnCccdAndNvMaNganhAndKhongXet(cccd, nganh, pageable);
                } else if (hasToHop) {
                    return nguyenVongRepository.findByNnCccdAndTtThmAndKhongXet(cccd, tohop, pageable);
                } else {
                    return nguyenVongRepository.findByNnCccdAndKhongXet(cccd, pageable);
                }
            } else {
                // Trạng thái bình thường: "Đã đậu", "Đã trượt", "Chờ xét"
                if (hasNganh && hasToHop) {
                    return nguyenVongRepository.findByNnCccdAndNvMaNganhAndTtThmAndNvKetQua(cccd, nganh, tohop, trangThai, pageable);
                } else if (hasNganh) {
                    return nguyenVongRepository.findByNnCccdAndNvMaNganhAndNvKetQua(cccd, nganh, trangThai, pageable);
                } else if (hasToHop) {
                    return nguyenVongRepository.findByNnCccdAndTtThmAndNvKetQua(cccd, tohop, trangThai, pageable);
                } else {
                    return nguyenVongRepository.findByNnCccdAndNvKetQua(cccd, trangThai, pageable);
                }
            }
        }

        // ── Không có filter trạng thái ──
        if (hasNganh && hasToHop) {
            return nguyenVongRepository.findByNnCccdAndNvMaNganhAndTtThm(cccd, nganh, tohop, pageable);
        }
        if (hasNganh) {
            return nguyenVongRepository.findByNnCccdAndNvMaNganh(cccd, nganh, pageable);
        }
        if (hasToHop) {
            return nguyenVongRepository.findByNnCccdAndTtThm(cccd, tohop, pageable);
        }

        return nguyenVongRepository.findByNnCccd(cccd, pageable);
    }

    public List<NguyenVongXetTuyen> getAllNguyenVongByThiSinh(String cccd) {
        return nguyenVongRepository.findAllByCccd(cccd);
    }
}