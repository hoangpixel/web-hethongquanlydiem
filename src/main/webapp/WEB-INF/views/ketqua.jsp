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
                    <a class="nav-link" href="/tinh-diem" style="font-weight: 500;">Tính Điểm Tốt Nghiệp</a>
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
                                            data-diem-utqd="${nv.diemUtqd}"
                                            data-diem-xt="${nv.diemXetTuyen}"
                                            data-danh-sach-mon="${nv.danhSachMonJson}"
                                            data-diem-dau-vao="${nv.diemDauVao}"
                                            data-moc-quy-doi="${nv.mocQuyDoi}"
                                            data-cong-thuc-tong-quat="${nv.congThucTongQuat}"
                                            data-cong-thuc-thay-so="${nv.congThucThaySo}"
                                            data-ghi-chu="${nv.ghiChu}">
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

                <div class="pagination">
                    <c:if test="${currentPage > 0}">
                        <a href="?page=${currentPage - 1}">Prev</a>
                    </c:if>

                    <span>Trang ${currentPage + 1}</span>

                    <c:if test="${currentPage < totalPages - 1}">
                        <a href="?page=${currentPage + 1}">Next</a>
                    </c:if>
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
                </div>

                <div class="modal-body p-4" id="modal-chitiet-body">
                    <!-- Nội dung được render bằng JS -->
                </div>
            </div>
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

            // Điểm đã tính sẵn từ backend — dùng thẳng, không tính lại
            var diemThxt  = parseFloat(this.dataset.diemThxt  || '0');
            var diemThgxt = parseFloat(this.dataset.diemThgxt || '0');
            var diemCong  = parseFloat(this.dataset.diemCong  || '0');
            var diemUtqd  = parseFloat(this.dataset.diemUtqd  || '0');
            var diemXt    = parseFloat(this.dataset.diemXt    || '0');
            var lech      = parseFloat(this.dataset.lech      || '0');
            var diemDauVao      = this.dataset.diemDauVao      || '';
            var mocQuyDoi       = this.dataset.mocQuyDoi       || '';
            var congThucTongQuat= this.dataset.congThucTongQuat || '';
            var congThucThaySo  = this.dataset.congThucThaySo  || '';
            var ghiChu          = this.dataset.ghiChu          || '';

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

            // ── 4. Render body modal ──
            var body = '';
            if (isError) {
                body = '<div style="padding:20px;color:#dc2626;background:#fef2f2;border-radius:8px;border:1px solid #fca5a5">'
                    + '⚠️ ' + errorMsg + '</div>';
            } else {
                var pt = phuongThuc ? phuongThuc.toUpperCase() : '';
                // "XÉT THPT", "ĐÁNH GIÁ V-SAT", "ĐGNL HCM"
                if (pt.indexOf('DGNL') >= 0 || pt.indexOf('ĐGNL') >= 0) {
                    body = renderDGNL(diemThxt, diemCong, diemUtqd, diemXt,
                                    diemDauVao, mocQuyDoi, congThucTongQuat, congThucThaySo, ghiChu);
                } else if (pt.indexOf('V-SAT') >= 0 || pt.indexOf('VSAT') >= 0) {
                    body = renderTHPT(toHop, toHopGoc, monHoc, lech, diemThxt, diemThgxt, diemCong, diemUtqd, diemXt, true);
                } else {
                    // Mặc định còn lại là THPT
                    body = renderTHPT(toHop, toHopGoc, monHoc, lech, diemThxt, diemThgxt, diemCong, diemUtqd, diemXt, false);
                }
            }

            document.getElementById('modal-chitiet-body').innerHTML = body;
            new bootstrap.Modal(document.getElementById('chiTietDiemModal')).show();
        });
    });

    /* ==================== RENDER THPT / V-SAT ==================== */
    // Dùng thẳng điểm từ backend — không tính lại
    function renderTHPT(toHop, toHopGoc, monHoc, lech, diemThxt, diemThgxt, diemCong, diemUtqd, diemXt, isVSAT) {

        // Bước 1: lưới điểm môn
        var scoreCells = monHoc.map(function(mon) {
            return '<div class="ct-score-item">'
                + '<div class="ct-score-name">' + mon.ten + '</div>'
                + '<div class="ct-score-val">'  + mon.diem + '</div>'
                + '<div class="ct-score-wt">Hệ số ' + mon.heSo + '</div>'
                + '</div>';
        }).join('');

        // Bước 2: công thức ĐTHXT
        var W = monHoc.reduce(function(s, m) { return s + m.heSo; }, 0);
        var formulaParts = monHoc.map(function(m) {
            return m.diem + '&times;' + m.heSo;
        }).join(' + ');
        
        // Block chi tiết nội suy V-SAT (chỉ hiện nếu có data)
        var noiSuyVSAT = '';
        if (isVSAT) {
            var noiSuyRows = monHoc.map(function(mon) {
                var coChiTiet = mon.mocQuyDoi && mon.congThucThaySo;
                return '<div style="border:1px solid #e0f2fe;border-radius:8px;padding:10px 12px;margin-bottom:8px;background:#f0f9ff">'
                    + '<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:6px">'
                    + '<span style="font-weight:700;color:#0369a1;font-size:0.82rem">📌 Môn: ' + mon.ten + '</span>'
                    + '<span style="font-size:0.78rem;color:#6b7280">Điểm thô V-SAT: <strong style="color:#111">' + mon.diemTho + '</strong>'
                    + ' → Quy đổi thang 10: <strong style="color:#0d9488">' + mon.diem + '</strong></span>'
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

            noiSuyVSAT = ''
                + '<div style="margin:4px 0 10px">'
                + '<div style="font-size:0.78rem;font-weight:700;color:#0369a1;margin-bottom:6px;'
                + 'padding:5px 10px;background:#e0f2fe;border-radius:6px;display:inline-block">'
                + '🔄 Chi tiết nội suy V-SAT → Thang điểm 10</div>'
                + noiSuyRows
                + '</div>';
        }

        // Bước 3: quy đổi tổ hợp gốc
        var sameTH  = (Math.abs(lech) < 0.001);
        var lechStr = '';
        if (!sameTH) {
            var sign = lech > 0 ? '-' : '+';
            lechStr  = diemThxt.toFixed(2) + ' ' + sign + ' ' + Math.abs(lech).toFixed(2)
                    + ' = ' + diemThgxt.toFixed(2);
        }

        // Bước 4: công thức ĐƯT
        var sumThgxtCong = diemThgxt + diemCong;
        var dutFormula = sumThgxtCong < 22.5
            ? 'Vì ' + sumThgxtCong.toFixed(2) + ' &lt; 22,5 → Cộng ưu tiên bình thường'
            : 'Vì ' + sumThgxtCong.toFixed(2) + ' &ge; 22,5 → [(30 &minus; ' + diemThgxt.toFixed(2) + ' &minus; ' + diemCong.toFixed(2) + ') / 7.5] &times; MĐƯT';

        return ''
        // Bước 1
        + '<p class="ct-section-title">'
        + (isVSAT ? 'Bước 1 — Điểm từng môn (đã quy về thang 10 theo bảng V-SAT)'
                : 'Bước 1 — Điểm thi từng môn')
        + '</p>'
        + '<div class="ct-score-grid">' + scoreCells + '</div>'

        + noiSuyVSAT 

        // Bước 2
        + '<div class="ct-step-card">'
        + '<div class="ct-step-label">Bước 2 — Tính ĐTHXT (điểm tổ hợp xét tuyển)</div>'
        + '<div class="ct-formula">(' + formulaParts + ') / ' + W + ' &times; 3</div>'
        + '<div class="ct-result">ĐTHXT = <span class="val">' + diemThxt.toFixed(2) + '</span></div>'
        + '</div>'

        // Bước 3
        + '<div class="ct-step-card">'
        + '<div class="ct-step-label">Bước 3 — Quy đổi về tổ hợp gốc <strong>' + toHopGoc + '</strong>'
        + (sameTH ? ' (cùng tổ hợp, không cần quy đổi)' : '') + '</div>'
        + (!sameTH ? '<div class="ct-formula">ĐTHGXT = ' + lechStr + '</div>' : '')
        + '<div class="ct-result">ĐTHGXT = <span class="val">' + diemThgxt.toFixed(2) + '</span></div>'
        + (!sameTH
            ? '<div class="ct-note">Mức chênh lệch tổ hợp <strong>' + toHop + '</strong> → <strong>'
            + toHopGoc + '</strong>: <strong>' + (lech >= 0 ? '+' : '') + lech.toFixed(2)
            + '</strong> điểm (theo bảng độ lệch THPT)</div>'
            : '')
        + '</div>'

        // Bước 4
        + '<hr style="border-color:#e5e7eb;margin:14px 0">'
        + '<p class="ct-section-title">Bước 4 — Cộng điểm ưu tiên & điểm cộng</p>'
        + '<div class="ct-step-card">'
        + row('ĐTHGXT', diemThgxt.toFixed(2))
        + row('Điểm cộng (ĐC)', '+' + diemCong.toFixed(2))
        + row(dutFormula, '')
        + row('Điểm ưu tiên (ĐƯT)', '+' + diemUtqd.toFixed(2))
        + '</div>'

        // Kết quả
        + '<div class="ct-total-row">'
        + '<span class="ct-total-label">Điểm xét tuyển (ĐXT)</span>'
        + '<span class="ct-total-val">' + diemXt.toFixed(2) + '</span>'
        + '</div>'
        + '<div class="ct-note">ĐXT = ĐTHGXT + ĐC + ĐƯT = '
        + diemThgxt.toFixed(2) + ' + ' + diemCong.toFixed(2) + ' + ' + diemUtqd.toFixed(2)
        + ' = <strong>' + diemXt.toFixed(2) + '</strong> / 30 điểm</div>';
    }

    /* ==================== RENDER ĐGNL ==================== */
    function renderDGNL(diemThxt, diemCong, diemUtqd, diemXt,
                    diemDauVao, mocQuyDoi, congThucTongQuat, congThucThaySo, ghiChu) {

        var sumThgxtCong = diemThxt + diemCong;
        var dutFormula = sumThgxtCong < 22.5
            ? 'Vì ' + sumThgxtCong.toFixed(2) + ' &lt; 22,5 → Cộng ưu tiên bình thường'
            : 'Vì ' + sumThgxtCong.toFixed(2) + ' &ge; 22,5 → [(30 &minus; ' + diemThxt.toFixed(2) + ' &minus; ' + diemCong.toFixed(2) + ') / 7.5] &times; MĐƯT';

        // Block chi tiết nội suy (chỉ hiện nếu có data)
        var chiTietCongThuc = '';
        if (mocQuyDoi && congThucThaySo) {
            chiTietCongThuc = ''
            + '<div class="ct-step-card" style="border-left:3px solid #0d9488;background:#f0fdfa;margin-top:10px">'
            + '<div class="ct-step-label" style="color:#0f766e;font-weight:700">📐 Chi tiết nội suy tuyến tính</div>'

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

            + (ghiChu ? '<div style="margin-top:8px;font-size:0.73rem;color:#6b7280;font-style:italic">💡 ' + ghiChu + '</div>' : '')
            + '</div>';
        }

        return ''
        + '<div class="ct-step-card">'
        + '<div class="ct-step-label">Bước 1 — Điểm thi ĐGNL (đã quy đổi tương đương về thang 30)</div>'
        + '<div class="ct-result">ĐTHXT = ĐTHGXT = <span class="val">' + diemThxt.toFixed(2) + '</span></div>'
        + '<div class="ct-note" style="margin-top:8px">Với phương thức ĐGNL: ĐTHGXT = ĐTHXT — không cần quy đổi tổ hợp gốc</div>'
        + '</div>'

        // ← Block chi tiết nội suy chèn vào đây
        + chiTietCongThuc

        + '<hr style="border-color:#e5e7eb;margin:14px 0">'
        + '<p class="ct-section-title">Bước 2 — Cộng điểm ưu tiên & điểm cộng</p>'
        + '<div class="ct-step-card">'
        + row('ĐTHGXT', diemThxt.toFixed(2))
        + row('Điểm cộng (ĐC)', '+' + diemCong.toFixed(2))
        + row(dutFormula, '')
        + row('Điểm ưu tiên (ĐƯT)', '+' + diemUtqd.toFixed(2))
        + '</div>'

        + '<div class="ct-total-row">'
        + '<span class="ct-total-label">Điểm xét tuyển (ĐXT)</span>'
        + '<span class="ct-total-val">' + diemXt.toFixed(2) + '</span>'
        + '</div>'
        + '<div class="ct-note">ĐXT = ĐTHGXT + ĐC + ĐƯT = '
        + diemThxt.toFixed(2) + ' + ' + diemCong.toFixed(2) + ' + ' + diemUtqd.toFixed(2)
        + ' = <strong>' + diemXt.toFixed(2) + '</strong> / 30 điểm</div>';
    }

    function row(label, val) {
        return '<div class="ct-add-row">'
            + '<span class="ct-add-label">' + label + '</span>'
            + '<span class="ct-add-val">'   + val   + '</span>'
            + '</div>';
    }
</script>
</body>
</html>