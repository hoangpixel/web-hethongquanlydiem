package com.sgu.tuyensinh.model;

import jakarta.persistence.*;

@Entity
@Table(name = "xt_nganh")
public class Nganh {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idnganh;

    @Column(name = "manganh")
    private String maNganh;

    @Column(name = "tennganh")
    private String tenNganh;

    @Column(name = "n_tohopgoc")
    private String toHopGoc;

    @Column(name = "n_diemsanthpt")
    private Double diemSanThpt;

    @Column(name = "n_diemsandgnl")
    private Double diemSanDgnl;

    @Column(name = "n_diemsanvsat")
    private Double diemSanVsat;

    @Column(name = "diemchuan_thpt")
    private Double diemChuanThpt;

    @Column(name = "diemchuan_dgnl")
    private Double diemChuanDgnl;

    @Column(name = "diemchuan_vsat")
    private Double diemChuanVsat;

    // Getters và Setters
    public String getMaNganh() { return maNganh; }
    public void setMaNganh(String maNganh) { this.maNganh = maNganh; }

    public String getTenNganh() { return tenNganh; }
    public void setTenNganh(String tenNganh) { this.tenNganh = tenNganh; }

    public String getToHopGoc() { return toHopGoc; }
    public void setToHopGoc(String toHopGoc) { this.toHopGoc = toHopGoc; }

    public Double getDiemSanThpt() { return diemSanThpt; }
    public void setDiemSanThpt(Double diemSanThpt) { this.diemSanThpt = diemSanThpt; }

    public Double getDiemSanDgnl() { return diemSanDgnl; }
    public void setDiemSanDgnl(Double diemSanDgnl) { this.diemSanDgnl = diemSanDgnl; }

    public Double getDiemSanVsat() { return diemSanVsat; }
    public void setDiemSanVsat(Double diemSanVsat) { this.diemSanVsat = diemSanVsat; }

    public Double getDiemChuanThpt() { return diemChuanThpt; }
    public void setDiemChuanThpt(Double diemChuanThpt) { this.diemChuanThpt = diemChuanThpt; }

    public Double getDiemChuanDgnl() { return diemChuanDgnl; }
    public void setDiemChuanDgnl(Double diemChuanDgnl) { this.diemChuanDgnl = diemChuanDgnl; }

    public Double getDiemChuanVsat() { return diemChuanVsat; }
    public void setDiemChuanVsat(Double diemChuanVsat) { this.diemChuanVsat = diemChuanVsat; }
}