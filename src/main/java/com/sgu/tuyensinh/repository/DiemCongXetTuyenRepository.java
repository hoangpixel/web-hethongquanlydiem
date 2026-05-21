package com.sgu.tuyensinh.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sgu.tuyensinh.model.DiemCongXetTuyen;

public interface DiemCongXetTuyenRepository extends JpaRepository<DiemCongXetTuyen, Long> {

    DiemCongXetTuyen findByCccdAndMaNganhAndMaToHopAndPhuongThuc(
            String cccd,
            String maNganh,
            String maToHop,
            String phuongThuc
    );
}