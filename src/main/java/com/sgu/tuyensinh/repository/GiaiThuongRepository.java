package com.sgu.tuyensinh.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sgu.tuyensinh.model.GiaiThuong;

public interface GiaiThuongRepository extends JpaRepository<GiaiThuong, Integer> {
    List<GiaiThuong> findByCccd(String cccd);
}