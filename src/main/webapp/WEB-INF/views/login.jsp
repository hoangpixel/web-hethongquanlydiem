<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Cổng Tra Cứu Tuyển Sinh</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* CSS tự chế xíu cho cái nền nó xịn */
        body {
            background-color: #f4f7f6;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 10px;
            border: none;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card login-card mt-5">
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <h4 class="text-primary fw-bold">ĐẠI HỌC SÀI GÒN</h4>
                        <p class="text-muted">Cổng Tra Cứu Kết Quả Tuyển Sinh</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger p-2 text-center" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <form action="/check-login" method="POST">
                        <div class="mb-3">
                            <label for="cccd" class="form-label fw-semibold">Số CCCD</label>
                            <input type="text" class="form-control" id="cccd" name="cccd" placeholder="Nhập căn cước công dân" required>
                        </div>
                        <div class="mb-4">
                            <label for="password" class="form-label fw-semibold">Mật khẩu</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">Tra Cứu Kết Quả</button>
                        </div>
                    </form>
                    
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>