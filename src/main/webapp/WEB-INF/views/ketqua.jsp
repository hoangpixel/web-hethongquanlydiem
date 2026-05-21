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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ketqua.css?v=20260424" />
    <link rel="icon" href="${pageContext.request.contextPath}/img/logo.png" type="image/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg py-2">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="SGU Logo" style="height:32px; margin-right:8px; border-radius:4px;">Tra Cứu Tuyển Sinh SGU
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-4">
                <li class="nav-item">
                    <a class="nav-link active" href="#" style="font-weight: 600; color: #0d6efd; border-bottom: 2px solid #0d6efd;">Kết Quả Xét Tuyển</a>
                </li>
                <li class="nav-item ms-3">
                    <a class="nav-link hoverlinkhref" href="/tinh-diem" style="font-weight: 500;">Tính Điểm Tốt Nghiệp</a>
                </li>
            </ul>
        </div>
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
                <div class="ts-item">
                    <div class="ts-label">Đối Tượng</div>
                    <div class="ts-value">${thiSinh.doiTuong}</div>
                </div>
                <div class="ts-item">
                    <div class="ts-label">Khu Vực</div>
                    <div class="ts-value">${thiSinh.khuVuc}</div>
                </div>
            </div>
           <!-- ĐIỂM THI -->
            <div class="score-section mt-4">
                <div class="row g-3">
                    <c:forEach var="mon" items="${diemThiSinh.diemTheoMon}">
                        <div class="col-md-2 col-6">
                            <div class="score-card${not empty mon.diem ? ' has-value' : ''}">
                                <div class="score-label">${mon.tenMon}</div>
                                <div class="score-value">${mon.diem}</div>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- ĐIỂM ƯU TIÊN ĐỐI TƯỢNG -->
                    <div class="col-md-2 col-6">
                        <div class="score-card has-value" style="background: linear-gradient(135deg, #FEF3C7, #FDE68A); box-shadow: 0 4px 10px rgba(245, 158, 11, 0.15);">
                            <div class="score-label">ƯT Đối Tượng</div>
                            <div class="score-value" id="diemDoiTuong"></div>
                        </div>
                    </div>

                    <!-- ĐIỂM ƯU TIÊN KHU VỰC -->
                    <div class="col-md-2 col-6">
                        <div class="score-card has-value" style="background: linear-gradient(135deg, #FECACA, #FCA5A5); box-shadow: 0 4px 10px rgba(248, 113, 113, 0.15);">
                            <div class="score-label">ƯT Khu Vực</div>
                            <div class="score-value" id="diemKhuVuc"></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
 
        <!-- SECTION 2: DANH SÁCH NGUYỆN VỌNG -->
        <div class="info-card">
            <div class="card-title-bar" style="display:flex; align-items:center; justify-content:space-between;">
                <div style="display:flex; align-items:center; gap:12px;">
                    <div class="title-icon icon-green">📜</div>
                    <div>
                        <h5>Danh Sách Nguyện Vọng Đăng Ký</h5>
                        <small>Kết quả xét tuyển theo từng nguyện vọng</small>
                    </div>
                </div>
                <button class="btn-filter-nv" id="btnFilterNV" onclick="openFilterModal()" title="Lọc & sắp xếp">
                    <i class="bi bi-funnel-fill"></i>
                </button>
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
                            <th>Chi Tiết</th>
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
                                <td>
                                    <button class="btn btn-sm btn-outline-primary btn-chi-tiet"
                                            data-nv-tt="${nv.nvTt}"
                                            data-ma-nganh="${nv.nvMaNganh}"
                                            data-phuong-thuc="${nv.ttPhuongThuc}"
                                            data-to-hop="${nv.ttThm}"
                                            data-to-hop-goc="${nv.toHopGoc}"
                                            data-lech="${nv.mLechDiem}"
                                            data-diem-thxt="${nv.diemThxt}"
                                            data-diem-thgxt="${nv.diemThgxt}"
                                            data-diem-cong="${nv.diemCong}"
                                            data-diem-cong-cc="${nv.diemCongCC}"
                                            data-diem-cong-utxt="${nv.diemCongUtxt}"
                                            data-diem-utqd="${nv.diemUtqd}"
                                            data-diem-xt="${nv.diemXetTuyen}"
                                            data-danh-sach-mon="${nv.danhSachMonJson}"
                                            data-diem-dau-vao="${nv.diemDauVao}"
                                            data-moc-quy-doi="${nv.mocQuyDoi}"
                                            data-cong-thuc-tong-quat="${nv.congThucTongQuat}"
                                            data-cong-thuc-thay-so="${nv.congThucThaySo}"
                                            data-ghi-chu="${nv.ghiChu}"
                                            data-danh-sach-giai="${nv.danhSachGiaiJson}"
                                            data-doi-tuong="${thiSinh.doiTuong}"
                                            data-khu-vuc="${thiSinh.khuVuc}"
                                            data-ket-qua="${nv.nvKetQua}">
                                        Chi Tiết
                                    </button>
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

                <div class="pagination" style="display:flex;justify-content:center;align-items:center;gap:14px;margin-top:20px;">
                    <a class="btn btn-light border px-4 ${currentPage == 0 ? 'disabled' : ''}"
                    href="?page=0&nganh=${nganhFilter}&tohop=${tohopFilter}&sort=${sortFilter}">
                        &lt;&lt;
                    </a>

                    <a class="btn btn-light border px-3 ${currentPage == 0 ? 'disabled' : ''}"
                    href="?page=${currentPage - 1}&nganh=${nganhFilter}&tohop=${tohopFilter}&sort=${sortFilter}">
                        &lt;
                    </a>

                    <span style="font-weight:700;color:#111827;">
                        Trang ${currentPage + 1} / ${totalPages}
                    </span>

                    <a class="btn btn-light border px-3 ${currentPage >= totalPages - 1 ? 'disabled' : ''}"
                    href="?page=${currentPage + 1}&nganh=${nganhFilter}&tohop=${tohopFilter}&sort=${sortFilter}">
                        &gt;
                    </a>

                    <a class="btn btn-light border px-4 ${currentPage >= totalPages - 1 ? 'disabled' : ''}"
                    href="?page=${totalPages - 1}&nganh=${nganhFilter}&tohop=${tohopFilter}&sort=${sortFilter}">
                        &gt;&gt;
                    </a>
                </div>

            </div>
        </div>
    </div>

        <!-- MODAL CHI TIẾT TÍNH ĐIỂM -->
    <div class="modal fade" id="chiTietDiemModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content" style="border-radius: 12px; border: none;">
                <div class="modal-header" style="border-bottom: 1px solid #e5e7eb;">
                    <div>
                        <h5 class="modal-title fw-600" style="font-size: 1rem;">
                            📊 Chi Tiết Tính Điểm Xét Tuyển
                        </h5>
                        <small id="modal-nv-info" class="text-muted"></small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <!-- Meta badges -->
                <div class="px-4 py-2 d-flex gap-2 flex-wrap"
                    style="border-bottom: 1px solid #e5e7eb; background: #f9fafb;">
                    <span class="badge rounded-pill"
                        style="background:#EFF6FF;color:#1d4ed8;font-weight:600;font-size:.75rem"
                        id="badge-nganh"></span>
                    <span class="badge rounded-pill"
                        style="background:#F0FDF4;color:#15803d;font-weight:600;font-size:.75rem"
                        id="badge-pt"></span>
                    <span class="badge rounded-pill"
                        style="background:#FFFBEB;color:#b45309;font-weight:600;font-size:.75rem"
                        id="badge-th"></span>
                    <span class="badge rounded-pill"
                        style="background:#FFFBEB;color:#b40909;font-weight:600;font-size:.75rem"
                        id="badge-kq"></span>
                </div>

                <div class="modal-body p-4" id="modal-chitiet-body">
                    <!-- Nội dung được render bằng JS -->
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL LỌC NGUYỆN VỌNG -->
    <div id="filterNVOverlay" onclick="onOverlayClick(event)">
        <div class="filter-nv-modal">
            <div class="filter-nv-header">
                <span class="filter-nv-title">
                    <i class="bi bi-funnel-fill" style="color:#1d4ed8;"></i> Lọc & Sắp xếp
                </span>
                <button class="filter-nv-close" onclick="closeFilterModal()" aria-label="Đóng">
                    <i class="bi bi-x"></i>
                </button>
            </div>

            <div class="filter-nv-group">
                <div class="filter-nv-label">Ngành</div>
                <select class="filter-nv-select" id="fnvNganh">
                    <option value="">Tất cả ngành</option>
                    <c:forEach var="n" items="${dsNganhFilter}">
                        <option value="${n}" ${n == nganhFilter ? 'selected' : ''}>${n}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="filter-nv-group">
                <div class="filter-nv-label">Tổ hợp môn</div>
                <select class="filter-nv-select" id="fnvToHop">
                    <option value="">Tất cả tổ hợp</option>
                    <c:forEach var="t" items="${dsToHopFilter}">
                        <option value="${t}" ${t == tohopFilter ? 'selected' : ''}>${t}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="filter-nv-group">
                <div class="filter-nv-label">Sắp xếp điểm xét tuyển</div>
                <div class="sort-btns-nv">
                    <button class="sort-opt-nv" id="fnvSortAsc" onclick="fnvSelectSort('asc')">
                        <i class="bi bi-sort-numeric-up"></i> Tăng dần
                    </button>
                    <button class="sort-opt-nv" id="fnvSortDesc" onclick="fnvSelectSort('desc')">
                        <i class="bi bi-sort-numeric-down"></i> Giảm dần
                    </button>
                </div>
            </div>

            <button class="btn-apply-filter-nv" onclick="fnvApply()">
                <i class="bi bi-check-lg"></i> Áp dụng
            </button>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.querySelectorAll('.btn-chi-tiet').forEach(function(btn) {
        btn.addEventListener('click', function() {

            // ── 1. Lấy data từ attribute ──
            var nvTt       = this.dataset.nvTt;
            var maNganh    = this.dataset.maNganh;
            var phuongThuc = this.dataset.phuongThuc;
            var toHop      = this.dataset.toHop;
            var toHopGoc   = this.dataset.toHopGoc;
            var ketQua     = this.dataset.ketQua;

            // Điểm đã tính sẵn từ backend — dùng thẳng, không tính lại
            var diemThxt  = parseFloat(this.dataset.diemThxt  || '0');
            var diemThgxt = parseFloat(this.dataset.diemThgxt || '0');
            var diemCong  = parseFloat(this.dataset.diemCong  || '0');
            var diemCongCC   = parseFloat(this.dataset.diemCongCc   || '0');
            var diemCongUtxt = parseFloat(this.dataset.diemCongUtxt || '0');
            var diemUtqd  = parseFloat(this.dataset.diemUtqd  || '0');
            var diemXt    = parseFloat(this.dataset.diemXt    || '0');
            var lech      = parseFloat(this.dataset.lech      || '0');
            var diemDauVao      = this.dataset.diemDauVao      || '';
            var mocQuyDoi       = this.dataset.mocQuyDoi       || '';
            var congThucTongQuat= this.dataset.congThucTongQuat || '';
            var congThucThaySo  = this.dataset.congThucThaySo  || '';
            var ghiChu          = this.dataset.ghiChu          || '';
            var danhSachGiaiB64 = this.dataset.danhSachGiai || '';
            var doiTuong = this.dataset.doiTuong || '';
            var khuVuc   = this.dataset.khuVuc   || '';

            // ── 2. Parse danh sách môn từ JSON ──
            var rawB64  = this.dataset.danhSachMon || '';
            var monHoc  = [];
            var isError = false;
            var errorMsg = '';

            try {
                var jsonStr = '[]';
                if (rawB64) {
                    try {
                        jsonStr = decodeURIComponent(escape(atob(rawB64)));
                    } catch(e64) {
                        jsonStr = rawB64;
                    }
                }

                var parsed = JSON.parse(jsonStr);
                if (Array.isArray(parsed)) {
                    monHoc = parsed;
                } else if (parsed && parsed.error) {
                    isError  = true;
                    errorMsg = parsed.error;
                }
            } catch(e) {
                isError  = true;
                errorMsg = 'Không tìm thấy dữ liệu tổ hợp cho nguyện vọng này.';
            }

            // ── 3. Gán badges ──
            document.getElementById('badge-nganh').textContent = 'Mã ngành: '    + maNganh;
            document.getElementById('badge-pt').textContent    = 'Phương thức: ' + phuongThuc;
            document.getElementById('badge-th').textContent    = 'Tổ hợp: '      + toHop;
            document.getElementById('modal-nv-info').textContent =
                'Nguyện vọng ' + nvTt + ' — Chi tiết từng bước tính điểm';
            document.getElementById('badge-kq').textContent   = 'Kết quả: '     + ketQua;

            // ── 4. Render body modal ──
            var body = '';
            if (isError) {
                body = '<div style="padding:20px;color:#dc2626;background:#fef2f2;border-radius:8px;border:1px solid #fca5a5">'
                    + '⚠️ ' + errorMsg + '</div>';
            } else {
                var pt = phuongThuc ? phuongThuc.toUpperCase() : '';
                // "XÉT THPT", "ĐÁNH GIÁ V-SAT", "ĐGNL HCM"
                if (pt.indexOf('TUYỂN THẲNG') >= 0 || pt.indexOf('TUYEN THANG') >= 0) {
                    body = renderTuyenThang(danhSachGiaiB64, diemCong, diemCongCC, diemCongUtxt, diemUtqd, diemXt);
                } else if (pt.indexOf('DGNL') >= 0 || pt.indexOf('ĐGNL') >= 0) {
                    body = renderDGNL(diemThxt, diemCong, diemCongCC, diemCongUtxt, diemUtqd, diemXt, diemThgxt, diemDauVao, mocQuyDoi, congThucTongQuat, congThucThaySo, ghiChu, doiTuong, khuVuc);
                } else if (pt.indexOf('V-SAT') >= 0 || pt.indexOf('VSAT') >= 0) {
                    body = renderTHPT(toHop, toHopGoc, monHoc, lech, diemThxt, diemThgxt, diemCong, diemCongCC, diemCongUtxt, diemUtqd, diemXt, true, doiTuong, khuVuc);
                } else {
                    // Mặc định còn lại là THPT
                    body = renderTHPT(toHop, toHopGoc, monHoc, lech, diemThxt, diemThgxt, diemCong, diemCongCC, diemCongUtxt, diemUtqd, diemXt, false, doiTuong, khuVuc);
                }
            }

            document.getElementById('modal-chitiet-body').innerHTML = body;
            new bootstrap.Modal(document.getElementById('chiTietDiemModal')).show();
        });
    });

    /* ==================== RENDER THPT / V-SAT ==================== */
    // Dùng thẳng điểm từ backend — không tính lại
    function renderTHPT(toHop, toHopGoc, monHoc, lech, diemThxt, diemThgxt, diemCong, diemCongCC, diemCongUtxt, diemUtqd, diemXt, isVSAT, doiTuong, khuVuc) {

        var noteCC = '';

        var scoreCells = monHoc.map(function(mon) {
            var extraHtml = '';
            var diemHienThi = mon.diem;

            if (mon.isNgoaiNgu) {
                var dThi = mon.diemThi != null ? parseFloat(mon.diemThi) : null;
                var dNoiSuy = mon.diemNoiSuy != null ? parseFloat(mon.diemNoiSuy) : null;
                var dCc = mon.diemCc != null ? parseFloat(mon.diemCc) : null;
                var isChosenCc = mon.ccDuocChon === true || mon.ccDuocChon === 'true';

                if (isChosenCc && dCc != null) {
                    diemHienThi = dCc.toFixed(2);
                } else if (isVSAT && dNoiSuy != null) {
                    diemHienThi = dNoiSuy.toFixed(2);
                } else if (dThi != null) {
                    diemHienThi = dThi.toFixed(2);
                }

                var badgeThi = '';
                var badgeCc = '';

                if (isChosenCc && dCc != null && dNoiSuy != null) {
                    badgeThi =
                        '<div style="font-size:0.72rem;margin-top:4px;padding:3px 9px;border-radius:10px;display:inline-block;'
                        + 'background:#dbeafe;color:#1d4ed8;font-weight:700;border:2px solid #93c5fd">'
                        + 'V-SAT: ' + dNoiSuy.toFixed(2)
                        + '</div>';
                }

                if (dThi == null && dNoiSuy == null && dCc == null) {
                    badgeThi = '<div style="font-size:0.71rem;color:#9ca3af;margin-top:4px">Không có điểm</div>';
                }

                extraHtml =
                    '<div style="margin-top:5px;display:flex;flex-direction:column;align-items:center;gap:2px">'
                    + badgeThi + badgeCc
                    + '</div>';
            }

            return '<div class="ct-score-item">'
                + '<div class="ct-score-name">' + mon.ten + '</div>'
                + '<div class="ct-score-val">' + diemHienThi + '</div>'
                + '<div class="ct-score-wt">Hệ số ' + mon.heSo + '</div>'
                + extraHtml
                + '</div>';
        }).join('');

        var W = monHoc.reduce(function(s, m) {
            return s + Number(m.heSo || 0);
        }, 0);

        var formulaParts = monHoc.map(function(m) {
            return m.diem + '&times;' + m.heSo;
        }).join(' + ');

        var noiSuyVSAT = '';

        if (isVSAT) {
            var noiSuyRows = monHoc.map(function(mon) {
                var coChiTiet = mon.mocQuyDoi && mon.congThucThaySo;
                var isChosenCc = mon.ccDuocChon === true || mon.ccDuocChon === 'true';

                var diemNoiSuyText = mon.diemNoiSuy != null ? mon.diemNoiSuy : mon.diem;
                var diemHienThiText = isChosenCc && mon.diemCc != null ? mon.diemCc : diemNoiSuyText;

                return '<div style="border:1px solid #e0f2fe;border-radius:8px;padding:10px 12px;margin-bottom:8px;background:#f0f9ff">'
                    + '<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:6px">'
                    + '<span style="font-weight:700;color:#0369a1;font-size:0.82rem">Môn: ' + mon.ten + '</span>'
                    + '<span style="font-size:0.78rem;color:#6b7280">Điểm thô V-SAT: <strong style="color:#111">' + mon.diemTho + '</strong>'
                    + ' → Nội suy thang 10: <strong style="color:#0d9488">' + diemNoiSuyText + '</strong></span>'
                    + '</div>'
                    + (coChiTiet
                        ? '<div style="font-size:0.75rem;color:#6b7280;margin-bottom:3px">Mốc: <strong style="color:#374151">' + mon.mocQuyDoi + '</strong></div>'
                        + '<div style="background:#fff;border:1px solid #bae6fd;border-radius:5px;padding:5px 9px;font-family:monospace;font-size:0.76rem;color:#0369a1">'
                        + mon.congThucThaySo
                        + '</div>'
                        : '<div style="font-size:0.75rem;color:#9ca3af;font-style:italic">Không có dữ liệu nội suy</div>'
                    )
                    + '</div>';
            }).join('');

            noiSuyVSAT =
                '<div style="margin:4px 0 10px">'
                + '<div style="font-size:0.78rem;font-weight:700;color:#0369a1;margin-bottom:6px;'
                + 'padding:5px 10px;background:#e0f2fe;border-radius:6px;display:inline-block">'
                + 'Chi tiết nội suy V-SAT → Thang điểm 10</div>'
                + noiSuyRows
                + '</div>';

            var monCC = monHoc.find(function(m) {
                return m.isNgoaiNgu &&
                    (m.ccDuocChon === true || m.ccDuocChon === 'true');
            });

            if (monCC) {
                noteCC =
                    '<div style="margin-top:10px;padding:10px 12px;'
                    + 'background:#ecfdf5;border:1px solid #86efac;'
                    + 'border-radius:8px;font-size:0.78rem;'
                    + 'color:#166534;font-weight:600;">'
                    + 'Vì điểm chứng chỉ ngoại ngữ cao hơn điểm nội suy V-SAT '
                    + '→ hệ thống sử dụng điểm chứng chỉ để tính ĐTHXT.'
                    + '</div>';
            }
        }

        var sameTH = Math.abs(lech) < 0.001;

        var sumThgxtCong = diemThgxt + diemCong;
        var mdutObj = tinhMDUT(doiTuong, khuVuc);
        var mdut = mdutObj.tong;

        var dutFormula = sumThgxtCong < 22.5
            ? 'Vì ' + sumThgxtCong.toFixed(2) + ' &lt; 22,5 → Cộng ưu tiên bình thường (MĐƯT: ƯT Khu vực + ƯT Đối tượng = ' + mdutObj.diemKV.toFixed(2) + ' + ' + mdutObj.diemDT.toFixed(2) + ' = ' + mdut.toFixed(2) + ')'
            : 'Vì ' + sumThgxtCong.toFixed(2) + ' &ge; 22,5 → [(30 &minus; ' + diemThgxt.toFixed(2) + ' &minus; ' + diemCong.toFixed(2) + ') / 7.5] &times; ' + mdut.toFixed(2);

        return ''
            + '<p class="ct-section-title">'
            + (isVSAT ? 'Bước 1 — Điểm từng môn (đã quy về thang 10 theo bảng V-SAT)' : 'Bước 1 — Điểm thi từng môn')
            + '</p>'
            + '<div class="ct-score-grid">' + scoreCells + '</div>'

            + noiSuyVSAT

            + '<div class="ct-step-card">'
            + '<div class="ct-step-label">Bước 2 — Tính ĐTHXT (điểm tổ hợp xét tuyển)</div>'
            + '<div class="ct-formula">(' + formulaParts + ') / ' + W + ' &times; 3</div>'
            + '<div class="ct-result">ĐTHXT = <span class="val">' + diemThxt.toFixed(2) + '</span></div>'
            + noteCC
            + '</div>'

            + '<hr style="border-color:#e5e7eb;margin:14px 0">'
            + '<p class="ct-section-title">Bước 3 — Cộng điểm ưu tiên, điểm cộng & điểm lệch</p>'
            + '<div class="ct-step-card">'
            + row('ĐTHGXT', diemThgxt.toFixed(2))
            + row('Điểm cộng chứng chỉ', '+' + (diemCongCC || 0).toFixed(2))
            + row('Điểm cộng giải thưởng', '+' + (diemCongUtxt || 0).toFixed(2))
            + row('Điểm cộng (ĐC)', '+' + diemCong.toFixed(2))
            + row(dutFormula, '')
            + row('Điểm ưu tiên (ĐƯT)', '+' + diemUtqd.toFixed(2))
            + row(
                sameTH
                    ? 'Quy đổi về tổ hợp gốc <strong>' + toHopGoc + '</strong> (cùng tổ hợp, không cần quy đổi)'
                    : 'Quy đổi từ tổ hợp <strong>' + toHop + '</strong> về tổ hợp gốc <strong>' + toHopGoc + '</strong>',
                sameTH ? '0.00' : ((lech >= 0 ? '+' : '') + lech.toFixed(2))
            )
            + '</div>'

            + '<div class="ct-note">ĐXT = ĐTHXT + ĐC + ĐƯT + Độ Lệch = '
            + diemThxt.toFixed(2) + ' + ' + diemCong.toFixed(2) + ' + ' + diemUtqd.toFixed(2) + ((lech >= 0 ? '+' : '') + lech.toFixed(2))
            + ' = <strong>' + diemXt.toFixed(2) + '</strong> / 30 điểm</div>'
            + '<div class="ct-total-row">'
            + '<span class="ct-total-label">Điểm xét tuyển (ĐXT)</span>'
            + '<span class="ct-total-val">' + diemXt.toFixed(2) + '</span>'
            + '</div>';
    }

    /* ==================== RENDER ĐGNL ==================== */
    function renderDGNL(diemThxt, diemCong, diemCongCC, diemCongUtxt, diemUtqd, diemXt, diemThgxt,
                    diemDauVao, mocQuyDoi, congThucTongQuat, congThucThaySo, ghiChu, doiTuong, khuVuc) {

        var sumThgxtCong = diemThxt + diemCong;

        var mdutObj = tinhMDUT(doiTuong, khuVuc);
        var mdut = mdutObj.tong;

        var dutFormula = sumThgxtCong < 22.5
            ? 'Vì ' + sumThgxtCong.toFixed(2) + ' &lt; 22,5 → Cộng ưu tiên bình thường (MĐƯT = ' + mdut.toFixed(2) + ')'
            : 'Vì ' + sumThgxtCong.toFixed(2) + ' &ge; 22,5 → [(30 &minus; ' + diemThgxt.toFixed(2) + ' &minus; ' + diemCong.toFixed(2) + ') / 7.5] &times; ' + mdut.toFixed(2);

        // Block chi tiết nội suy (chỉ hiện nếu có data)
        var chiTietCongThuc = '';
        if (mocQuyDoi && congThucThaySo) {
            chiTietCongThuc = ''
            + '<div class="ct-step-card" style="border-left:3px solid #0d9488;background:#f0fdfa;margin-top:10px">'
            + '<div class="ct-step-label" style="color:#0f766e;font-weight:700">Chi tiết nội suy tuyến tính</div>'

            + '<div style="margin-top:8px;font-size:0.78rem;color:#374151">'
            + '<span style="color:#6b7280">Điểm đầu vào:</span> '
            + '<strong style="color:#111827">' + diemDauVao + '</strong>'
            + '</div>'

            + '<div style="margin-top:6px;font-size:0.78rem;color:#374151">'
            + '<span style="color:#6b7280">Mốc quy đổi:</span> '
            + '<strong style="color:#111827">' + mocQuyDoi + '</strong>'
            + '</div>'

            + '<div style="margin-top:8px;font-size:0.75rem;color:#6b7280">Công thức tổng quát:</div>'
            + '<div style="background:#fff;border:1px solid #ccfbf1;border-radius:6px;padding:7px 10px;'
            + 'margin-top:4px;font-family:monospace;font-size:0.78rem;color:#0f766e">'
            + (congThucTongQuat || 'y = c + ((x - a) / (b - a)) * (d - c)')
            + '</div>'

            + '<div style="margin-top:8px;font-size:0.75rem;color:#6b7280">Thay số:</div>'
            + '<div style="background:#fff;border:1px solid #ccfbf1;border-radius:6px;padding:7px 10px;'
            + 'margin-top:4px;font-family:monospace;font-size:0.78rem;color:#0f766e">'
            + congThucThaySo
            + '</div>'

            + (ghiChu ? '<div style="margin-top:8px;font-size:0.73rem;color:#6b7280;font-style:italic">' + ghiChu + '</div>' : '')
            + '</div>';
        }

        return ''
        + '<div class="ct-step-card">'
        + '<div class="ct-step-label">Bước 1 — Điểm thi ĐGNL (đã quy đổi tương đương về thang 30)</div>'
        + '<div class="ct-result">ĐTHXT = ĐTHGXT = <span class="val">' + diemThxt.toFixed(2) + '</span></div>'
        + '<div class="ct-note" style="margin-top:8px">Với phương thức ĐGNL: ĐTHGXT = ĐTHXT — không cần quy đổi tổ hợp gốc</div>'
        + '</div>'

        + chiTietCongThuc

        + '<hr style="border-color:#e5e7eb;margin:14px 0">'
        + '<p class="ct-section-title">Bước 2 — Cộng điểm ưu tiên & điểm cộng</p>'
        + '<div class="ct-step-card">'
        + row('ĐTHGXT', diemThxt.toFixed(2))
        + row('Điểm cộng chứng chỉ', '+' + (diemCongCC || 0).toFixed(2))
        + row('Điểm cộng giải thưởng', '+' + (diemCongUtxt || 0).toFixed(2))
        + row('Điểm cộng (ĐC)', '+' + diemCong.toFixed(2))
        + row(dutFormula, '')
        + row('Điểm ưu tiên (ĐƯT)', '+' + diemUtqd.toFixed(2))
        + '</div>'

        + '<div class="ct-note">ĐXT = ĐTHGXT + ĐC + ĐƯT = '
        + diemThxt.toFixed(2) + ' + ' + diemCong.toFixed(2) + ' + ' + diemUtqd.toFixed(2)
        + ' = <strong>' + diemXt.toFixed(2) + '</strong> / 30 điểm</div>'
        + '<div class="ct-total-row">'
        + '<span class="ct-total-label">Điểm xét tuyển (ĐXT)</span>'
        + '<span class="ct-total-val">' + diemXt.toFixed(2) + '</span>'
        + '</div>';
    }

    function row(label, val) {
        return '<div class="ct-add-row">'
            + '<span class="ct-add-label">' + label + '</span>'
            + '<span class="ct-add-val">'   + val   + '</span>'
            + '</div>';
    }

    /* ==================== RENDER Tuyen Thang ==================== */
    function renderTuyenThang(b64, diemCong, diemCongCC, diemCongUtxt, diemUtqd, diemXt) {
        var dsGiai = [];
        try {
            var json = decodeURIComponent(escape(atob(b64)));
            dsGiai = JSON.parse(json);
        } catch(e) {}

        function tenMonHienThi(raw) {
            raw = (raw || '').trim();
            var u = raw.toUpperCase();
            if (/^NK[1-6]$/.test(u)) return 'Năng Khiếu ' + u.substring(2);
            return raw;
        }

        var giaiRows = '';
        if (dsGiai.length === 0) {
            giaiRows = '<div style="color:#6b7280;font-style:italic">Không có dữ liệu giải thưởng</div>';
        } else {
            giaiRows = dsGiai.map(function(g) {
                return '<div style="display:flex;align-items:center;gap:12px;'
                    + 'padding:12px 16px;border:1px solid #e0f2fe;border-radius:8px;margin-bottom:8px;background:#f0f9ff">'
                    + '<span style="font-size:1.4rem;">🏆</span>'
                    + '<div>'
                    + '<div style="font-weight:700;color:#0369a1;font-size:0.9rem">' + g.loaiGiai + '</div>'
                    + '<div style="font-size:0.8rem;color:#374151;margin-top:3px">'
                    + 'Môn: <strong>' + tenMonHienThi(g.maMon) + '</strong>'
                    + ' &nbsp;|&nbsp; Cấp: <strong>' + g.capGiai + '</strong>'
                    + ' &nbsp;|&nbsp; Đối tượng: <strong>' + g.doiTuong + '</strong>'
                    + '</div>'
                    + '</div>'
                    + '</div>';
            }).join('');
        }

        return '<p class="ct-section-title">Giải thưởng & Điều kiện tuyển thẳng</p>'
            + '<div>' + giaiRows + '</div>'

            + '<hr style="border-color:#e5e7eb;margin:14px 0">'
            + '<div class="ct-step-card">'
            + row('Điểm cộng chứng chỉ', '+' + (diemCongCC || 0).toFixed(2))
            + row('Điểm cộng giải thưởng', '+' + (diemCongUtxt || 0).toFixed(2))
            + row('Điểm cộng (ĐC)', '+' + (diemCong || 0).toFixed(2))
            + row('Điểm ưu tiên (ĐƯT)', '+' + (diemUtqd || 0).toFixed(2))
            + '</div>'

            + '<div class="ct-total-row">'
            + '<span class="ct-total-label">Điểm xét tuyển (ĐXT)</span>'
            + '<span class="ct-total-val">' + (diemXt || 0).toFixed(2) + '</span>'
            + '</div>';
    }

    // ── Lọc Nguyện Vọng ──
    (function () {
        // Luôn khai báo các hàm global trước để tránh case init bị crash
        window._fnvState = window._fnvState || { nganh: '', tohop: '', sort: null };

        function _el(id) { return document.getElementById(id); }

        window.openFilterModal = function () {
            var overlay = _el('filterNVOverlay');
            if (!overlay) return;

            var s = window._fnvState || { nganh: '', tohop: '', sort: null };
            var selN = _el('fnvNganh');
            var selT = _el('fnvToHop');

            if (selN) selN.value = s.nganh || '';
            if (selT) selT.value = s.tohop || '';

            var asc = _el('fnvSortAsc');
            var desc = _el('fnvSortDesc');
            if (asc) asc.classList.toggle('selected', s.sort === 'asc');
            if (desc) desc.classList.toggle('selected', s.sort === 'desc');

            overlay.classList.add('show');
        };

        window.closeFilterModal = function () {
            var overlay = _el('filterNVOverlay');
            if (overlay) overlay.classList.remove('show');
        };

        window.onOverlayClick = function (e) {
            var overlay = _el('filterNVOverlay');
            if (overlay && e.target === overlay) window.closeFilterModal();
        };

        window.fnvSelectSort = function (dir) {
            var s = window._fnvState || (window._fnvState = { nganh: '', tohop: '', sort: null });
            s.sort = (s.sort === dir) ? null : dir;

            var asc = _el('fnvSortAsc');
            var desc = _el('fnvSortDesc');
            if (asc) asc.classList.toggle('selected', s.sort === 'asc');
            if (desc) desc.classList.toggle('selected', s.sort === 'desc');
        };

        window.fnvApply = function () {
            var selN = _el('fnvNganh');
            var selT = _el('fnvToHop');
            var nganh = selN ? selN.value : '';
            var tohop = selT ? selT.value : '';
            var sort = (window._fnvState || {}).sort;

            // để relative URL cho chắc (khỏi dính contextPath)
            var url = 'ketqua?page=0';
            if (nganh) url += '&nganh=' + encodeURIComponent(nganh);
            if (tohop) url += '&tohop=' + encodeURIComponent(tohop);
            if (sort) url += '&sort=' + encodeURIComponent(sort);

            window.location.href = url;
        };

        // Init data attributes + populate dropdowns (không để crash kill toàn bộ script)
        try {
            document.querySelectorAll('.nv-table tbody tr').forEach(function (tr) {
                var cells = tr.querySelectorAll('td');
                if (cells.length < 5) return;
                tr.dataset.nganh = (cells[1].textContent || '').trim();
                tr.dataset.tohop = (cells[3].textContent || '').trim();
                tr.dataset.diem = parseFloat((cells[4].textContent || '').trim()) || 0;
            });

            var selN = _el('fnvNganh');
            var selT = _el('fnvToHop');
        } catch (e) {
            console.warn('Filter NV init failed:', e);
        }

        function fnvRender() {
            var s = window._fnvState;
            var rows = Array.from(document.querySelectorAll('.nv-table tbody tr'));

            // Filter
            rows.forEach(function (tr) {
                var show = true;
                if (s.nganh && tr.dataset.nganh !== s.nganh) show = false;
                if (s.tohop && tr.dataset.tohop !== s.tohop) show = false;
                tr.style.display = show ? '' : 'none';
            });

            // Sort
            if (s.sort) {
                var visible = rows.filter(r => r.style.display !== 'none');
                visible.sort(function (a, b) {
                    return s.sort === 'asc'
                        ? a.dataset.diem - b.dataset.diem
                        : b.dataset.diem - a.dataset.diem;
                });
                var tbody = document.querySelector('.nv-table tbody');
                visible.forEach(function (tr) { tbody.appendChild(tr); });
            }

            // Cập nhật trạng thái nút phễu
            var hasFilter = s.nganh || s.tohop || s.sort;
            document.getElementById('btnFilterNV').classList.toggle('active', !!hasFilter);
        }

        // Sync state từ querystring (để mở modal thấy đúng lựa chọn)
        try {
            var params = new URLSearchParams(window.location.search || '');
            var s0 = window._fnvState || (window._fnvState = { nganh: '', tohop: '', sort: null });
            s0.nganh = params.get('nganh') || '';
            s0.tohop = params.get('tohop') || '';
            var sort0 = params.get('sort');
            s0.sort = (sort0 === 'asc' || sort0 === 'desc') ? sort0 : null;
        } catch (e) {
            // ignore
        }

        // Bind change events
        var selN2 = _el('fnvNganh');
        if (selN2) {
            selN2.addEventListener('change', function () {
                window._fnvState.nganh = this.value || '';
                fnvRender();
            });
        }
        var selT2 = _el('fnvToHop');
        if (selT2) {
            selT2.addEventListener('change', function () {
                window._fnvState.tohop = this.value || '';
                fnvRender();
            });
        }

        // Render lần đầu (tô trạng thái phễu)
        fnvRender();
    })();
    /* ==================== TÍNH MĐƯT ==================== */
    function tinhMDUT(doiTuong, khuVuc) {
        doiTuong = (doiTuong || '').trim().toUpperCase();
        khuVuc   = (khuVuc   || '').trim().toUpperCase();

        var diemDT = 0;
        if (['ĐT1','ĐT2','ĐT3','ĐT4','DT4','04','DT1','DT2','DT3','01','02','03'].some(function(v){ return doiTuong.includes(v); })) {
            diemDT = 2.00;
        } else if (['ĐT7','ĐT5','ĐT6','DT7','DT5','DT6','07','05','06'].some(function(v){ return doiTuong.includes(v); })) {
            diemDT = 1.00;
        }

        var diemKV = 0;
        if      (khuVuc.includes('KV1')  && !khuVuc.includes('KV2') && !khuVuc.includes('KV3')) diemKV = 0.75;
        else if (khuVuc.includes('2-NT') || khuVuc.includes('2NT'))  diemKV = 0.50;
        else if (khuVuc.includes('KV2')  && !khuVuc.includes('KV3')) diemKV = 0.25;
        else if (khuVuc.includes('KV3'))                              diemKV = 0.00;

        return {
            diemDT: diemDT,
            diemKV: diemKV,
            tong: diemDT + diemKV
        };
    }
    var doiTuong = "${thiSinh.doiTuong}";
    var khuVuc = "${thiSinh.khuVuc}";

    var ketQua = tinhMDUT(doiTuong, khuVuc);

    document.getElementById("diemDoiTuong").innerText = ketQua.diemDT.toFixed(2);
    document.getElementById("diemKhuVuc").innerText = ketQua.diemKV.toFixed(2);
</script>
</body>
</html>