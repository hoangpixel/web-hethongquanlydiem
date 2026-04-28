package com.sgu.tuyensinh.model;

import jakarta.persistence.*;

@Entity
@Table(name = "xt_nganh_tohop")
public class ToHopMonThi {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "manganh")
    private String maNganh;

    @Column(name = "matohop")
    private String maToHop;

    // Tên môn (VD: TO, LI, HO, VA)
    @Column(name = "th_mon1") private String thMon1;
    @Column(name = "th_mon2") private String thMon2;
    @Column(name = "th_mon3") private String thMon3;

    // Hệ số môn tương ứng (VD: 2, 1, 1)
    @Column(name = "hsmon1") private Double hsMon1;
    @Column(name = "hsmon2") private Double hsMon2;
    @Column(name = "hsmon3") private Double hsMon3;
    public Integer getId() {
        return id;
    }
    public String getMaNganh() {
        return maNganh;
    }
    public String getMaToHop() {
        return maToHop;
    }
    public String getThMon1() {
        return thMon1;
    }
    public String getThMon2() {
        return thMon2;
    }
    public String getThMon3() {
        return thMon3;
    }
    public Double getHsMon1() {
        return hsMon1;
    }
    public Double getHsMon2() {
        return hsMon2;
    }
    public Double getHsMon3() {
        return hsMon3;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public void setMaNganh(String maNganh) {
        this.maNganh = maNganh;
    }
    public void setMaToHop(String maToHop) {
        this.maToHop = maToHop;
    }
    public void setThMon1(String thMon1) {
        this.thMon1 = thMon1;
    }
    public void setThMon2(String thMon2) {
        this.thMon2 = thMon2;
    }
    public void setThMon3(String thMon3) {
        this.thMon3 = thMon3;
    }
    public void setHsMon1(Double hsMon1) {
        this.hsMon1 = hsMon1;
    }
    public void setHsMon2(Double hsMon2) {
        this.hsMon2 = hsMon2;
    }
    public void setHsMon3(Double hsMon3) {
        this.hsMon3 = hsMon3;
    }

    
}