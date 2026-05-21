package com.sgu.tuyensinh.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sgu.tuyensinh.model.NguyenVongXetTuyen;

@Repository
public interface NguyenVongRepository extends JpaRepository<NguyenVongXetTuyen, Integer> {
    // Tự động gom toàn bộ nguyện vọng của thằng CCCD này, sắp xếp theo Thứ tự NV tăng dần (1, 2, 3...)
    Page<NguyenVongXetTuyen> findByNnCccdOrderByNvTtAsc(String cccd, PageRequest pageRequest);

    Page<NguyenVongXetTuyen> findByNnCccd(
        String cccd,
        Pageable pageable
    );

    Page<NguyenVongXetTuyen> findByNnCccdAndNvMaNganh(
        String cccd,
        String nvMaNganh,
        Pageable pageable
    );

    Page<NguyenVongXetTuyen> findByNnCccdAndTtThm(
        String cccd,
        String ttThm,
        Pageable pageable
    );

    Page<NguyenVongXetTuyen> findByNnCccdAndNvMaNganhAndTtThm(
        String cccd,
        String nvMaNganh,
        String ttThm,
        Pageable pageable
    );

    @Query("SELECT nv FROM NguyenVongXetTuyen nv WHERE nv.nnCccd = :cccd ORDER BY nv.nvTt ASC")
        List<NguyenVongXetTuyen> findAllByCccd(@Param("cccd") String cccd);
}