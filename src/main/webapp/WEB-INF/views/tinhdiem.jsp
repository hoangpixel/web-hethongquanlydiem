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

        .nganh-table-wrap {
            max-height: 55vh;
            overflow: auto;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
        }

        /* Modal/backdrop: giảm tối + luôn nổi lên trên */
        /* .modal {
            z-index: 9999;
        }
        .modal-backdrop {
            z-index: 9999;
        }
        .modal-backdrop.show {
            opacity: 0.25;
        } */

/* --- CHỈNH LẠI GIAO DIỆN THANH TÌM KIẾM 3 MÓN --- */
/* Ép chiều cao bằng nhau cho cả 3 anh em */
#nganhSearchType, #nganhSearchInput, #nganhSearchBtn {
    height: 46px !important; 
    min-height: 46px !important;
    box-shadow: none !important;
}

/* 1. Thằng đứng đầu (Combobox) */
#nganhSearchType {
    max-width: 140px; /* Ép nó gọn lại, nhường chỗ cho ô nhập chữ */
    border-top-right-radius: 0 !important;
    border-bottom-right-radius: 0 !important;
    background-color: #f1f5f9; /* Cho cái nền hơi xám xíu để phân biệt */
    border-color: #cbd5e1;
    color: var(--brand-1);
    font-weight: 600;
    cursor: pointer;
}
#nganhSearchType:focus {
    border-color: var(--brand-2);
    background-color: #ffffff;
    z-index: 5; /* Nổi lên khi bấm vào */
}

/* 2. Thằng đứng giữa (Ô nhập liệu) */
#nganhSearchInput {
    border-radius: 0 !important; /* Đứng giữa nên phải vuông vức 4 góc */
    border-left: 0 !important; /* Xóa viền trái để chìm vào combobox */
    border-color: #cbd5e1;
}
#nganhSearchInput:focus {
    border-color: var(--brand-2);
    border-left: 1px solid var(--brand-2) !important; /* Hiện lại viền khi gõ */
    z-index: 5;
}

/* 3. Thằng chốt sổ (Nút Tìm kiếm) */
#nganhSearchBtn {
    border-top-left-radius: 0 !important;
    border-bottom-left-radius: 0 !important;
    padding: 0 24px !important;
    font-size: 1.05rem !important;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Hiệu ứng phát sáng nguyên khối khi focus vào bất kỳ đâu trong thanh */
