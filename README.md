# 🎓 Hệ Thống Tra Cứu và Tính Điểm Xét Tuyển Đại Học (SGU)

Một ứng dụng web hỗ trợ thí sinh tra cứu kết quả xét tuyển và tự động tính toán, quy đổi điểm cho các phương thức tuyển sinh Đại học, được phát triển bởi **Nhóm 12**.

## 🌟 Tính năng nổi bật

* **🔍 Quét Tổ Hợp Thông Minh:** Thí sinh chỉ cần nhập điểm các môn đã thi, hệ thống sẽ tự động đối chiếu với cơ sở dữ liệu và tính ra điểm của *tất cả* các tổ hợp hợp lệ cho ngành học đó.
* **📊 Đa Phương Thức Xét Tuyển:** * **THPT:** Xét điểm thi Trung học Phổ thông.
    * **V-SAT:** Xét điểm thi Đánh giá đầu vào, tích hợp thuật toán nội suy điểm tự động từ thang 150 sang thang 10.
    * **ĐGNL:** Quy đổi điểm thi Đánh giá năng lực (ĐHQG HCM).
* **➕ Tính Điểm Ưu Tiên Chuẩn Xác:** Tự động cộng điểm ưu tiên theo Khu vực và Đối tượng, áp dụng công thức điều chỉnh điểm ưu tiên đối với thí sinh có tổng điểm trên 22.5.
* **✅ Đối Chiếu Điểm Sàn (Real-time):** Tự động so sánh điểm tổng của thí sinh với điểm sàn của ngành và cấp huy hiệu **ĐẠT / KHÔNG ĐẠT** trực quan.
* **📖 Minh Bạch Công Thức:** Giao diện hiển thị chi tiết từng bước tính toán (nhân hệ số, công thức nội suy, quy về thang 30...) giúp thí sinh hiểu rõ kết quả của mình.

## 🛠️ Công nghệ sử dụng

* **Backend:** Java, Spring Boot, Spring Data JPA, Hibernate.
* **Frontend:** JSP, JSTL, HTML5, CSS3, JavaScript, Bootstrap 5.3.
* **Database:** MySQL.
* **Kiến trúc:** MVC (Model - View - Controller).

## 🚀 Hướng dẫn cài đặt và chạy dự án

1. **Chuẩn bị môi trường:** Đảm bảo máy tính đã cài đặt Java JDK (khuyến nghị bản 17+), Maven và MySQL.
2. **Cơ sở dữ liệu:** * Import file CSDL (chứa các bảng `xt_nganh`, `xt_nganh_tohop`, `xt_bangquydoi`...) vào MySQL.
3. **Cấu hình kết nối:**
   * Mở file `src/main/resources/application.properties`.
   * Cập nhật `spring.datasource.url`, `username`, và `password` cho khớp với MySQL của bạn.
4. **Khởi chạy ứng dụng:**
   * Chạy file Application chính của Spring Boot.
   * Mở trình duyệt và truy cập: `http://localhost:8080/`

## 👨‍💻 Thành viên phát triển

* **Nhóm 12** - Sinh viên khoa Công nghệ Thông tin - Đại học Sài Gòn (SGU).
* Đại diện nhóm: Phạm Minh Hoàng
