package com.sgu.tuyensinh.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "xt_chungchi")
public class ChungChi {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cc")
    private Integer id;

    @Column(name = "cccd")
    private String cccd;

    @Column(name = "loai_chung_chi")
    private String loaiChungChi;

    @Column(name = "diem_chung_chi")
    private Double diemChungChi;

    @Column(name = "diem_quydoi")
    private Double diemQuydoi;

    @Column(name = "diem_cong")
    private Double diemCong;

    // ===== Getter Setter =====

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getLoaiChungChi() {
        return loaiChungChi;
    }

    public void setLoaiChungChi(String loaiChungChi) {
        this.loaiChungChi = loaiChungChi;
    }

    public Double getDiemChungChi() {
        return diemChungChi;
    }

    public void setDiemChungChi(Double diemChungChi) {
        this.diemChungChi = diemChungChi;
    }

    public Double getDiemQuydoi() {
        return diemQuydoi;
    }

    public void setDiemQuydoi(Double diemQuydoi) {
        this.diemQuydoi = diemQuydoi;
    }

    public Double getDiemCong() {
        return diemCong;
    }

    public void setDiemCong(Double diemCong) {
        this.diemCong = diemCong;
    }
}