.search-group-wrapper:focus-within {
    box-shadow: 0 4px 15px rgba(14, 165, 233, 0.15);
    border-radius: 12px;
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
                        <div class="alert alert-danger rounded-3 border-0 shadow-sm" role="alert" id="errorBox">${error}</div>
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
    <label class="form-label fw-bold" style="color: var(--brand-1);">
        Mã Ngành Xét Tuyển
    </label>

    <div class="input-group">
        <input type="text"
               class="form-control rounded-4"
               id="maNganhDisplay"
               value="${maNganhHienThi}"
               placeholder="VD: 7480201"
               readonly required>

        <input type="hidden"
               id="maNganhInput"
               name="maNganh"
               value="${maNganhNhap}">

        <button type="button"
                class="btn btn-outline-primary ms-2 px-4 py-2"
                style="border-radius: 14px;"
                data-bs-toggle="modal"
                data-bs-target="#modalChonMaNganh">
            Chọn
        </button>
    </div>
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

                            <div class="col-12" id="nhomDiemTHPTMoRong" style="display: none;">
                                <div class="row">
                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="CNCN" style="display: none;">
                                        <label class="form-label fw-bold text-dark">CNCN</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemCNCN" value="${dCNCN}">
                                    </div>
                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="CNNN" style="display: none;">
                                        <label class="form-label fw-bold text-dark">CNNN</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemCNNN" value="${dCNNN}">
                                    </div>
                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="TI" style="display: none;">
                                        <label class="form-label fw-bold text-dark">Tin học</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemTI" value="${dTI}">
                                    </div>
                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="KTPL" style="display: none;">
                                        <label class="form-label fw-bold text-dark">KTPL</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemKTPL" value="${dKTPL}">
                                    </div>

                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="NK1" style="display: none;">
                                        <label class="form-label fw-bold text-dark">NK1</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemNK1" value="${dNK1}">
                                    </div>
                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="NK2" style="display: none;">
                                        <label class="form-label fw-bold text-dark">NK2</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemNK2" value="${dNK2}">
                                    </div>
                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="NK3" style="display: none;">
                                        <label class="form-label fw-bold text-dark">NK3</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemNK3" value="${dNK3}">
                                    </div>
                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="NK4" style="display: none;">
                                        <label class="form-label fw-bold text-dark">NK4</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemNK4" value="${dNK4}">
                                    </div>
                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="NK5" style="display: none;">
                                        <label class="form-label fw-bold text-dark">NK5</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemNK5" value="${dNK5}">
                                    </div>
                                    <div class="col-md-3 col-6 mb-3 thpt-mon-item" data-thpt-mon="NK6" style="display: none;">
                                        <label class="form-label fw-bold text-dark">NK6</label>
                                        <input type="number" step="0.01" class="form-control input-mon input-thpt" name="diemNK6" value="${dNK6}">
                                    </div>
                                </div>
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
                        <div id="ketQuaContainer">

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
                                    <div>Ưu tiên khu vực/đối tượng: <strong>${diemKhuVuc} / ${diemDoiTuong}</strong></div>
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
                                <div class="mt-4 text-center">
                                    <div style="font-size: 1.1rem; color: var(--muted); margin-bottom: 8px;">
                                        Điểm chuẩn yêu cầu: <strong style="color: var(--ink);">${diemChuan != null ? diemChuan : 'Chưa công bố'}</strong>
                                    </div>
                                    <c:choose>
                                        <c:when test="${diemChuan == null}">
                                            <span class="badge bg-secondary fs-6 px-4 py-2 rounded-pill shadow-sm">CHƯA CÔNG BỐ</span>
                                        </c:when>
                                        <c:when test="${datDiemChuan}">
                                            <span class="badge bg-success fs-5 px-4 py-2 rounded-pill shadow-sm" style="background: linear-gradient(45deg, #10b981, #059669) !important;">🎉 ĐỦ ĐIỀU KIỆN ĐIỂM CHUẨN</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger fs-5 px-4 py-2 rounded-pill shadow-sm" style="background: linear-gradient(45deg, #ef4444, #dc2626) !important;">❌ KHÔNG ĐẠT ĐIỂM CHUẨN</span>
                                        </c:otherwise>
                                    </c:choose>
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
                                            <div class="mt-4 text-center">
                                                <div style="font-size: 1.1rem; color: var(--muted); margin-bottom: 8px;">
                                                    Điểm chuẩn yêu cầu: <strong style="color: var(--ink);">${kq.diemChuan != null ? kq.diemChuan : 'Chưa công bố'}</strong>
                                                </div>
                                                <c:choose>
                                                    <c:when test="${kq.diemChuan == null}">
                                                        <span class="badge bg-secondary fs-6 px-4 py-2 rounded-pill shadow-sm">CHƯA CÔNG BỐ</span>
                                                    </c:when>
                                                    <c:when test="${kq.datDiemChuan}">
                                                        <span class="badge bg-success fs-5 px-4 py-2 rounded-pill shadow-sm" style="background: linear-gradient(45deg, #10b981, #059669) !important;">ĐỦ ĐIỀU KIỆN ĐIỂM CHUẨN</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger fs-5 px-4 py-2 rounded-pill shadow-sm" style="background: linear-gradient(45deg, #ef4444, #dc2626) !important;">KHÔNG ĐẠT ĐIỂM CHUẨN</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>

                        </div>
                    </c:if>

                </div>
            </div>
            
            <div class="footer-text">
                <span>Copy no right &copy; Nhóm 12</span>
            </div>

        </div>
    </div>
</div>

                        <!-- Modal chọn mã ngành -->
                        <div class="modal fade" id="modalChonMaNganh" tabindex="-1" aria-labelledby="modalChonMaNganhLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-scrollable modal-lg">
                                <div class="modal-content" style="border-radius: 18px;">
                                    <div class="modal-header">
                                        <h5 class="modal-title fw-bold" id="modalChonMaNganhLabel" style="color: var(--brand-1);">Chọn mã ngành</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                    </div>
                                    <div class="modal-body">
<div class="mb-4 mt-2">
    <label class="form-label fw-bold text-dark mb-2">Tìm mã ngành</label>
    <!-- Thêm class search-group-wrapper vào đây nha -->
    <div class="input-group shadow-sm search-group-wrapper">
        <select class="form-select" id="nganhSearchType" aria-label="Chọn kiểu tìm kiếm">
            <option value="MA" selected>Mã ngành</option>
            <option value="TEN">Tên ngành</option>
        </select>
        <input type="text" class="form-control" id="nganhSearchInput" placeholder="Nhập từ khóa cần tìm...">
        <button type="button" class="btn btn-primary fw-bold" id="nganhSearchBtn">Tìm kiếm</button>
    </div>
</div>

                                        <div class="nganh-table-wrap">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="table-light" style="position: sticky; top: 0; z-index: 1;">
                                                    <tr>
                                                        <th style="width: 24%;">Mã ngành</th>
                                                        <th style="width: 48%;">Tên ngành</th>
                                                        <th style="width: 12%;">Tổ hợp gốc</th>
                                                        <th class="text-end" style="width: 16%;">Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="nganhTableBody">
                                                    <c:choose>
                                                        <c:when test="${empty dsNganh}">
                                                            <tr>
                                                                <td colspan="4" class="text-center text-muted py-4">Không có dữ liệu mã ngành</td>
                                                            </tr>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="n" items="${dsNganh}">
                                                                <tr class="nganh-row" data-ma="${n.maNganh}" data-ten="${n.tenNganh}">
                                                                    <td class="fw-bold">${n.maNganh}</td>
                                                                    <td>${n.tenNganh}</td>
                                                                    <td>${n.toHopGoc != null ? n.toHopGoc : '-'}</td>
                                                                    <td class="text-end">
                                                                        <button type="button" class="btn btn-sm btn-outline-primary btn-chon-nganh">Chọn</button>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="modal-footer d-flex justify-content-between align-items-center">
                                        <div class="text-muted" id="nganhPagerInfo" style="font-size: 0.95rem;"></div>
                                        <nav aria-label="Phân trang mã ngành">
                                            <ul class="pagination mb-0" id="nganhPagination"></ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function resetDuLieuTinhDiem() {
        const form = document.getElementById('formTinhDiem');
        if (!form) return;

        // Xóa hết điểm đã nhập (tất cả input number trong form)
        form.querySelectorAll('input[type="number"]').forEach(input => {
            input.value = '';
        });

        // Ẩn kết quả cũ (nếu đang hiển thị do server render)
        const ketQua = document.getElementById('ketQuaContainer');
        if (ketQua) ketQua.style.display = 'none';

        // Ẩn thông báo lỗi cũ (nếu có)
        const errorBox = document.getElementById('errorBox');
        if (errorBox) errorBox.style.display = 'none';
    }

    function setNhomThptMoRongVisible(visible) {
        const nhomDiemTHPTMoRong = document.getElementById('nhomDiemTHPTMoRong');
        const inputsThpt = document.querySelectorAll('.input-thpt');
        if (nhomDiemTHPTMoRong) nhomDiemTHPTMoRong.style.display = visible ? 'block' : 'none';
        inputsThpt.forEach(input => input.disabled = !visible);
    }

    function apDungHienThiMonThptMoRong(monSet) {
        const nhom = document.getElementById('nhomDiemTHPTMoRong');
        const items = document.querySelectorAll('.thpt-mon-item[data-thpt-mon]');
        const codes = ['CNCN', 'CNNN', 'TI', 'KTPL', 'NK1', 'NK2', 'NK3', 'NK4', 'NK5', 'NK6'];
        const set = monSet || new Set();

        // Toggle từng ô theo mã môn
        items.forEach(item => {
            const code = (item.getAttribute('data-thpt-mon') || '').toString().trim().toUpperCase();
            const visible = set.has(code);
            item.style.display = visible ? '' : 'none';

            // Disable/enable input để không submit những môn không dùng
            item.querySelectorAll('input,select,textarea').forEach(el => {
                el.disabled = !visible;
            });
        });

        // Nhóm chỉ hiện khi có ít nhất 1 môn hiếm cần nhập
        const canShowGroup = codes.some(c => set.has(c));
        if (nhom) nhom.style.display = canShowGroup ? 'block' : 'none';
    }

    function anHetMonThptMoRong() {
        apDungHienThiMonThptMoRong(new Set());
    }

    async function capNhatNhomThptMoRongTheoNganh() {
        const phuongThuc = document.getElementById('phuongThuc')?.value;
        if (phuongThuc !== 'THPT') {
            anHetMonThptMoRong();
            return;
        }

        const maNganh = (document.getElementById('maNganhInput')?.value || '').trim();
        if (!maNganh) {
            anHetMonThptMoRong();
            return;
        }

        // Mặc định ẩn trong lúc chờ API để tránh nhấp nháy.
        anHetMonThptMoRong();

        try {
            const resp = await fetch('/api/nganh/mon-to-hop?maNganh=' + encodeURIComponent(maNganh), {
                headers: { 'Accept': 'application/json' }
            });

            if (!resp.ok) {
                anHetMonThptMoRong();
                return;
            }

            const monList = await resp.json();
            const monSet = new Set((Array.isArray(monList) ? monList : []).map(m => (m || '').toString().trim().toUpperCase()));
            apDungHienThiMonThptMoRong(monSet);
        } catch (e) {
            anHetMonThptMoRong();
        }
    }

    function capNhatFormTheoPhuongThuc() {
        const phuongThuc = document.getElementById('phuongThuc').value;
        const nhomDiem8Mon = document.getElementById('nhomDiem8Mon');
        const nhomDiemTHPTMoRong = document.getElementById('nhomDiemTHPTMoRong');
        const nhomDiemDGNL = document.getElementById('nhomDiemDGNL');
        const inputsMon = document.querySelectorAll('.input-mon');
        const diemDGNL = document.getElementById('diemDGNL');
        const inputsThpt = document.querySelectorAll('.input-thpt');

        // Gắn mặc định min = 0 cho tất cả để chống nhập điểm âm
        inputsMon.forEach(input => input.min = 0);
        diemDGNL.min = 0;

        if (phuongThuc === 'DGNL') {
            nhomDiem8Mon.style.display = 'none';
            nhomDiemDGNL.style.display = 'block';
            inputsMon.forEach(input => input.required = false);

            anHetMonThptMoRong();
            
            diemDGNL.required = true;
            diemDGNL.max = 1200; // ĐGNL max là 1200
            return;
        }

        nhomDiem8Mon.style.display = 'flex';
        nhomDiemDGNL.style.display = 'none';
        diemDGNL.required = false;

        // Đổi placeholder và giới hạn điểm tối đa tùy phương thức
        if (phuongThuc === 'THPT') {
            inputsMon.forEach(input => {
                input.placeholder = 'Thang 10';
                input.max = 10; // THPT max là 10
            });
            capNhatNhomThptMoRongTheoNganh();
        } else { // Phương thức VSAT
            anHetMonThptMoRong();
            inputsMon.forEach(input => {
                input.placeholder = 'Thang 150';
                input.max = 150; // VSAT max là 150
            });
        }
    }

    // --- BÍ KÍP CHỐNG NHẬP LỐ ---
    // Lắng nghe sự kiện gõ phím để tự động chặn ngay lập tức
    document.querySelectorAll('input[type="number"]').forEach(input => {
        input.addEventListener('input', function() {
            // Nếu người dùng nhập giá trị lớn hơn max cho phép -> Ép về max
            if (this.value !== "" && parseFloat(this.value) > parseFloat(this.max)) {
                this.value = this.max;
            }
            // Nếu nhập số âm -> Ép về 0
            if (this.value !== "" && parseFloat(this.value) < parseFloat(this.min)) {
                this.value = this.min;
            }
        });
    });

    // Chạy các sự kiện khi load trang và khi đổi phương thức
    document.getElementById('phuongThuc').addEventListener('change', () => {
        resetDuLieuTinhDiem();
        capNhatFormTheoPhuongThuc();
    });
    capNhatFormTheoPhuongThuc(); // Khởi tạo lần đầu lúc mới vào trang

    // ----- Chọn mã ngành: search + phân trang (20 dòng / trang) -----
    (function initMaNganhPicker() {
        const pageSize = 20;

        const modalEl = document.getElementById('modalChonMaNganh');
        const maNganhInput = document.getElementById('maNganhInput');
        const maNganhDisplay = document.getElementById('maNganhDisplay');
        const searchType = document.getElementById('nganhSearchType');
        const searchInput = document.getElementById('nganhSearchInput');
        const searchBtn = document.getElementById('nganhSearchBtn');
        const tableBody = document.getElementById('nganhTableBody');
        const pagerInfo = document.getElementById('nganhPagerInfo');
        const pagination = document.getElementById('nganhPagination');
        const form = document.getElementById('formTinhDiem');

        if (!modalEl || !maNganhInput || !maNganhDisplay || !searchType || !searchInput || !searchBtn || !tableBody || !pagerInfo || !pagination) return;

        const allRows = Array.from(tableBody.querySelectorAll('tr.nganh-row'));
        let filteredRows = allRows;
        let currentPage = 1;

        function normalizeQuery(q) {
            return (q || '').toString().trim();
        }

        function normalizeText(s) {
            return (s || '')
                .toString()
                .trim()
                .toLowerCase()
                .normalize('NFD')
                .replace(/[\u0300-\u036f]/g, '');
        }

        function placeholderForType(t) {
            return t === 'TEN' ? 'Nhập tên ngành cần tìm...' : 'Nhập mã ngành cần tìm...';
        }

        function applyFilter() {
            const type = (searchType.value || 'MA').toUpperCase();
            const qRaw = normalizeQuery(searchInput.value);
            const q = type === 'TEN' ? normalizeText(qRaw) : qRaw;
            if (!q) {
                filteredRows = allRows;
            } else {
                filteredRows = allRows.filter(r => {
                    if (type === 'TEN') {
                        return normalizeText(r.dataset.ten || '').includes(q);
                    }
                    return (r.dataset.ma || '').includes(q);
                });
            }
            currentPage = 1;
            render();
        }

        function totalPages() {
            return Math.max(1, Math.ceil(filteredRows.length / pageSize));
        }

        function clampPage(p) {
            const tp = totalPages();
            return Math.min(tp, Math.max(1, p));
        }

        function setVisibleRows() {
            const tp = totalPages();
            currentPage = clampPage(currentPage);

            // Ẩn hết trước
            allRows.forEach(r => r.style.display = 'none');

            // Hiện những dòng thuộc page hiện tại
            const start = (currentPage - 1) * pageSize;
            const end = start + pageSize;
            filteredRows.slice(start, end).forEach(r => r.style.display = 'table-row');

            if (filteredRows.length === 0) {
                pagerInfo.textContent = 'Không có kết quả.';
            } else {
                const showingStart = start + 1;
                const showingEnd = Math.min(end, filteredRows.length);
                pagerInfo.textContent = 'Hiển thị ' + showingStart + '-' + showingEnd + ' / ' + filteredRows.length + ' (Trang ' + currentPage + '/' + tp + ')';
            }
        }

        function buildPageButton(label, page, disabled, active) {
            const li = document.createElement('li');
            li.className = 'page-item' + (disabled ? ' disabled' : '') + (active ? ' active' : '');

            const a = document.createElement('a');
            a.className = 'page-link';
            a.href = '#';
            a.textContent = label;
            a.addEventListener('click', (e) => {
                e.preventDefault();
                if (disabled) return;
                currentPage = page;
                render();
            });

            li.appendChild(a);
            return li;
        }

        function renderPagination() {
            const tp = totalPages();
            pagination.innerHTML = '';

            // Prev
            pagination.appendChild(buildPageButton('‹', clampPage(currentPage - 1), currentPage === 1, false));

            // Hiện tối đa 7 nút trang quanh current
            const maxButtons = 7;
            let start = Math.max(1, currentPage - Math.floor(maxButtons / 2));
            let end = Math.min(tp, start + maxButtons - 1);
            start = Math.max(1, end - maxButtons + 1);

            for (let p = start; p <= end; p++) {
                pagination.appendChild(buildPageButton(String(p), p, false, p === currentPage));
            }

            // Next
            pagination.appendChild(buildPageButton('›', clampPage(currentPage + 1), currentPage === tp, false));
        }

        function render() {
            setVisibleRows();
            renderPagination();
        }

        // Chọn mã ngành
        tableBody.addEventListener('click', (e) => {
            const btn = e.target.closest('.btn-chon-nganh');
            const row = e.target.closest('tr.nganh-row');
            const targetRow = (btn && btn.closest('tr.nganh-row')) || row;
            if (!targetRow) return;

            const ma = targetRow.dataset.ma;
            const ten = targetRow.dataset.ten || '';
            if (!ma) return;
            maNganhInput.value = ma;
            maNganhDisplay.value = ten ? (ma + ' - ' + ten) : ma;

            // Khi chọn ngành, cập nhật việc có cần hiện nhóm môn hiếm hay không (chỉ THPT)
            capNhatNhomThptMoRongTheoNganh();

            const modal = bootstrap.Modal.getInstance(modalEl) || new bootstrap.Modal(modalEl);
            modal.hide();
        });

        // Trước khi submit: đảm bảo field gửi lên chỉ là mã ngành
        if (form) {
            form.addEventListener('submit', () => {
                if (maNganhInput.value && maNganhInput.value.trim() !== '') return;
                const displayVal = (maNganhDisplay.value || '').trim();
                if (!displayVal) return;

                const parts = displayVal.split(' - ');
                maNganhInput.value = (parts[0] || '').trim();
            });
        }

        searchBtn.addEventListener('click', applyFilter);
        searchInput.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                applyFilter();
            }
        });

        searchType.addEventListener('change', () => {
            const type = (searchType.value || 'MA').toUpperCase();
            searchInput.placeholder = placeholderForType(type);
            applyFilter();
            searchInput.focus();
        });

        modalEl.addEventListener('shown.bs.modal', () => {
            const type = (searchType.value || 'MA').toUpperCase();
            searchInput.value = '';
            searchInput.placeholder = placeholderForType(type);
            filteredRows = allRows;
            currentPage = 1;
            render();
            searchInput.focus();
        });

        // Render lần đầu (để không bị trống nếu modal mở ngay)
        render();
    })();
</script>
</body>
</html>