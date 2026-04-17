<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết Quả Xét Tuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">🎓 Tra Cứu Tuyển Sinh SGU</a>
        <div class="d-flex align-items-center">
            <span class="text-white me-3">Xin chào: <strong>${thiSinh.hoTen}</strong></span>
            <a href="/logout" class="btn btn-danger btn-sm">Đăng xuất</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom pb-0 pt-3">
                    <h5 class="text-primary fw-bold">📜 Danh Sách Nguyện Vọng Đăng Ký</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped mb-0 text-center align-middle">
                            <thead class="table-primary">
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
                                        <td><strong>${nv.nvTt}</strong></td>
                                        <td>${nv.nvMaNganh}</td>
                                        <td><span class="badge bg-secondary">${nv.ttPhuongThuc}</span></td>
                                        <td>${nv.ttThm}</td>
                                        <td class="fw-bold text-primary">${nv.diemXetTuyen}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${nv.nvKetQua == 'Đã đậu'}">
                                                    <span class="badge bg-success px-3 py-2 fs-6">Đã đậu</span>
                                                </c:when>
                                                <c:when test="${nv.nvKetQua == 'Đã trượt'}">
                                                    <span class="badge bg-danger">Đã trượt</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark">Không xét</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty danhSachNV}">
                                    <tr>
                                        <td><strong>1</strong></td>
                                        <td>7480201</td>
                                        <td><span class="badge bg-secondary">Xét THPT</span></td>
                                        <td>A00</td>
                                        <td class="fw-bold text-primary">28.32</td>
                                        <td><span class="badge bg-success px-3 py-2 fs-6">Đã đậu</span></td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>