package com.sgu.tuyensinh.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "xt_giathuong")
public class GiaiThuong {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_gt")
    private Integer idGt;

    @Column(name = "cccd")
    private String cccd;

    @Column(name = "cap_giai")
    private String capGiai;

    @Column(name = "doi_tuong")
    private String doiTuong;

    @Column(name = "ma_mon")
    private String maMon;

    @Column(name = "loai_giai")
    private String loaiGiai;

    @Column(name = "diem_cong_co_mon")
    private Double diemCongCoMon;

    @Column(name = "diem_cong_khong_mon")
    private Double diemCongKhongMon;

    public Integer getIdGt() { return idGt; }
    public String getCccd() { return cccd; }
    public String getCapGiai() { return capGiai; }
    public String getDoiTuong() { return doiTuong; }
    public String getMaMon() { return maMon; }
    public String getLoaiGiai() { return loaiGiai; }
    public Double getDiemCongCoMon() { return diemCongCoMon; }
    public Double getDiemCongKhongMon() { return diemCongKhongMon; }
}