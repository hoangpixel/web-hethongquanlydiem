<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết Quả Xét Tuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ketqua.css" />
</head>
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg py-2">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="SGU Logo" style="height:32px; margin-right:8px; border-radius:4px;">Tra Cứu Tuyển Sinh SGU
        </a>
        <div class="d-flex align-items-center gap-3 ms-auto">
            <span class="nav-greeting d-none d-sm-inline">
                Xin chào: <strong>${thiSinh.hoTen}</strong>
            </span>
            <a href="/logout" class="btn-logout">Đăng xuất</a>
        </div>
    </div>
</nav>

<!-- PAGE HEADER -->
<div class="page-header">
    <div class="container">
        <h1>📋 Kết Quả Xét Tuyển</h1>
        <p>Thông tin thí sinh và danh sách nguyện vọng đã đăng ký</p>
    </div>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">
    <div class="container">

        <!-- SECTION 1: THÔNG TIN THÍ SINH -->
        <div class="info-card">
            <div class="card-title-bar">
                <div class="title-icon icon-blue">👤</div>
                <div>
                    <h5>Thông Tin Thí Sinh</h5>
                    <small>Thông tin cá nhân đăng ký xét tuyển</small>
                </div>
            </div>
            <div class="ts-grid">
                <div class="ts-item">
                    <div class="ts-label">Họ và Tên</div>
                    <div class="ts-value primary">${thiSinh.hoTen}</div>
                </div>
                <div class="ts-item">
                    <div class="ts-label">Số Báo Danh</div>
                    <div class="ts-value">${thiSinh.soBaoDanh}</div>
                </div>
                <div class="ts-item">
                    <div class="ts-label">Số CCCD</div>
                    <div class="ts-value">${thiSinh.cccd}</div>
                </div>
                <div class="ts-item">
                    <div class="ts-label">Email</div>
                    <div class="ts-value">${thiSinh.email}</div>
                </div>
                <div class="ts-item">
                    <div class="ts-label">Số Điện Thoại</div>
                    <div class="ts-value">${thiSinh.sdt}</div>
                </div>
            </div>
           <!-- ĐIỂM THI -->
            <div class="score-section mt-4">
                <div class="row g-3">
                    <c:forEach var="mon" items="${diemThiSinh.diemTheoMon}">
                        <div class="col-md-2 col-6">
                            <div class="score-card">
                                <div class="score-label">${mon.tenMon}</div>
                                <div class="score-value">${mon.diem}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
 
        <!-- SECTION 2: DANH SÁCH NGUYỆN VỌNG -->
        <div class="info-card">
            <div class="card-title-bar">
                <div class="title-icon icon-green">📜</div>
                <div>
                    <h5>Danh Sách Nguyện Vọng Đăng Ký</h5>
                    <small>Kết quả xét tuyển theo từng nguyện vọng</small>
                </div>
            </div>
            <div class="table-responsive">
                <table class="nv-table">
                    <thead>
                        <tr>
                            <th>Thứ Tự NV</th>
                            <th>Mã Ngành</th>
                            <th>Phương Thức</th>
                            <th>Tổ Hợp</th>
                            <th>Điểm Xét Tuyển</th>
                            <th>Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="nv" items="${danhSachNV}">
                            <tr>
                                <td><span class="rank-pill">${nv.nvTt}</span></td>
                                <td><span class="ma-nganh">${nv.nvMaNganh}</span></td>
                                <td><span class="method-badge">${nv.ttPhuongThuc}</span></td>
                                <td>${nv.ttThm}</td>
                                <td><span class="score">${nv.diemXetTuyen}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${nv.nvKetQua == 'Đã đậu'}">
                                            <span class="status s-dau">Đã đậu</span>
                                        </c:when>
                                        <c:when test="${nv.nvKetQua == 'Đã trượt'}">
                                            <span class="status s-truot">Đã trượt</span>
                                        </c:when>
                                        <c:when test="${nv.nvKetQua == 'Chờ xét'}">
                                            <span class="status s-cho">Chờ xét</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status s-other">Không xét</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty danhSachNV}">
                            <tr>
                                <td colspan="6">
                                    <div class="empty-box">
                                        <div class="e-icon">📭</div>
                                        <div style="font-weight:600;color:#374151;">Chưa có nguyện vọng nào</div>
                                        <div style="font-size:0.8rem;margin-top:3px;">Thí sinh chưa đăng ký nguyện vọng xét tuyển</div>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>