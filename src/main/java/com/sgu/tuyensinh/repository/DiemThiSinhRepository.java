package com.sgu.tuyensinh.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sgu.tuyensinh.model.DiemThiSinh;

public interface DiemThiSinhRepository extends JpaRepository<DiemThiSinh, Integer> {

    DiemThiSinh findByCccd(String cccd);

}