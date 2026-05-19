package com.sgu.tuyensinh.controller;

import com.sgu.tuyensinh.model.Nganh;
import com.sgu.tuyensinh.model.ToHopMonThi;
import com.sgu.tuyensinh.repository.NganhRepository;
import com.sgu.tuyensinh.repository.ToHopMonThiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@RestController
public class ApiController {

    @Autowired
    private NganhRepository nganhRepository;

    @Autowired
    private ToHopMonThiRepository toHopMonThiRepository;

    // API này nhận vào maNganh và trả về mỗi cái tên tổ hợp gốc
    @GetMapping("/api/lay-to-hop-goc")
    public ResponseEntity<String> layToHopGoc(@RequestParam("maNganh") String maNganh) {
        Nganh nganh = nganhRepository.findByMaNganh(maNganh.trim());
        
        if (nganh != null && nganh.getToHopGoc() != null) {
            return ResponseEntity.ok(nganh.getToHopGoc());
        }
        
        // Trả về chuỗi rỗng nếu không tìm thấy
        return ResponseEntity.ok(""); 
    }

    /**
     * Trả về danh sách mã môn xuất hiện trong tổ hợp của một ngành.
     * Dùng cho UI: chỉ hiện các ô điểm hiếm (CNCN/CNNN/TI/KTPL/NK1..NK6) khi ngành thật sự cần.
     */
    @GetMapping("/api/nganh/mon-to-hop")
    public ResponseEntity<List<String>> layDanhSachMonToHop(@RequestParam("maNganh") String maNganh) {
        String ma = maNganh == null ? "" : maNganh.trim();
        if (ma.isEmpty()) {
            return ResponseEntity.ok(List.of());
        }

        List<ToHopMonThi> danhSachToHop = toHopMonThiRepository.findByMaNganh(ma);
        if (danhSachToHop == null || danhSachToHop.isEmpty()) {
            return ResponseEntity.ok(List.of());
        }

        Set<String> monSet = new LinkedHashSet<>();
        for (ToHopMonThi th : danhSachToHop) {
            addMon(monSet, th.getThMon1());
            addMon(monSet, th.getThMon2());
            addMon(monSet, th.getThMon3());
        }

        return ResponseEntity.ok(new ArrayList<>(monSet));
    }

    private void addMon(Set<String> set, String mon) {
        if (set == null || mon == null) return;
        String m = mon.trim().toUpperCase();
        if (!m.isEmpty()) set.add(m);
    }
}