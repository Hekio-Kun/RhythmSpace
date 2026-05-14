<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - RhythmSpace</title>
    <!-- Bootstrap CSS -->
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        /* CSS Variables đồng bộ với trang Home */
        :root {
            --bg-gradient: linear-gradient(135deg, #6c1a6e 0%, #321554 50%, #17183b 100%);
            --glass-bg: rgba(20, 20, 35, 0.6);
            --glass-border: rgba(255, 255, 255, 0.1);
            --neon-blue: #00f2fe;
            --input-bg: rgba(0, 0, 0, 0.4);
        }

        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: var(--bg-gradient); /* Nền dùng chung với trang Home */
            color: #ffffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        /* Khung đăng nhập kính mờ (Glassmorphism) */
        .login-glass-box {
            background: var(--glass-bg);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 380px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5);
            animation: fadeIn 0.8s ease-out;
        }

        /* Hiệu ứng xuất hiện mượt mà */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px) scale(0.95); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        /* Avatar người dùng giả lập Lock Screen */
        .user-avatar-lock {
            width: 90px;
            height: 90px;
            background: linear-gradient(135deg, #ff7eb3, #ff758c);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 40px;
            color: white;
            margin: 0 auto 20px auto;
            box-shadow: 0 8px 25px rgba(255, 117, 140, 0.4);
        }

        /* Custom ô nhập liệu (Inputs) */
        .custom-input {
            background: var(--input-bg) !important;
            border: 1px solid var(--glass-border) !important;
            color: white !important;
            border-radius: 10px;
            padding: 12px 15px;
            transition: all 0.3s;
        }
        .custom-input::placeholder { color: #9ca3af; }
        .custom-input:focus {
            outline: none;
            border-color: var(--neon-blue) !important;
            box-shadow: 0 0 10px rgba(0, 242, 254, 0.3) !important;
        }

        /* Nút đăng nhập sáng bóng */
        .btn-neon {
            background: linear-gradient(90deg, #00f2fe 0%, #4facfe 100%);
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 10px;
            padding: 12px;
            transition: 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn-neon:hover {
            box-shadow: 0 5px 20px rgba(0, 242, 254, 0.5);
            transform: translateY(-2px);
            color: white;
        }

        /* Khung báo lỗi kính mờ màu đỏ */
        .alert-glass {
            background: rgba(220, 53, 69, 0.2);
            border: 1px solid rgba(220, 53, 69, 0.4);
            color: #ff9ea8;
            border-radius: 10px;
        }
    </style>
</head>
<body>

    <div class="login-glass-box">
        
        <!-- Logo / Avatar (Giống màn hình chờ của Windows) -->
        <div class="user-avatar-lock">
            <i class="bi bi-person-fill"></i>
        </div>
        
        <h4 class="text-center fw-bold mb-4">Welcome Back</h4>

        <!-- Form gửi dữ liệu (Giữ nguyên logic Java Backend) -->
        <form action="login" method="post" autocomplete="off">
            
            <!-- Hiển thị lỗi (Cũng được thiết kế lại) -->
            <% 
                String error = (String) request.getSession().getAttribute("errorMsg");
                if(error != null) { 
            %>
                <div class="alert alert-glass p-2 text-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-1"></i> <%= error %>
                </div>
            <% 
                    request.getSession().removeAttribute("errorMsg");
                } 
            %>

            <!-- Ô nhập Tài khoản -->
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text border-0" style="background: var(--input-bg); color: #9ca3af; border-radius: 10px 0 0 10px;">
                        <i class="bi bi-person"></i>
                    </span>
                    <input class="form-control custom-input" style="border-radius: 0 10px 10px 0;" type="text" name="username" required placeholder="Username" autocomplete="off"/>
                </div>
            </div>
            
            <!-- Ô nhập Mật khẩu -->
            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text border-0" style="background: var(--input-bg); color: #9ca3af; border-radius: 10px 0 0 10px;">
                        <i class="bi bi-key"></i>
                    </span>
                    <input class="form-control custom-input" style="border-radius: 0 10px 10px 0;" type="password" name="password" required placeholder="Password" autocomplete="new-password"/>
                </div>
            </div>
            
            <!-- Nút Submit -->
            <button class="btn btn-neon w-100" type="submit">Log In <i class="bi bi-arrow-right-short fs-5 align-middle"></i></button>
            
            <div class="text-center mt-4">
                <a href="home.jsp" class="text-decoration-none text-secondary" style="font-size: 0.9rem; transition: 0.2s;"><i class="bi bi-arrow-left-circle"></i> Về trang chủ dưới tư cách khách</a>
            </div>
        </form>
    </div>

</body>
</html>