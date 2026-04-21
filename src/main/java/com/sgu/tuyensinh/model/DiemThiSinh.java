package com.sgu.tuyensinh.model;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.annotations.Immutable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Immutable
@Table(name = "xt_diemthixettuyen")
public class DiemThiSinh {

    @Id
    @Column(name = "iddiemthi")
    private Integer iddiemthi;

    @Column(name = "cccd")
    private String cccd;

    // ===================== CÁC CỘT ĐIỂM THI =====================

    @Column(name = "TO")
    private Double toan;

    @Column(name = "LI")
    private Double ly;

    @Column(name = "HO")
    private Double hoa;

    @Column(name = "SI")
    private Double sinh;

    @Column(name = "SU")
    private Double su;

    @Column(name = "DI")
    private Double dia;

    @Column(name = "VA")
    private Double van;

    @Column(name = "N1_THI")
    private Double ngoaiNguThi;

    @Column(name = "N1_CC")
    private Double ngoaiNguCc;

    @Column(name = "CNCN")
    private Double congNgheCn;

    @Column(name = "CNNN")
    private Double congNgheNn;

    @Column(name = "TI")
    private Double tin;

    @Column(name = "KTPL")
    private Double ktpl;

    @Column(name = "NL1")
    private Double nangLuc;

    @Column(name = "NK1")
    private Double nangKhieu1;

    @Column(name = "NK2")
    private Double nangKhieu2;

    @Column(name = "NK3")
    private Double nangKhieu3;

    @Column(name = "NK4")
    private Double nangKhieu4;

    @Column(name = "NK5")
    private Double nangKhieu5;

    @Column(name = "NK6")
    private Double nangKhieu6;

    // ===================== CONSTRUCTOR =====================

    public DiemThiSinh() {}

    // ===================== BUSINESS LOGIC =====================

    /**
     * Trả về danh sách các môn có điểm thực (khác null và > 0).
     * JSP gọi: ${diemThiSinh.diemTheoMon}
     */
    public List<DiemMon> getDiemTheoMon() {

        Map<String, Double> monThuong = new LinkedHashMap<>();

        monThuong.put("Toán", toan);
        monThuong.put("Lý", ly);
        monThuong.put("Hóa", hoa);
        monThuong.put("Sinh", sinh);
        monThuong.put("Sử", su);
        monThuong.put("Địa", dia);
        monThuong.put("Văn", van);
        monThuong.put("Ngoại Ngữ", ngoaiNguThi);
        monThuong.put("Ngoại Ngữ CC", ngoaiNguCc);
        monThuong.put("CN - CN", congNgheCn);
        monThuong.put("CN - NN", congNgheNn);
        monThuong.put("Tin Học", tin);
        monThuong.put("KTPL", ktpl);
        monThuong.put("Năng Lực", nangLuc);

        List<DiemMon> result = new ArrayList<>();

        // ===== MÔN THƯỜNG =====
        for (Map.Entry<String, Double> e : monThuong.entrySet()) {
            Double d = e.getValue();
            if (d != null && d > 0) {
                result.add(new DiemMon(e.getKey(), d));
            }
        }

        // ===== NĂNG KHIẾU (chỉ tối đa 2) =====
        Map<String, Double> nangKhieu = new LinkedHashMap<>();

        nangKhieu.put("Kể chuyện - Đọc diễn cảm", nangKhieu1);
        nangKhieu.put("Hát", nangKhieu2);
        nangKhieu.put("Hình họa", nangKhieu3);
        nangKhieu.put("Trang trí", nangKhieu4);
        nangKhieu.put("Hát - Nhạc cụ", nangKhieu5);
        nangKhieu.put("Xướng âm - Thẩm âm, Tiết tấu", nangKhieu6);

        int count = 0;

        for (Map.Entry<String, Double> e : nangKhieu.entrySet()) {

            Double d = e.getValue();

            if (d != null && d > 0) {
                result.add(new DiemMon(e.getKey(), d));
                count++;

                if (count == 2) break;
            }
        }

        return result;
    }

    /**
     * Tự cộng tổng từ getDiemTheoMon().
     * JSP gọi: ${diemThiSinh.tongDiem}
     */
    public Double getTongDiem() {
        return getDiemTheoMon().stream()
                .mapToDouble(DiemMon::getDiem)
                .sum();
    }

    // ===================== GETTERS & SETTERS =====================

    public Integer getIdDiemThi() { return iddiemthi; }
    public void setIdDiemThi(Integer iddiemthi) { this.iddiemthi = iddiemthi; }

    public String getCccd() { return cccd; }
    public void setCccd(String cccd) { this.cccd = cccd; }

    public Double getToan() { return toan; }
    public void setToan(Double toan) { this.toan = toan; }

    public Double getLy() { return ly; }
    public void setLy(Double ly) { this.ly = ly; }

    public Double getHoa() { return hoa; }
    public void setHoa(Double hoa) { this.hoa = hoa; }

    public Double getSinh() { return sinh; }
    public void setSinh(Double sinh) { this.sinh = sinh; }

    public Double getSu() { return su; }
    public void setSu(Double su) { this.su = su; }

    public Double getDia() { return dia; }
    public void setDia(Double dia) { this.dia = dia; }

    public Double getVan() { return van; }
    public void setVan(Double van) { this.van = van; }

    public Double getNgoaiNguThi() { return ngoaiNguThi; }
    public void setNgoaiNguThi(Double ngoaiNguThi) { this.ngoaiNguThi = ngoaiNguThi; }

    public Double getNgoaiNguCc() { return ngoaiNguCc; }
    public void setNgoaiNguCc(Double ngoaiNguCc) { this.ngoaiNguCc = ngoaiNguCc; }

    public Double getCongNgheCn() { return congNgheCn; }
    public void setCongNgheCn(Double congNgheCn) { this.congNgheCn = congNgheCn; }

    public Double getCongNgheNn() { return congNgheNn; }
    public void setCongNgheNn(Double congNgheNn) { this.congNgheNn = congNgheNn; }

    public Double getTin() { return tin; }
    public void setTin(Double tin) { this.tin = tin; }

    public Double getKtpl() { return ktpl; }
    public void setKtpl(Double ktpl) { this.ktpl = ktpl; }

    public Double getNangLuc() { return nangLuc; }
    public void setNangLuc(Double nangLuc) { this.nangLuc = nangLuc; }

    public Double getNangKhieu1() { return nangKhieu1; }
    public void setNangKhieu1(Double nangKhieu1) { this.nangKhieu1 = nangKhieu1; }

    public Double getNangKhieu2() { return nangKhieu2; }
    public void setNangKhieu2(Double nangKhieu2) { this.nangKhieu2 = nangKhieu2; }

    public Double getNangKhieu3() { return nangKhieu3; }
    public void setNangKhieu3(Double nangKhieu3) { this.nangKhieu3 = nangKhieu3; }

    public Double getNangKhieu4() { return nangKhieu4; }
    public void setNangKhieu4(Double nangKhieu4) { this.nangKhieu4 = nangKhieu4; }

    public Double getNangKhieu5() { return nangKhieu5; }
    public void setNangKhieu5(Double nangKhieu5) { this.nangKhieu5 = nangKhieu5; }

    public Double getNangKhieu6() { return nangKhieu6; }
    public void setNangKhieu6(Double nangKhieu6) { this.nangKhieu6 = nangKhieu6; }
}