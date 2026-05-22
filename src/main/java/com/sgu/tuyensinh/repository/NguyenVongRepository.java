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

    // ── Filter theo trạng thái ──
    Page<NguyenVongXetTuyen> findByNnCccdAndNvKetQua(
        String cccd,
        String nvKetQua,
        Pageable pageable
    );

    Page<NguyenVongXetTuyen> findByNnCccdAndNvMaNganhAndNvKetQua(
        String cccd,
        String nvMaNganh,
        String nvKetQua,
        Pageable pageable
    );

    Page<NguyenVongXetTuyen> findByNnCccdAndTtThmAndNvKetQua(
        String cccd,
        String ttThm,
        String nvKetQua,
        Pageable pageable
    );

    Page<NguyenVongXetTuyen> findByNnCccdAndNvMaNganhAndTtThmAndNvKetQua(
        String cccd,
        String nvMaNganh,
        String ttThm,
        String nvKetQua,
        Pageable pageable
    );

    // ── Filter "Không xét" = nvKetQua IS NULL hoặc không phải 3 trạng thái kia ──
    @Query("SELECT nv FROM NguyenVongXetTuyen nv WHERE nv.nnCccd = :cccd " +
           "AND (nv.nvKetQua IS NULL OR (nv.nvKetQua <> 'Đã đậu' AND nv.nvKetQua <> 'Đã trượt' AND nv.nvKetQua <> 'Chờ xét'))")
    Page<NguyenVongXetTuyen> findByNnCccdAndKhongXet(@Param("cccd") String cccd, Pageable pageable);

    @Query("SELECT nv FROM NguyenVongXetTuyen nv WHERE nv.nnCccd = :cccd AND nv.nvMaNganh = :nganh " +
           "AND (nv.nvKetQua IS NULL OR (nv.nvKetQua <> 'Đã đậu' AND nv.nvKetQua <> 'Đã trượt' AND nv.nvKetQua <> 'Chờ xét'))")
    Page<NguyenVongXetTuyen> findByNnCccdAndNvMaNganhAndKhongXet(
        @Param("cccd") String cccd, @Param("nganh") String nganh, Pageable pageable);

    @Query("SELECT nv FROM NguyenVongXetTuyen nv WHERE nv.nnCccd = :cccd AND nv.ttThm = :tohop " +
           "AND (nv.nvKetQua IS NULL OR (nv.nvKetQua <> 'Đã đậu' AND nv.nvKetQua <> 'Đã trượt' AND nv.nvKetQua <> 'Chờ xét'))")
    Page<NguyenVongXetTuyen> findByNnCccdAndTtThmAndKhongXet(
        @Param("cccd") String cccd, @Param("tohop") String tohop, Pageable pageable);

    @Query("SELECT nv FROM NguyenVongXetTuyen nv WHERE nv.nnCccd = :cccd AND nv.nvMaNganh = :nganh AND nv.ttThm = :tohop " +
           "AND (nv.nvKetQua IS NULL OR (nv.nvKetQua <> 'Đã đậu' AND nv.nvKetQua <> 'Đã trượt' AND nv.nvKetQua <> 'Chờ xét'))")
    Page<NguyenVongXetTuyen> findByNnCccdAndNvMaNganhAndTtThmAndKhongXet(
        @Param("cccd") String cccd, @Param("nganh") String nganh, @Param("tohop") String tohop, Pageable pageable);
}