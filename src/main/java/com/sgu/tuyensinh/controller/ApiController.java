package com.sgu.tuyensinh.controller;

import com.sgu.tuyensinh.model.Nganh;
import com.sgu.tuyensinh.repository.NganhRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ApiController {

    @Autowired
    private NganhRepository nganhRepository;

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
}