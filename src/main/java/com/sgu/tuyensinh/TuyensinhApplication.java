package com.sgu.tuyensinh;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;

@SpringBootApplication
public class TuyensinhApplication {

    public static void main(String[] args) {
        SpringApplication.run(TuyensinhApplication.class, args);
    }

    // 🔥 CẢM BIẾN: Lắng nghe sự kiện Spring Boot vừa khởi động xong
    @EventListener({ApplicationReadyEvent.class})
    public void moTrinhDuyetTuDong() {
        String url = "http://localhost:8080/login";
        System.out.println("\n Chay web thanh cong\n");
        
        try {
            // Gọi lệnh CMD của Windows để mở tab mới bằng trình duyệt mặc định
            Runtime.getRuntime().exec("cmd /c start " + url);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}