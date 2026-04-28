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
    @EventListener({ApplicationReadyEvent.class})
    public void moTrinhDuyetTuDong() {
        String url = "http://localhost:8080/login";
        System.out.println("\n Chay web thanh cong\n");
        
        try {
            Runtime.getRuntime().exec("cmd /c start " + url);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}