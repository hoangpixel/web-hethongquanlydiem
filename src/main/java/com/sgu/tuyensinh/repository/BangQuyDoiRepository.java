package com.sgu.tuyensinh.repository;
import com.sgu.tuyensinh.model.BangQuyDoi;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface BangQuyDoiRepository extends JpaRepository<BangQuyDoi, Integer> {

    // Đổi sang nativeQuery và thêm LIMIT 1 để chống lỗi trùng lặp mốc điểm
    @Query(value = "SELECT * FROM xt_bangquydoi WHERE d_phuongthuc = 'ĐGNL HCM' AND d_tohop = :toHop AND :diem >= d_diema AND :diem <= d_diemb LIMIT 1", nativeQuery = true)
    BangQuyDoi timMocQuyDoiDGNL(@Param("toHop") String toHop, @Param("diem") Double diem);

    // Tương tự cho V-SAT
    @Query(value = "SELECT * FROM xt_bangquydoi WHERE d_phuongthuc = 'Đánh giá V-SAT' AND d_mon = :mon AND :diem >= d_diema AND :diem <= d_diemb LIMIT 1", nativeQuery = true)
    BangQuyDoi timMocQuyDoiVSAT(@Param("mon") String mon, @Param("diem") Double diem);

    @Query(value = "SELECT * FROM xt_bangquydoi WHERE d_phuongthuc = 'Đánh giá V-SAT' AND d_mon = :mon ORDER BY d_diema ASC LIMIT 1", nativeQuery = true)
    BangQuyDoi timMocNhoNhatVSAT(@Param("mon") String mon);

    @Query(value = "SELECT * FROM xt_bangquydoi WHERE d_phuongthuc = 'Đánh giá V-SAT' AND d_mon = :mon ORDER BY d_diemb DESC LIMIT 1", nativeQuery = true)
    BangQuyDoi timMocLonNhatVSAT(@Param("mon") String mon);
}