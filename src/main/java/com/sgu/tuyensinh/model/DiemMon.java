package com.sgu.tuyensinh.model;

public class DiemMon {
    private String tenMon;
    private Double diem;

    public DiemMon() {}

    public DiemMon(String tenMon, Double diem) {
        this.tenMon = tenMon;
        this.diem = diem;
    }

    public String getTenMon() { return tenMon; }
    public void setTenMon(String tenMon) { this.tenMon = tenMon; }

    public Double getDiem() { return diem; }
    public void setDiem(Double diem) { this.diem = diem; }
}
