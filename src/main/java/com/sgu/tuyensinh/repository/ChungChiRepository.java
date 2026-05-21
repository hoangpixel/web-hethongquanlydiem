package com.sgu.tuyensinh.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sgu.tuyensinh.model.ChungChi;

public interface ChungChiRepository extends JpaRepository<ChungChi, Integer> {

    ChungChi findTopByCccdOrderByDiemQuydoiDesc(String cccd);

}