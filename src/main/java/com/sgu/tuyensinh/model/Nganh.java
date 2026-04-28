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

    // Getters và Setters
    public String getMaNganh() { return maNganh; }
    public void setMaNganh(String maNganh) { this.maNganh = maNganh; }

    public String getToHopGoc() { return toHopGoc; }
    public void setToHopGoc(String toHopGoc) { this.toHopGoc = toHopGoc; }
}