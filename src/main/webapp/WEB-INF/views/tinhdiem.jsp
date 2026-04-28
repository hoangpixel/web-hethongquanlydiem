<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Công cụ Quy Đổi Điểm</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/img/logo.png" type="image/png">
    
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
        .card-header {
            background: linear-gradient(135deg, var(--brand-1), var(--brand-2) 70%, #22d3ee);
            color: white;
            text-align: center;
            padding: 30px 24px;
            position: relative;
            border-bottom: none;
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
            min-height: 45px; 
            padding: 8px 14px;
            background-color: #f8fafc;
            font-size: 1rem; 
        }
        .form-control:focus, .form-select:focus {
            background-color: #ffffff;
            border-color: var(--brand-2);
            box-shadow: 0 0 0 4px rgba(14, 165, 233, 0.15);
        }
        .form-label {
            font-size: 1.05rem; 
            margin-bottom: 6px;
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--brand-1), var(--brand-2));
            border: none;
            border-radius: 14px;
            font-weight: 600;
            padding: 14px;
            font-size: 1.1rem; 
        }
        .note {
            color: var(--brand-1);
            font-size: 0.95rem; 
            font-style: italic;
        }
        .footer-text {
            text-align: center;
            margin-top: 30px;
            color: var(--muted);
        }
        /* Custom Tab UI */
        .nav-pills .nav-link {
            border: 1px solid #cbd5e1;
            color: var(--muted);
            border-radius: 10px;
        }
        .nav-pills .nav-link.active {
            background: var(--brand-2);
            border-color: var(--brand-2);
            color: white;
            box-shadow: 0 4px 10px rgba(14, 165, 233, 0.3);
        }

        .footer-text span {
            /* Dải màu cầu vồng (đỏ, cam, vàng, lục, lam, chàm, tím, đỏ) */
            background: linear-gradient(to right, #ff0000, #ff7f00, #ffff00, #00ff00, #0000ff, #4b0082, #9400d3, #ff0000);
            background-size: 200% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
            font-size: 1.1rem;
            /* Gọi hiệu ứng chạy màu, 3s là tốc độ, linear là chạy đều, infinite là chạy lặp vô tận */
            animation: rainbowCycle 3s linear infinite;
        }

        /* Khai báo khung hình chuyển động (Animation Keyframes) */
        @keyframes rainbowCycle {
            to {
                background-position: 200% center;
            }
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <a href="/ketqua" class="btn btn-outline-secondary" style="border-radius: 10px;">&larr; Quay lại trang Kết Quả</a>
</div>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10 col-xl-9">
            <div class="card main-card">
                <div class="card-header">
                    <h3 class="mb-0 header-title">TÍNH ĐIỂM XÉT TUYỂN TOÀN DIỆN</h3>
                    <p class="mb-0 mt-2" style="color: rgba(255,255,255,0.9); font-size: 1.05rem;">
                        Nhập điểm các môn bạn có, hệ thống sẽ tự động quét và tính tất cả tổ hợp
                    </p>
                </div>
                <div class="card-body p-4 p-md-5">
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger rounded-3 border-0 shadow-sm" role="alert">${error}</div>
                    </c:if>

                    <form action="/tinh-diem" method="post" id="formTinhDiem">

                        <div class="row mb-4">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="form-label fw-bold" style="color: var(--brand-1);">Phương Thức</label>
                                <select class="form-select" name="phuongThuc" id="phuongThuc" required>
                                    <option value="THPT" ${phuongThucNhap == 'THPT' ? 'selected' : ''}>Xét tuyển THPT</option>
                                    <option value="VSAT" ${phuongThucNhap == 'VSAT' ? 'selected' : ''}>Xét tuyển V-SAT</option>
                                    <option value="DGNL" ${phuongThucNhap == 'DGNL' ? 'selected' : ''}>Xét tuyển ĐGNL</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold" style="color: var(--brand-1);">Mã Ngành Xét Tuyển</label>
                                <input type="text" class="form-control" name="maNganh" value="${maNganhNhap}" placeholder="VD: 7480201" required>
                            </div>
                        </div>

                        <div class="row mb-4" id="nhomDiem8Mon">
                            <!-- <div class="col-12 mb-2">
                                <div class="note px-3 py-2" style="background: #f0fdf4; border-radius: 8px;">
                                    <strong>Mẹo:</strong> Bạn không cần nhập mã tổ hợp nữa. Chỉ cần nhập điểm các môn bạn đã thi, hệ thống sẽ đối chiếu và liệt kê kết quả của tất cả các tổ hợp hợp lệ.
                                </div>
                            </div> -->
                            
                            <div class="col-md-3 col-6 mb-3">
                                <label class="form-label fw-bold text-dark">Toán</label>
                                <input type="number" step="0.01" class="form-control input-mon" name="diemToan" value="${dToan}">
                            </div>
                            <div class="col-md-3 col-6 mb-3">
                                <label class="form-label fw-bold text-dark">Ngữ Văn</label>
                                <input type="number" step="0.01" class="form-control input-mon" name="diemVan" value="${dVan}">
                            </div>
                            <div class="col-md-3 col-6 mb-3">
                                <label class="form-label fw-bold text-dark">Tiếng Anh</label>
                                <input type="number" step="0.01" class="form-control input-mon" name="diemAnh" value="${dAnh}">
                            </div>
                            <div class="col-md-3 col-6 mb-3">
                                <label class="form-label fw-bold text-dark">Vật Lý</label>
                                <input type="number" step="0.01" class="form-control input-mon" name="diemLy" value="${dLy}">
                            </div>
                            <div class="col-md-3 col-6 mb-3">
                                <label class="form-label fw-bold text-dark">Hóa Học</label>
                                <input type="number" step="0.01" class="form-control input-mon" name="diemHoa" value="${dHoa}">
                            </div>
                            <div class="col-md-3 col-6 mb-3">
                                <label class="form-label fw-bold text-dark">Sinh Học</label>
                                <input type="number" step="0.01" class="form-control input-mon" name="diemSinh" value="${dSinh}">
                            </div>
                            <div class="col-md-3 col-6 mb-3">
                                <label class="form-label fw-bold text-dark">Lịch Sử</label>
                                <input type="number" step="0.01" class="form-control input-mon" name="diemSu" value="${dSu}">
                            </div>
                            <div class="col-md-3 col-6 mb-3">
                                <label class="form-label fw-bold text-dark">Địa Lý</label>
                                <input type="number" step="0.01" class="form-control input-mon" name="diemDia" value="${dDia}">
                            </div>
                        </div>

                        <div class="mb-4" id="nhomDiemDGNL" style="display: none;">
                            <label class="form-label fw-bold text-dark">Điểm ĐGNL (Thang điểm bài thi)</label>
                            <input type="number" step="0.01" class="form-control" name="diemDGNL"
                                   value="${diemDGNLNhap}" id="diemDGNL" placeholder="Ví dụ: 850">
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4 mb-3 mb-md-0">
                                <label class="form-label fw-bold text-dark">Điểm cộng (ĐC)</label>
                                <input type="number" step="0.01" min="0" class="form-control" name="diemCong" value="${diemCongNhap}" placeholder="Ví dụ: 1.5">
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

                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" class="btn btn-primary btn-lg">Quét Tổ Hợp & Tính Điểm Ngay</button>
                        </div>
                    </form>

                    <c:if test="${not empty tongDiem}">
                        
<c:if test="${kieuKetQua == 'DGNL'}">
                            <div class="result-box mt-4">
                                <h5 class="border-bottom pb-3 mb-3 fw-bold" style="color: var(--brand-1);">Kết Quả Quy Đổi ĐGNL</h5>
                                
                                <div class="alert alert-secondary mt-3 rounded-3 border-0" role="alert" style="font-size: 1.05rem;">
                                    Ngành này xét ĐGNL theo tổ hợp gốc: <strong>${toHopGocHienThi}</strong> <br>
                                    <small>Điểm đã được nội suy tuyến tính theo bảng xt_bangquydoi (phương thức ĐGNL HCM).</small>
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
                                    <div>Điểm ưu tiên gốc: <strong>${diemUuTienGoc}</strong></div>
                                    <span class="formula-code">${congThucDiemUuTien}</span>
                                    <div>Điểm ưu tiên áp dụng: <strong>${diemUuTienSauDieuChinh}</strong></div>
                                    
                                    <hr class="my-3" style="border-top: 1px dashed #cbd5e1;">
                                    <div class="formula-title" style="color: #0284c7;">Công thức tính tổng điểm:</div>
                                    <span class="formula-code" style="background: #f0f9ff; border: 1px solid #bae6fd; font-weight: 600; color: #0369a1;">
                                        ${diemNenXetTuyen} (Nền) + ${diemCong} (ĐC) + ${diemUuTienSauDieuChinh} (Ưu tiên) = ${tongDiemXetTuyen}
                                    </span>
                                </div>
                                <div class="alert mt-4 mb-0 rounded-4 border-0" style="background: rgba(14, 165, 233, 0.1);" role="alert">
                                    <h4 class="alert-heading mb-0 text-center d-flex align-items-center justify-content-center flex-wrap gap-2">
                                        <span style="color: var(--ink); font-size: 1.3rem;">TỔNG ĐIỂM ĐGNL:</span>
                                        <strong class="text-danger" style="font-size: 2.2rem;">${tongDiem}</strong>
                                    </h4>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${kieuKetQua == 'MON' && not empty ketQuaTatCaToHop}">
                            <div class="result-box mt-5 p-4">
                                <h5 class="fw-bold mb-3" style="color: var(--brand-1);">Hệ thống quét được ${ketQuaTatCaToHop.size()} tổ hợp hợp lệ:</h5>
                                
                                <ul class="nav nav-pills mb-4 gap-2" id="pills-tab" role="tablist">
                                    <c:forEach var="kq" items="${ketQuaTatCaToHop}" varStatus="status">
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link ${status.first ? 'active' : ''} fw-bold" 
                                                    id="tab-btn-${kq.maToHop}" data-bs-toggle="pill" 
                                                    data-bs-target="#tab-content-${kq.maToHop}" type="button" role="tab">
                                                Tổ hợp ${kq.maToHop} <br>
                                                <span style="font-size: 0.9em; opacity: 0.9;">(${kq.tongDiemXetTuyen} đ)</span>
                                                <c:if test="${status.first}"><div style="font-size: 0.7em; margin-top:2px;">⭐ CAO NHẤT</div></c:if>
                                            </button>
                                        </li>
                                    </c:forEach>
                                </ul>

                                <div class="tab-content" id="pills-tabContent">
                                    <c:forEach var="kq" items="${ketQuaTatCaToHop}" varStatus="status">
                                        <div class="tab-pane fade ${status.first ? 'show active' : ''}" id="tab-content-${kq.maToHop}" role="tabpanel">
                                            
                                            <table class="table table-borderless table-sm align-middle mt-3">
                                                <tbody>
                                                    <tr>
                                                        <td class="py-2">Môn <strong><span>${kq.tenMon1}</span></strong> <span class="text-muted">(Hệ số <span>${kq.hs1}</span>)</span></td>
                                                        <td class="text-end py-2"><strong class="text-success fs-5">${kq.diemQuyDoi1}</strong> điểm</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="py-2">Môn <strong><span>${kq.tenMon2}</span></strong> <span class="text-muted">(Hệ số <span>${kq.hs2}</span>)</span></td>
                                                        <td class="text-end py-2"><strong class="text-success fs-5">${kq.diemQuyDoi2}</strong> điểm</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="py-2">Môn <strong><span>${kq.tenMon3}</span></strong> <span class="text-muted">(Hệ số <span>${kq.hs3}</span>)</span></td>
                                                        <td class="text-end py-2"><strong class="text-success fs-5">${kq.diemQuyDoi3}</strong> điểm</td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                            <div class="mt-4">
                                                <h6 class="fw-bold mb-3" style="color: var(--brand-1);">Chi tiết tính toán (${kq.maToHop})</h6>
                                                
<c:forEach var="chiTietMon" items="${kq.chiTietMonList}" varStatus="stat">
    <div class="formula-card mb-3">
        <div class="formula-title" style="font-size: 1.1rem;">Bước ${stat.count} - Môn ${chiTietMon.tenMon}</div>
        
        <c:choose>
            <c:when test="${phuongThucNhap == 'THPT'}">
                <div>Điểm đầu vào (thang 10): <strong>${chiTietMon.diemNhap}</strong></div>
                <div class="text-muted mt-1" style="font-size: 0.95rem;">
                    <span style="color: var(--brand-1);">✔</span> Ghi chú: Sử dụng trực tiếp điểm đầu vào, không qua quy đổi.
                </div>
            </c:when>
            
            <c:otherwise>
                <div>Điểm đầu vào: <strong>${chiTietMon.diemNhap}</strong></div>
                <div>Cách xử lý: <strong>${chiTietMon.cachTinh}</strong></div>
                <div>Mốc quy đổi: <strong>${chiTietMon.mocQuyDoi}</strong></div>
                
                <div class="mt-2">Công thức tổng quát:</div>
                <span class="formula-code">${chiTietMon.congThucTongQuat}</span>
                
                <div>Thay số:</div>
                <span class="formula-code">${chiTietMon.congThucThaySo}</span>
                
                <div class="text-muted" style="font-size: 0.95rem;">Ghi chú: <span>${chiTietMon.ghiChu}</span></div>
            </c:otherwise>
        </c:choose>
        
        <div class="mt-2 pt-2 border-top" style="color: var(--brand-1); font-weight: 600; font-size: 1.05rem;">
            Điểm quy đổi sau khi nhân hệ số (${chiTietMon.heSo}): <strong class="text-danger">${chiTietMon.diemNhanHeSo}</strong>
        </div>
    </div>
</c:forEach>

                                                <div class="formula-card mb-3">
                                                    <div class="formula-title">Bước 4 - Tính tổng điểm có hệ số</div>
                                                    <span class="formula-code">${kq.congThucTongDiem}</span>
                                                </div>

                                                <div class="formula-card mb-3">
                                                    <div class="formula-title">Bước 5 - Tính tổng hệ số</div>
                                                    <span class="formula-code">${kq.congThucTongHeSo}</span>
                                                </div>

                                                <div class="formula-card mb-3">
                                                    <div class="formula-title">Bước 6 - Quy về thang điểm 30</div>
                                                    <span class="formula-code">${kq.congThucQuyVe30}</span>
                                                </div>

                                                <div class="formula-card mt-3">
                                                    <div class="formula-title">Bước 7 - Điểm cộng và ưu tiên</div>
                                                    <div>Điểm nền xét tuyển: <strong>${kq.diemNenXetTuyen}</strong></div>
                                                    <div>Điểm cộng (ĐC): <strong>${diemCong}</strong></div>
                                                    <div>Ưu tiên khu vực/đối tượng: <strong>${diemKhuVuc} / ${diemDoiTuong}</strong></div>
                                                    <span class="formula-code mt-2">${kq.congThucDiemUuTien}</span>
                                                    <div>Điểm ưu tiên áp dụng: <strong>${kq.diemUuTienSauDieuChinh}</strong></div>
                                                    
                                                    <hr class="my-3" style="border-top: 1px dashed #cbd5e1;">
                                                    <div class="formula-title" style="color: #0284c7;">Công thức chốt hạ:</div>
                                                    <span class="formula-code" style="background: #f0f9ff; border: 1px solid #bae6fd; font-weight: 600; color: #0369a1;">
                                                        ${kq.diemNenXetTuyen} (Nền) + ${diemCong} (ĐC) + ${kq.diemUuTienSauDieuChinh} (Ưu tiên) = ${kq.tongDiemXetTuyen}
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="alert mt-4 mb-0 rounded-4 border-0" style="background: rgba(14, 165, 233, 0.1);" role="alert">
                                                <h4 class="alert-heading mb-0 text-center d-flex align-items-center justify-content-center flex-wrap gap-2">
                                                    <span style="color: var(--ink); font-size: 1.3rem;">TỔNG ĐIỂM TỔ HỢP ${kq.maToHop}:</span>
                                                    <strong class="text-danger" style="font-size: 2.2rem;">${kq.tongDiemXetTuyen}</strong>
                                                </h4>
                                            </div>

                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>

                    </c:if>

                </div>
            </div>
            
            <div class="footer-text">
                <span>Copy no right &copy; Nhóm 12</span>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function capNhatFormTheoPhuongThuc() {
        const phuongThuc = document.getElementById('phuongThuc').value;
        const nhomDiem8Mon = document.getElementById('nhomDiem8Mon');
        const nhomDiemDGNL = document.getElementById('nhomDiemDGNL');
        const inputsMon = document.querySelectorAll('.input-mon');
        const diemDGNL = document.getElementById('diemDGNL');

        if (phuongThuc === 'DGNL') {
            nhomDiem8Mon.style.display = 'none';
            nhomDiemDGNL.style.display = 'block';
            inputsMon.forEach(input => input.required = false);
            diemDGNL.required = true;
            return;
        }

        nhomDiem8Mon.style.display = 'flex';
        nhomDiemDGNL.style.display = 'none';
        diemDGNL.required = false;

        // Đổi placeholder tùy phương thức
        const placeholderText = phuongThuc === 'THPT' ? 'Thang 10' : 'Thang 150';
        inputsMon.forEach(input => input.placeholder = placeholderText);
    }

    document.getElementById('phuongThuc').addEventListener('change', capNhatFormTheoPhuongThuc);
    capNhatFormTheoPhuongThuc();
</script>
</body>
</html>