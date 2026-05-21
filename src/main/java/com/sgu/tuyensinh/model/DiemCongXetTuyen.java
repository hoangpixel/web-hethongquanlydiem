package com.sgu.tuyensinh.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "xt_diemcongxettuyen")
public class DiemCongXetTuyen {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iddiemcong")
    private Long idDiemCong;

    @Column(name = "ts_cccd")
    private String cccd;

    @Column(name = "manganh")
    private String maNganh;

    @Column(name = "matohop")
    private String maToHop;

    @Column(name = "phuongthuc")
    private String phuongThuc;

    @Column(name = "diemCC")
    private Double diemCC;

    @Column(name = "diemUtxt")
    private Double diemUtxt;

    @Column(name = "diemTong")
    private Double diemTong;

    @Column(name = "ghichu")
    private String ghiChu;

    @Column(name = "dc_keys")
    private String dcKeys;

    public Long getIdDiemCong() {
        return idDiemCong;
    }

    public void setIdDiemCong(Long idDiemCong) {
        this.idDiemCong = idDiemCong;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getMaNganh() {
        return maNganh;
    }

    public void setMaNganh(String maNganh) {
        this.maNganh = maNganh;
    }

    public String getMaToHop() {
        return maToHop;
    }

    public void setMaToHop(String maToHop) {
        this.maToHop = maToHop;
    }

    public String getPhuongThuc() {
        return phuongThuc;
    }

    public void setPhuongThuc(String phuongThuc) {
        this.phuongThuc = phuongThuc;
    }

    public Double getDiemCC() {
        return diemCC;
    }

    public void setDiemCC(Double diemCC) {
        this.diemCC = diemCC;
    }

    public Double getDiemUtxt() {
        return diemUtxt;
    }

    public void setDiemUtxt(Double diemUtxt) {
        this.diemUtxt = diemUtxt;
    }

    public Double getDiemTong() {
        return diemTong;
    }

    public void setDiemTong(Double diemTong) {
        this.diemTong = diemTong;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public String getDcKeys() {
        return dcKeys;
    }

    public void setDcKeys(String dcKeys) {
        this.dcKeys = dcKeys;
    }
}