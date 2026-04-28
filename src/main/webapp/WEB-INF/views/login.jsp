<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Đăng nhập | Hệ thống Quản lý Điểm</title>
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@400;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
            <link rel="icon" href="${pageContext.request.contextPath}/img/logo.png" type="image/png">
        </head>

        <body>
            <div class="auth">
                <div class="auth__left" aria-hidden="true">
                    <div class="auth__brand">
                        <div class="logo-wrapper">
                            <img src="${pageContext.request.contextPath}/img/logo.png" alt="SGU Logo" class="brand-logo">
                        </div>
                        <h1 class="brand-title">Hệ thống Quản lý Điểm</h1>
                        <p class="brand-tagline">Tiên phong công nghệ trong giáo dục</p>
                    </div>
                </div>

                <div class="auth__right">
                    <div class="panel">
                        <div class="panel__header">
                            <h2 class="panel__title">Chào mừng trở lại</h2>
                            <p class="panel__subtitle">Vui lòng nhập thông tin để đăng nhập vào hệ thống.</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="panel__error">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="10" />
                                    <line x1="12" y1="8" x2="12" y2="12" />
                                    <line x1="12" y1="16" x2="12.01" y2="16" />
                                </svg>
                                <span>${error}</span>
                            </div>
                        </c:if>

                        <form class="form" action="${pageContext.request.contextPath}/check-login" method="POST">
                            <div class="input-group">
                                <label class="label" for="cccd">Số CCCD</label>
                                <div class="input-wrapper">
                                    <input class="input" type="text" id="cccd" name="cccd"
                                        placeholder="Nhập căn cước công dân" required />
                                </div>
                            </div>

                            <div class="input-group">
                                <label class="label" for="password">Mật khẩu</label>
                                <div class="input-wrapper">
                                    <input class="input" type="password" id="password" name="password"
                                        placeholder="••••••••" required />
                                </div>
                            </div>

                            <div class="row">
                                <label class="checkbox">
                                    <input type="checkbox" name="remember" />
                                    <span class="checkbox-custom"></span>
                                    <span>Ghi nhớ đăng nhập</span>
                                </label>
                            </div>

                            <button class="btn" type="submit">
                                <span class="btn-text">Đăng nhập</span>
                                <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                    stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="5" y1="12" x2="19" y2="12" />
                                    <polyline points="12 5 19 12 12 19" />
                                </svg>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </body>

        </html>