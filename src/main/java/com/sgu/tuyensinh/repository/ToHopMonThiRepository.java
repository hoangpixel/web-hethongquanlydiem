package com.sgu.tuyensinh.repository;

import com.sgu.tuyensinh.model.ToHopMonThi;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List; // NHỚ THÊM DÒNG NÀY NHA ĐỆ TỬ

public interface ToHopMonThiRepository extends JpaRepository<ToHopMonThi, Integer> {
    
    // Hàm cũ: Tìm 1 tổ hợp cụ thể
    ToHopMonThi findByMaNganhAndMaToHop(String maNganh, String maToHop);

    // HÀM MỚI SƯ PHỤ THÊM VÀO: Lấy TẤT CẢ tổ hợp của một ngành
    List<ToHopMonThi> findByMaNganh(String maNganh);
}