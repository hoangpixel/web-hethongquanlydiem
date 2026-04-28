package com.sgu.tuyensinh.repository;

import com.sgu.tuyensinh.model.Nganh;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NganhRepository extends JpaRepository<Nganh, Integer> {
    // Hàm này sẽ tự động tìm bảng xt_nganh và lấy ra dòng có mã ngành tương ứng
    Nganh findByMaNganh(String maNganh);
}