package com.sgu.tuyensinh.model;
import jakarta.persistence.*;

@Entity
@Table(name = "xt_bangquydoi")
public class BangQuyDoi {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idqd;

    @Column(name = "d_phuongthuc")
    private String phuongThuc;

    @Column(name = "d_tohop")
    private String toHop;

    @Column(name = "d_mon")
    private String mon;

    @Column(name = "d_diema")
    private Double diemA;

    @Column(name = "d_diemb")
    private Double diemB;

    @Column(name = "d_diemc")
    private Double diemC;

    @Column(name = "d_diemd")
    private Double diemD;

    public Integer getIdqd() {
        return idqd;
    }

    public String getPhuongThuc() {
        return phuongThuc;
    }

    public String getToHop() {
        return toHop;
    }

    public String getMon() {
        return mon;
    }

    public Double getDiemA() {
        return diemA;
    }

    public Double getDiemB() {
        return diemB;
    }

    public Double getDiemC() {
        return diemC;
    }

    public Double getDiemD() {
        return diemD;
    }

    public void setIdqd(Integer idqd) {
        this.idqd = idqd;
    }

    public void setPhuongThuc(String phuongThuc) {
        this.phuongThuc = phuongThuc;
    }

    public void setToHop(String toHop) {
        this.toHop = toHop;
    }

    public void setMon(String mon) {
        this.mon = mon;
    }

    public void setDiemA(Double diemA) {
        this.diemA = diemA;
    }

    public void setDiemB(Double diemB) {
        this.diemB = diemB;
    }

    public void setDiemC(Double diemC) {
        this.diemC = diemC;
    }

    public void setDiemD(Double diemD) {
        this.diemD = diemD;
    }
}