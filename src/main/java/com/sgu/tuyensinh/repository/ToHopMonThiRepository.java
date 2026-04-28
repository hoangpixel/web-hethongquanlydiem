package com.sgu.tuyensinh.repository;

import com.sgu.tuyensinh.model.ToHopMonThi;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ToHopMonThiRepository extends JpaRepository<ToHopMonThi, Integer> {
    
    // Tìm cấu trúc môn và hệ số dựa vào Mã ngành và Mã tổ hợp
    ToHopMonThi findByMaNganhAndMaToHop(String maNganh, String maToHop);
}