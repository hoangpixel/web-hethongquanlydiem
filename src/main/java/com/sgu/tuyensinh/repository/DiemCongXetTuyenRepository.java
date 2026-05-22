package com.sgu.tuyensinh.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sgu.tuyensinh.model.DiemCongXetTuyen;

public interface DiemCongXetTuyenRepository extends JpaRepository<DiemCongXetTuyen, Long> {

    DiemCongXetTuyen findByCccdAndMaNganhAndMaToHopAndPhuongThuc(
            String cccd,
            String maNganh,
            String maToHop,
            String phuongThuc
    );

    DiemCongXetTuyen findByDcKeys(String dcKeys);

    @Query("""
        select dc
        from DiemCongXetTuyen dc
        where dc.cccd = :cccd
          and dc.maNganh = :maNganh
          and dc.maToHop = :maToHop
          and upper(trim(dc.phuongThuc)) = upper(trim(:phuongThuc))
        """)
    DiemCongXetTuyen findMatchTrimmed(
        @Param("cccd") String cccd,
        @Param("maNganh") String maNganh,
        @Param("maToHop") String maToHop,
        @Param("phuongThuc") String phuongThuc
    );

    /**
     * Fallback: tìm theo cccd, maNganh, maToHop và phương thức trong DB
     * là prefix của phương thức đầy đủ (ví dụ DB="ĐGNL", NV="ĐGNL HCM").
     * Dùng khi tên phương thức trong bảng điểm cộng ngắn hơn bảng nguyện vọng.
     */
    @Query("""
        select dc
        from DiemCongXetTuyen dc
        where dc.cccd = :cccd
          and dc.maNganh = :maNganh
          and dc.maToHop = :maToHop
          and upper(trim(:phuongThuc)) like concat(upper(trim(dc.phuongThuc)), '%')
        """)
    List<DiemCongXetTuyen> findByPhuongThucPrefix(
        @Param("cccd") String cccd,
        @Param("maNganh") String maNganh,
        @Param("maToHop") String maToHop,
        @Param("phuongThuc") String phuongThuc
    );
}