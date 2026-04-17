package com.sgu.tuyensinh.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "xt_nguyenvongxettuyen")
public class NguyenVongXetTuyen {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idnv")
    private Integer idnv;

    @Column(name = "nn_cccd", length = 45)
    private String nnCccd;

    @Column(name = "nv_manganh", length = 45)
    private String nvMaNganh;

    @Column(name = "nv_tt")
    private Integer nvTt;

    @Column(name = "diem_thxt")
    private Double diemThxt;

    @Column(name = "diem_utqd")
    private Double diemUtqd;

    @Column(name = "diem_cong")
    private Double diemCong;

    @Column(name = "diem_xettuyen")
    private Double diemXetTuyen;

    @Column(name = "nv_ketqua", length = 45)
    private String nvKetQua;

    @Column(name = "nv_keys", length = 45, unique = true)
    private String nvKeys;

    @Column(name = "tt_phuongthuc", length = 45)
    private String ttPhuongThuc;

    @Column(name = "tt_thm", length = 45)
    private String ttThm;

    // --- HÀM KHỞI TẠO RỖNG ---
    public NguyenVongXetTuyen() {}

    // --- GETTER & SETTER ---
    public Integer getIdnv() { return idnv; }
    public void setIdnv(Integer idnv) { this.idnv = idnv; }

    public String getNnCccd() { return nnCccd; }
    public void setNnCccd(String nnCccd) { this.nnCccd = nnCccd; }

    public String getNvMaNganh() { return nvMaNganh; }
    public void setNvMaNganh(String nvMaNganh) { this.nvMaNganh = nvMaNganh; }

    public Integer getNvTt() { return nvTt; }
    public void setNvTt(Integer nvTt) { this.nvTt = nvTt; }

    public Double getDiemThxt() { return diemThxt; }
    public void setDiemThxt(Double diemThxt) { this.diemThxt = diemThxt; }

    public Double getDiemUtqd() { return diemUtqd; }
    public void setDiemUtqd(Double diemUtqd) { this.diemUtqd = diemUtqd; }

    public Double getDiemCong() { return diemCong; }
    public void setDiemCong(Double diemCong) { this.diemCong = diemCong; }

    public Double getDiemXetTuyen() { return diemXetTuyen; }
    public void setDiemXetTuyen(Double diemXetTuyen) { this.diemXetTuyen = diemXetTuyen; }

    public String getNvKetQua() { return nvKetQua; }
    public void setNvKetQua(String nvKetQua) { this.nvKetQua = nvKetQua; }

    public String getNvKeys() { return nvKeys; }
    public void setNvKeys(String nvKeys) { this.nvKeys = nvKeys; }

    public String getTtPhuongThuc() { return ttPhuongThuc; }
    public void setTtPhuongThuc(String ttPhuongThuc) { this.ttPhuongThuc = ttPhuongThuc; }

    public String getTtThm() { return ttThm; }
    public void setTtThm(String ttThm) { this.ttThm = ttThm; }
}