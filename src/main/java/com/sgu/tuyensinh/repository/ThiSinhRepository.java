package com.sgu.tuyensinh.repository;

import com.sgu.tuyensinh.model.ThiSinh;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ThiSinhRepository extends JpaRepository<ThiSinh, Integer> {
    // Phép thuật của Spring Boot: Nó tự động tạo lệnh SELECT * FROM ... WHERE cccd = ?
    ThiSinh findByCccd(String cccd);
}