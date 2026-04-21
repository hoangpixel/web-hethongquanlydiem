package com.sgu.tuyensinh.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "xt_thisinhxettuyen25")
public class ThiSinh {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Khai báo đây là ID tự tăng
    @Column(name = "idthisinh")
    private Integer idthisinh;

    @Column(name = "cccd", length = 20, unique = true)
    private String cccd;

    @Column(name = "sobaodanh", length = 45)
    private String soBaoDanh;

    @Column(name = "ho", length = 100)
    private String ho;

    @Column(name = "ten", length = 100)
    private String ten;

    @Column(name = "password", length = 100)
    private String password;

    @Column(name = "email", length = 100)
    private String email;

    @Column(name = "dienThoai", length = 20)
    private String sdt;

    // --- HÀM KHỞI TẠO RỖNG ---
    public ThiSinh() {}

    // 🔥 HÀM CHẾ THÊM ĐỂ HIỂN THỊ LÊN WEB CHO ĐẸP 🔥
    // Trên web JSP chỉ cần gọi ${thiSinh.hoTen} là nó tự ghép "Họ" + "Tên" lại!
    public String getHoTen() {
        String hoStr = (this.ho != null) ? this.ho.trim() : "";
        String tenStr = (this.ten != null) ? this.ten.trim() : "";
        return hoStr + " " + tenStr;
    }

    // --- GETTER & SETTER MẶC ĐỊNH ---
    public Integer getIdthisinh() { return idthisinh; }
    public void setIdthisinh(Integer idthisinh) { this.idthisinh = idthisinh; }

    public String getCccd() { return cccd; }
    public void setCccd(String cccd) { this.cccd = cccd; }

    public String getSoBaoDanh() { return soBaoDanh; }
    public void setSoBaoDanh(String soBaoDanh) { this.soBaoDanh = soBaoDanh; }

    public String getHo() { return ho; }
    public void setHo(String ho) { this.ho = ho; }

    public String getTen() { return ten; }
    public void setTen(String ten) { this.ten = ten; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }
}