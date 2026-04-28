<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Công cụ Quy Đổi Điểm V-SAT</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --brand-1: #0f766e;
            --brand-2: #0ea5e9;
            --brand-3: #f59e0b;
            --ink: #0f172a;
            --muted: #64748b;
            --surface: #ffffff;
        }
        body {
            background:
                radial-gradient(circle at 10% 20%, rgba(14, 165, 233, 0.15), transparent 34%),
                radial-gradient(circle at 90% 10%, rgba(245, 158, 11, 0.15), transparent 30%),
                linear-gradient(145deg, #f0f7fb 0%, #eef7f5 100%);
            font-family: 'Oswald', sans-serif;
            font-size: 16px; 
            color: var(--ink);
            min-height: 100vh;
            padding-bottom: 40px;
        }
        .main-card {
            border: 1px solid rgba(255, 255, 255, 0.8);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(15, 23, 42, 0.08);
            margin-top: 50px;
            backdrop-filter: blur(12px);
            background: rgba(255, 255, 255, 0.95);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .main-card:hover {
            box-shadow: 0 25px 50px rgba(15, 23, 42, 0.12);
        }
        .card-header {
            background: linear-gradient(135deg, var(--brand-1), var(--brand-2) 70%, #22d3ee);
            color: white;
            text-align: center;
            padding: 30px 24px;
            position: relative;
            border-bottom: none;
        }
        .card-header::after {
            content: "";
            position: absolute;
            right: -30px;
            top: -50px;
            width: 180px;
            height: 180px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            pointer-events: none;
        }
        .card-header::before {
            content: "";
            position: absolute;
            left: -40px;
            bottom: -40px;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
            pointer-events: none;
        }
        .header-title {
            font-weight: 700;
            letter-spacing: 0.5px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            font-size: 1.8rem; 
        }
        .header-title, h5 { font-family: 'Oswald', sans-serif; }
        .result-box {
            background: #f8fcff;
            border-left: 5px solid var(--brand-2);
            padding: 20px;
            border-radius: 12px;
            margin-top: 25px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
        }
        .formula-card {
            border: 1px dashed rgba(15, 118, 110, 0.35);
            border-radius: 12px;
            padding: 14px;
            background: #ffffff;
        }
        .formula-title {
            color: var(--brand-1);
            font-weight: 700;
            margin-bottom: 6px;
        }
        .formula-code {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: #f1f5f9;
            border-radius: 8px;
            padding: 8px 10px;
            display: block;
            color: #0f172a;
            margin-bottom: 6px;
            font-size: 0.98rem;
        }
        .form-control, .form-select {
            border-radius: 12px;
            border: 1.5px solid #cbd5e1;
            min-height: 52px; 
            padding: 10px 16px;
            background-color: #f8fafc;
            transition: all 0.2s ease;
            font-size: 1rem; 
        }
        .form-control:focus, .form-select:focus {
            background-color: #ffffff;
            border-color: var(--brand-2);
            box-shadow: 0 0 0 4px rgba(14, 165, 233, 0.15);
        }
        .form-label {
            font-size: 1.1rem; 
            margin-bottom: 8px;
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--brand-1), var(--brand-2));
            border: none;
            border-radius: 14px;
            font-weight: 600;
            letter-spacing: 0.5px;
            padding: 14px;
            font-size: 1.05rem; 
            box-shadow: 0 8px 16px rgba(14, 165, 233, 0.2);
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 20px rgba(14, 165, 233, 0.3);
        }
        .note {
            color: var(--muted);
            font-size: 0.95rem; 
            font-style: italic;
        }
        .footer-text {
            text-align: center;
            margin-top: 30px;
            color: var(--muted);
            font-size: 1.05rem; 
            font-weight: 500;
        }
        .footer-text span {
            background: linear-gradient(120deg, var(--brand-1), var(--brand-2));
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <a href="/ketqua" class="btn btn-outline-secondary" style="border-radius: 10px;">&larr; Quay lại trang Kết Quả</a>
</div>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            <div class="card main-card">
                <div class="card-header">
                    <h3 class="mb-0 header-title">TÍNH ĐIỂM XÉT TUYỂN</h3>
                    <p class="mb-0 mt-2" style="color: rgba(255,255,255,0.9); font-size: 1.05rem;">
                        THPT, V-SAT, ĐGNL với hệ số theo mã ngành và tổ hợp
                    </p>
                </div>
                <div class="card-body p-4 p-md-5">
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger rounded-3 border-0 shadow-sm" role="alert">${error}</div>
                    </c:if>

                    <form action="/tinh-diem" method="post" id="formTinhDiem">

                        <div class="mb-4">
                            <label class="form-label fw-bold" style="color: var(--brand-1);">Phương Thức Xét Tuyển</label>
                            <select class="form-select" name="phuongThuc" id="phuongThuc" required>
                                <option value="THPT" ${phuongThucNhap == 'THPT' ? 'selected' : ''}>Xét tuyển điểm THPT</option>
                                <option value="VSAT" ${phuongThucNhap == 'VSAT' ? 'selected' : ''}>Xét tuyển điểm V-SAT</option>
                                <option value="DGNL" ${phuongThucNhap == 'DGNL' ? 'selected' : ''}>Xét tuyển điểm ĐGNL</option>
                            </select>
                        </div>
                        
                        <div class="row mb-4">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="form-label fw-bold" style="color: var(--brand-1);">Mã Ngành Xét Tuyển</label>
                                <input type="text" class="form-control" name="maNganh" 
                                       value="${maNganhNhap}" placeholder="VD: 7480201" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold" style="color: var(--brand-1);">Tổ Hợp Môn</label>
                                <input type="text" class="form-control" name="maToHop"
                                       id="maToHop" value="${maToHopNhap}" placeholder="Ví dụ: A00, C01, D07" required>
                                <div class="note mt-2">Hệ thống tự động viết hoa (A00, b00 &rarr; B00)</div>
                            </div>
                        </div>

                        <div class="row mb-3" id="nhomDiem3Mon">
                            <div class="col-md-4 mb-3 mb-md-0">
                                <label class="form-label fw-bold text-dark" id="labelMon1">Điểm Môn 1</label>
                                    <input type="number" step="0.01" class="form-control" name="diemMon1" 
                                       value="${diem1Nhap}" id="diemMon1">
                            </div>
                            <div class="col-md-4 mb-3 mb-md-0">
                                <label class="form-label fw-bold text-dark" id="labelMon2">Điểm Môn 2</label>
                                    <input type="number" step="0.01" class="form-control" name="diemMon2" 
                                       value="${diem2Nhap}" id="diemMon2">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold text-dark" id="labelMon3">Điểm Môn 3</label>
                                    <input type="number" step="0.01" class="form-control" name="diemMon3" 
                                       value="${diem3Nhap}" id="diemMon3">
                            </div>
                        </div>

                        <div class="mb-3" id="nhomDiemDGNL" style="display: none;">
                            <label class="form-label fw-bold text-dark">Điểm ĐGNL (Thang điểm bài thi)</label>
                            <input type="number" step="0.01" class="form-control" name="diemDGNL"
                                   value="${diemDGNLNhap}" id="diemDGNL" placeholder="Ví dụ: 850">
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4 mb-3 mb-md-0">
                                <label class="form-label fw-bold text-dark">Điểm cộng (ĐC)</label>
                                <input type="number" step="0.01" min="0" class="form-control" name="diemCong"
                                       value="${diemCongNhap}" placeholder="Ví dụ: 1.5">
                            </div>
                            <div class="col-md-4 mb-3 mb-md-0">
                                <label class="form-label fw-bold text-dark">Khu vực ưu tiên</label>
                                <select class="form-select" name="khuVucUuTien">
                                    <option value="KV3" ${khuVucUuTienNhap == 'KV3' ? 'selected' : ''}>KV3 (0.00)</option>
                                    <option value="KV2" ${khuVucUuTienNhap == 'KV2' ? 'selected' : ''}>KV2 (0.25)</option>
                                    <option value="KV2-NT" ${(khuVucUuTienNhap == 'KV2-NT' || khuVucUuTienNhap == 'KV2NT') ? 'selected' : ''}>KV2-NT (0.50)</option>
                                    <option value="KV1" ${khuVucUuTienNhap == 'KV1' ? 'selected' : ''}>KV1 (0.75)</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold text-dark">Đối tượng ưu tiên</label>
                                <select class="form-select" name="doiTuongUuTien">
                                    <option value="0" ${(doiTuongUuTienNhap == '0' || empty doiTuongUuTienNhap) ? 'selected' : ''}>Không ưu tiên (0.00)</option>
                                    <option value="1" ${(doiTuongUuTienNhap == '1' || doiTuongUuTienNhap == 'ĐT1') ? 'selected' : ''}>ĐT1 (2.00)</option>
                                    <option value="2" ${(doiTuongUuTienNhap == '2' || doiTuongUuTienNhap == 'ĐT2') ? 'selected' : ''}>ĐT2 (2.00)</option>
                                    <option value="3" ${(doiTuongUuTienNhap == '3' || doiTuongUuTienNhap == 'ĐT3') ? 'selected' : ''}>ĐT3 (2.00)</option>
                                    <option value="4" ${(doiTuongUuTienNhap == '4' || doiTuongUuTienNhap == 'ĐT4') ? 'selected' : ''}>ĐT4 (2.00)</option>
                                    <option value="5" ${(doiTuongUuTienNhap == '5' || doiTuongUuTienNhap == 'ĐT5') ? 'selected' : ''}>ĐT5 (1.00)</option>
                                    <option value="6" ${(doiTuongUuTienNhap == '6' || doiTuongUuTienNhap == 'ĐT6') ? 'selected' : ''}>ĐT6 (1.00)</option>
                                    <option value="7" ${(doiTuongUuTienNhap == '7' || doiTuongUuTienNhap == 'ĐT7') ? 'selected' : ''}>ĐT7 (1.00)</option>
                                </select>
                            </div>
                        </div>

                        <div class="d-grid gap-2 mt-5">
                            <button type="submit" class="btn btn-primary btn-lg">Tính Toán & Quy Đổi Ngay</button>
                        </div>
                    </form>

                    <c:if test="${not empty tongDiem}">
                        <div class="result-box mt-4">
                            <h5 class="border-bottom pb-3 mb-3 fw-bold" style="color: var(--brand-1); font-size: 1.4rem;">Kết Quả Quy Đổi Sang Thang Điểm THPT</h5>
                            
                            <c:if test="${kieuKetQua == 'MON'}">
                                <table class="table table-borderless table-sm align-middle" style="font-size: 1.05rem;">
                                    <tbody>
                                        <tr>
                                            <td class="py-2">Môn <strong><span>${tenMon1}</span></strong> <span class="text-muted">(Hệ số <span>${hs1}</span>)</span></td>
                                            <td class="text-end py-2"><strong class="text-success fs-5">${diemQuyDoi1}</strong> điểm quy đổi</td>
                                        </tr>
                                        <tr>
                                            <td class="py-2">Môn <strong><span>${tenMon2}</span></strong> <span class="text-muted">(Hệ số <span>${hs2}</span>)</span></td>
                                            <td class="text-end py-2"><strong class="text-success fs-5">${diemQuyDoi2}</strong> điểm quy đổi</td>
                                        </tr>
                                        <tr>
                                            <td class="py-2">Môn <strong><span>${tenMon3}</span></strong> <span class="text-muted">(Hệ số <span>${hs3}</span>)</span></td>
                                            <td class="text-end py-2"><strong class="text-success fs-5">${diemQuyDoi3}</strong> điểm quy đổi</td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="mt-4">
                                    <h6 class="fw-bold mb-3" style="color: var(--brand-1);">Chi tiết từng môn và công thức áp dụng</h6>
                                    
                                    <c:forEach var="chiTietMon" items="${chiTietMonList}" varStatus="stat">
                                        <div class="formula-card mb-3">
                                            <div class="formula-title">Bước ${stat.count} - Môn ${chiTietMon.tenMon} (hệ số ${chiTietMon.heSo})</div>
                                            <div>Điểm đầu vào: <strong>${chiTietMon.diemNhap}</strong></div>
                                            <div>Cách xử lý: <strong>${chiTietMon.cachTinh}</strong></div>
                                            <div>Mốc quy đổi: <strong>${chiTietMon.mocQuyDoi}</strong></div>
                                            <div class="mt-2">Công thức tổng quát:</div>
                                            <span class="formula-code">${chiTietMon.congThucTongQuat}</span>
                                            <div>Thay số:</div>
                                            <span class="formula-code">${chiTietMon.congThucThaySo}</span>
                                            <div class="text-muted">Ghi chú: <span>${chiTietMon.ghiChu}</span></div>
                                            <div class="mt-2">Điểm sau nhân hệ số: <strong>${chiTietMon.diemNhanHeSo}</strong></div>
                                        </div>
                                    </c:forEach>

                                    <div class="formula-card mb-3">
                                        <div class="formula-title">Bước 4 - Tính tổng điểm có hệ số</div>
                                        <span class="formula-code">${congThucTongDiem}</span>
                                    </div>

                                    <div class="formula-card mb-3">
                                        <div class="formula-title">Bước 5 - Tính tổng hệ số</div>
                                        <span class="formula-code">${congThucTongHeSo}</span>
                                    </div>

                                    <div class="formula-card">
                                        <div class="formula-title">Bước 6 - Quy về thang điểm 30</div>
                                        <span class="formula-code">${congThucQuyVe30}</span>
                                    </div>

                                    <div class="formula-card mt-3">
                                        <div class="formula-title">Bước 7 - Điểm cộng và ưu tiên</div>
                                        <div>Điểm nền xét tuyển: <strong>${diemNenXetTuyen}</strong></div>
                                        <div>Điểm cộng (ĐC): <strong>${diemCong}</strong></div>
                                        <div>Ưu tiên khu vực: <strong>${diemKhuVuc}</strong></div>
                                        <div>Ưu tiên đối tượng: <strong>${diemDoiTuong}</strong></div>
                                        <div>Điểm ưu tiên gốc: <strong>${diemUuTienGoc}</strong></div>
                                        <span class="formula-code">${congThucDiemUuTien}</span>
                                        <div>Điểm ưu tiên áp dụng: <strong>${diemUuTienSauDieuChinh}</strong></div>
                                        
                                        <hr class="my-3" style="border-top: 1px dashed #cbd5e1;">
                                        <div class="formula-title" style="color: #0284c7;">Công thức tính tổng điểm:</div>
                                        <span class="formula-code" style="background: #f0f9ff; border: 1px solid #bae6fd; font-weight: 600; color: #0369a1; font-size: 1.1rem;">
                                            ${diemNenXetTuyen} (Điểm nền) + ${diemCong} (Điểm cộng) + ${diemUuTienSauDieuChinh} (Ưu tiên) = ${tongDiemXetTuyen}
                                        </span>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${kieuKetQua == 'DGNL'}">
                                <div class="mt-4">
                                    <div class="alert alert-secondary mt-3 rounded-3 border-0" role="alert" style="font-size: 1.05rem;">
                                        Điểm ĐGNL đã được nội suy tuyến tính theo bảng xt_bangquydoi (phương thức ĐGNL HCM, theo tổ hợp).
                                    </div>

                                    <div class="formula-card">
                                        <div class="formula-title">Chi tiết công thức ĐGNL</div>
                                        <div>Điểm đầu vào: <strong>${diemDGNLNhapLamTron}</strong></div>
                                        <div>Cách xử lý: <strong>${chiTietDGNL.cachTinh}</strong></div>
                                        <div>Mốc quy đổi: <strong>${chiTietDGNL.mocQuyDoi}</strong></div>
                                        <div class="mt-2">Công thức tổng quát:</div>
                                        <span class="formula-code">${chiTietDGNL.congThucTongQuat}</span>
                                        <div>Thay số:</div>
                                        <span class="formula-code">${chiTietDGNL.congThucThaySo}</span>
                                        <div class="text-muted">Ghi chú: <span>${chiTietDGNL.ghiChu}</span></div>
                                    </div>

                                    <div class="formula-card mt-3">
                                        <div class="formula-title">Điểm cộng và ưu tiên</div>
                                        <div>Điểm nền xét tuyển: <strong>${diemNenXetTuyen}</strong></div>
                                        <div>Điểm cộng (ĐC): <strong>${diemCong}</strong></div>
                                        <div>Ưu tiên khu vực: <strong>${diemKhuVuc}</strong></div>
                                        <div>Ưu tiên đối tượng: <strong>${diemDoiTuong}</strong></div>
                                        <div>Điểm ưu tiên gốc: <strong>${diemUuTienGoc}</strong></div>
                                        <span class="formula-code">${congThucDiemUuTien}</span>
                                        <div>Điểm ưu tiên áp dụng: <strong>${diemUuTienSauDieuChinh}</strong></div>
                                    </div>
                                </div>
                            </c:if>
                            
                            <div class="alert mt-4 mb-0 rounded-4 border-0" style="background: rgba(14, 165, 233, 0.1);" role="alert">
                                <h4 class="alert-heading mb-0 text-center d-flex align-items-center justify-content-center flex-wrap gap-2">
                                    <span style="color: var(--ink); font-size: 1.3rem;">TỔNG ĐIỂM XÉT TUYỂN:</span>
                                    <strong class="text-danger" style="font-size: 2.2rem;">${tongDiemXetTuyen}</strong>
                                </h4>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
            
            <div class="footer-text">
                Copy no right &copy; <span>Nhóm 12</span>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function chuanHoaToHop() {
        const inputToHop = document.getElementById('maToHop');
        if (!inputToHop) {
            return;
        }
        inputToHop.value = (inputToHop.value || '').trim().toUpperCase();
    }

    function capNhatFormTheoPhuongThuc() {
        const phuongThuc = document.getElementById('phuongThuc').value;
        const nhomDiem3Mon = document.getElementById('nhomDiem3Mon');
        const nhomDiemDGNL = document.getElementById('nhomDiemDGNL');
        const diemMon1 = document.getElementById('diemMon1');
        const diemMon2 = document.getElementById('diemMon2');
        const diemMon3 = document.getElementById('diemMon3');
        const diemDGNL = document.getElementById('diemDGNL');
        const labelMon1 = document.getElementById('labelMon1');
        const labelMon2 = document.getElementById('labelMon2');
        const labelMon3 = document.getElementById('labelMon3');

        if (phuongThuc === 'DGNL') {
            nhomDiem3Mon.style.display = 'none';
            nhomDiemDGNL.style.display = 'block';
            diemMon1.required = false;
            diemMon2.required = false;
            diemMon3.required = false;
            diemDGNL.required = true;
            return;
        }

        nhomDiem3Mon.style.display = 'flex';
        nhomDiemDGNL.style.display = 'none';
        diemMon1.required = true;
        diemMon2.required = true;
        diemMon3.required = true;
        diemDGNL.required = false;

        if (phuongThuc === 'THPT') {
            labelMon1.textContent = 'Điểm Môn 1 (THPT, thang 10)';
            labelMon2.textContent = 'Điểm Môn 2 (THPT, thang 10)';
            labelMon3.textContent = 'Điểm Môn 3 (THPT, thang 10)';
            diemMon1.placeholder = 'Thang 10';
            diemMon2.placeholder = 'Thang 10';
            diemMon3.placeholder = 'Thang 10';
        } else {
            labelMon1.textContent = 'Điểm Môn 1 (V-SAT, thang 150)';
            labelMon2.textContent = 'Điểm Môn 2 (V-SAT, thang 150)';
            labelMon3.textContent = 'Điểm Môn 3 (V-SAT, thang 150)';
            diemMon1.placeholder = 'Thang 150';
            diemMon2.placeholder = 'Thang 150';
            diemMon3.placeholder = 'Thang 150';
        }
    }

    document.getElementById('phuongThuc').addEventListener('change', capNhatFormTheoPhuongThuc);
    document.getElementById('maToHop').addEventListener('blur', chuanHoaToHop);
    document.getElementById('formTinhDiem').addEventListener('submit', chuanHoaToHop);
    capNhatFormTheoPhuongThuc();

    // Bắt sự kiện khi người dùng nhập xong mã ngành và click chuột ra ngoài (blur)
    document.querySelector('input[name="maNganh"]').addEventListener('blur', function() {
        const maNganhNhapVao = this.value.trim();
        const inputToHop = document.getElementById('maToHop');

        if (maNganhNhapVao !== '') {
            // Gọi API bằng Fetch
            fetch('/api/lay-to-hop-goc?maNganh=' + maNganhNhapVao)
                .then(response => response.text())
                .then(toHopGoc => {
                    // Nếu API tìm thấy và trả về tổ hợp gốc (ví dụ: A00)
                    if (toHopGoc !== '') {
                        inputToHop.value = toHopGoc;
                    }
                })
                .catch(error => console.error('Lỗi khi lấy tổ hợp gốc:', error));
        }
    });
</script>
</body>
</html>