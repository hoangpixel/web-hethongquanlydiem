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
    <style>
        :root {
            --primary: #1a56db;
            --primary-light: #e8f0fe;
            --primary-dark: #1239a6;
            --success-light: #d1fae5;
            --danger-light: #fee2e2;
            --warning-light: #fef3c7;
            --bg: #f0f4ff;
            --border: #e5e7eb;
            --text: #111827;
            --text-muted: #6b7280;
        }
        * { box-sizing: border-box; }
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
            margin: 0;
        }
        /* NAVBAR */
        .navbar {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            padding: 0.75rem 0;
            box-shadow: 0 2px 12px rgba(26,86,219,0.25);
        }
        .navbar-brand { font-size: 1.1rem; font-weight: 700; color: #fff !important; }
        .icon-pill { background: rgba(255,255,255,0.18); border-radius: 8px; padding: 3px 8px; margin-right: 6px; }
        .nav-greeting { color: rgba(255,255,255,0.8); font-size: 0.875rem; }
        .nav-greeting strong { color: #fff; }
        .btn-logout {
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.35);
            color: #fff !important;
            font-size: 0.8rem; font-weight: 600;
            border-radius: 8px; padding: 5px 14px;
            text-decoration: none; transition: background 0.2s;
        }
        .btn-logout:hover { background: rgba(220,38,38,0.8); border-color: transparent; }
        /* PAGE HEADER */
        .page-header {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 60%, #3b82f6 100%);
            padding: 2rem 0 3.2rem;
            position: relative; overflow: hidden;
        }
        .page-header::before {
            content: ''; position: absolute;
            top: -40px; right: -60px;
            width: 260px; height: 260px;
            border-radius: 50%; background: rgba(255,255,255,0.05);
        }
        .page-header h1 { font-size: 1.5rem; font-weight: 800; color: #fff; margin: 0; }
        .page-header p { color: rgba(255,255,255,0.7); font-size: 0.85rem; margin: 5px 0 0; }
        /* MAIN */
        .main-content { margin-top: 1.5rem; padding-bottom: 2.5rem; }
        /* CARD */
        .info-card {
            background: #fff; border-radius: 14px;
            border: 1px solid var(--border);
            box-shadow: 0 1px 3px rgba(0,0,0,0.05), 0 4px 14px rgba(0,0,0,0.04);
            overflow: hidden; margin-bottom: 1.25rem;
        }
        .card-title-bar {
            display: flex; align-items: center; gap: 10px;
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #f3f4f6; background: #fafbff;
        }
        .title-icon {
            width: 34px; height: 34px; border-radius: 9px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem; flex-shrink: 0;
        }
        .icon-blue  { background: var(--primary-light); }
        .icon-green { background: var(--success-light); }
        .card-title-bar h5 { font-size: 0.95rem; font-weight: 700; color: var(--text); margin: 0; }
        .card-title-bar small { font-size: 0.75rem; color: var(--text-muted); display: block; margin-top: 1px; }
        /* THÔNG TIN THÍ SINH */
        .ts-grid { display: grid; grid-template-columns: repeat(4, 1fr); }
        .ts-item { padding: 0.9rem 1.25rem; border-right: 1px solid #f3f4f6; border-bottom: 1px solid #f3f4f6; }
        .ts-label { font-size: 0.7rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; color: #9ca3af; margin-bottom: 3px; }
        .ts-value { font-size: 0.9rem; font-weight: 600; color: var(--text); }
        .ts-value.primary { color: var(--primary); font-size: 1rem; }
        /* TABLE */
        .nv-table { width: 100%; border-collapse: collapse; font-size: 0.875rem; }
        .nv-table thead tr { background: #f8faff; }
        .nv-table thead th {
            padding: 0.8rem 1rem; font-size: 0.72rem; font-weight: 700;
            text-transform: uppercase; letter-spacing: 0.5px;
            color: var(--text-muted); border-bottom: 2px solid var(--border);
            text-align: center; white-space: nowrap;
        }
        .nv-table tbody td { padding: 0.85rem 1rem; text-align: center; border-bottom: 1px solid #f3f4f6; vertical-align: middle; }
        .nv-table tbody tr:last-child td { border-bottom: none; }
        .nv-table tbody tr:hover { background: #fafbff; }
        /* Badges */
        .rank-pill {
            display: inline-flex; align-items: center; justify-content: center;
            width: 28px; height: 28px;
            background: var(--primary-light); color: var(--primary);
            border-radius: 7px; font-weight: 700; font-size: 0.875rem;
        }
        .ma-nganh { font-family: monospace; font-weight: 700; font-size: 0.9rem; color: var(--text); letter-spacing: 0.5px; }
        .method-badge {
            display: inline-block; padding: 3px 10px; border-radius: 6px;
            font-size: 0.75rem; font-weight: 600;
            background: #f3f4f6; color: #374151; border: 1px solid var(--border);
        }
        .score { font-size: 1.05rem; font-weight: 800; color: var(--primary); }
        /* Status */
        .status { display: inline-flex; align-items: center; gap: 5px; padding: 4px 12px; border-radius: 20px; font-size: 0.77rem; font-weight: 700; }
        .status::before { content: ''; width: 6px; height: 6px; border-radius: 50%; flex-shrink: 0; }
        .s-dau   { background: var(--success-light); color: #065f46; }
        .s-dau::before   { background: #059669; }
        .s-truot { background: var(--danger-light); color: #991b1b; }
        .s-truot::before { background: #dc2626; }
        .s-cho   { background: var(--primary-light); color: var(--primary-dark); }
        .s-cho::before   { background: var(--primary); }
        .s-other { background: var(--warning-light); color: #78350f; }
        .s-other::before { background: #d97706; }
        /* Empty */
        .empty-box { text-align: center; padding: 2.5rem 1rem; color: #9ca3af; }
        .e-icon { font-size: 2rem; margin-bottom: 8px; opacity: 0.5; }
        /* Responsive */
        @media (max-width: 576px) {
            .ts-grid { grid-template-columns: 1fr 1fr; }
            .page-header h1 { font-size: 1.2rem; }
            .nv-table { font-size: 0.8rem; }
            .nv-table thead th, .nv-table tbody td { padding: 0.65rem 0.6rem; }
        }
    </style>
</head>
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg py-2">
    <div class="container">
        <a class="navbar-brand" href="#">
            <span class="icon-pill">🎓</span>Tra Cứu Tuyển Sinh SGU
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