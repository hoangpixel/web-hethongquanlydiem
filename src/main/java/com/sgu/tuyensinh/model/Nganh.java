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

    @Column(name = "n_tohopgoc")
    private String toHopGoc;

    @Column(name = "n_diemsanthpt")
    private Double diemSanThpt;

    @Column(name = "n_diemsandgnl")
    private Double diemSanDgnl;

    @Column(name = "n_diemsanvsat")
    private Double diemSanVsat;

    // Getters và Setters
    public String getMaNganh() { return maNganh; }
    public void setMaNganh(String maNganh) { this.maNganh = maNganh; }

    public String getToHopGoc() { return toHopGoc; }
    public void setToHopGoc(String toHopGoc) { this.toHopGoc = toHopGoc; }

    public Double getDiemSanThpt() { return diemSanThpt; }
    public void setDiemSanThpt(Double diemSanThpt) { this.diemSanThpt = diemSanThpt; }

    public Double getDiemSanDgnl() { return diemSanDgnl; }
    public void setDiemSanDgnl(Double diemSanDgnl) { this.diemSanDgnl = diemSanDgnl; }

    public Double getDiemSanVsat() { return diemSanVsat; }
    public void setDiemSanVsat(Double diemSanVsat) { this.diemSanVsat = diemSanVsat; }
}