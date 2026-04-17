```
📦 src/main/java/com/sgu/tuyensinh
 ┣ 📂 controller       <-- (Chứa Anh Phục Vụ)
 ┃  ┣ 📜 WebController.java    (Xử lý màn hình Đăng nhập/Đăng xuất, Kết quả)
 ┃
 ┣ 📂 service          <-- (Quản lý nhà hàng - Chứa Logic nghiệp vụ)
 ┃  ┣ 📜 TuyensinhService.java    (Kiểm tra login và kết quả nguyện vòng)
 ┃
 ┣ 📂 repository       <-- (Phụ bếp - Gọi trực tiếp xuống Database MySQL)
 ┃  ┣ 📜 ThiSinhRepository.java 
 ┃  ┗ 📜 NguyenVongRepository.java
 ┃
 ┗ 📂 model            <-- (Khu chứa nguyên liệu - Chứa các class)
 ┃   ┣ 📜 ThiSinh.java           (Có các thuộc tính: CCCD, HoTen, MatKhau...)
 ┃   ┗ 📜 NguyenVongXetTuyen.java(Mã ngành, Điểm xét, Trạng thái Đậu/Rớt)
 ┃
 ┗ 📜 TuyensinhApplication.java (Main)

📦 src/main/resources
 ┗ 📜 application.properties    <-- (Chứa cấu hình kết nối Database MySQL của ông)

📦 src/main/webapp/WEB-INF/views  <-- (Chứa Bàn Ăn - Code HTML/CSS/Bootstrap)
 ┣ 📜 login.jsp                 (Trang đăng nhập)
 ┗ 📜 ketqua.jsp                (Trang hiển thị bảng nguyện vọng)
```
