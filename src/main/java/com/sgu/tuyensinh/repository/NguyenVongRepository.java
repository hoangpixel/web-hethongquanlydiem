package com.sgu.tuyensinh.repository;

import com.sgu.tuyensinh.model.NguyenVongXetTuyen;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface NguyenVongRepository extends JpaRepository<NguyenVongXetTuyen, Integer> {
    // Tự động gom toàn bộ nguyện vọng của thằng CCCD này, sắp xếp theo Thứ tự NV tăng dần (1, 2, 3...)
    List<NguyenVongXetTuyen> findByNnCccdOrderByNvTtAsc(String nnCccd);
}