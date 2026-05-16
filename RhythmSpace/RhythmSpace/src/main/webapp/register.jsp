<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - RhythmSpace</title>
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        /* CSS y hệt trang Login */
        :root {
            --bg-gradient: linear-gradient(135deg, #6c1a6e 0%, #321554 50%, #17183b 100%);
            --glass-bg: rgba(20, 20, 35, 0.6);
            --glass-border: rgba(255, 255, 255, 0.1);
            --neon-blue: #00f2fe;
            --input-bg: rgba(0, 0, 0, 0.4);
        }
        body { margin: 0; padding: 0; height: 100vh; background: var(--bg-gradient); color: #ffffff; font-family: 'Segoe UI', Tahoma, sans-serif; display: flex; align-items: center; justify-content: center; overflow: hidden; }
        .register-glass-box { background: var(--glass-bg); backdrop-filter: blur(25px); -webkit-backdrop-filter: blur(25px); border: 1px solid var(--glass-border); border-radius: 20px; padding: 40px; width: 100%; max-width: 400px; box-shadow: 0 20px 50px rgba(0,0,0,0.5); animation: fadeIn 0.8s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .custom-input { background: var(--input-bg) !important; border: 1px solid var(--glass-border) !important; color: white !important; border-radius: 10px; padding: 10px 15px; }
        .custom-input:focus { outline: none; border-color: var(--neon-blue) !important; box-shadow: 0 0 10px rgba(0, 242, 254, 0.3) !important; }
        .btn-neon { background: linear-gradient(90deg, #00f2fe 0%, #4facfe 100%); border: none; color: white; font-weight: bold; border-radius: 10px; padding: 12px; transition: 0.3s; text-transform: uppercase; letter-spacing: 1px; }
        .btn-neon:hover { box-shadow: 0 5px 20px rgba(0, 242, 254, 0.5); transform: translateY(-2px); color: white; }
        .alert-glass { background: rgba(220, 53, 69, 0.2); border: 1px solid rgba(220, 53, 69, 0.4); color: #ff9ea8; border-radius: 10px; }
    </style>
</head>
<body>

    <div class="register-glass-box">
        <h3 class="text-center fw-bold mb-4">Create Account</h3>

        <form action="register" method="post" autocomplete="off">
            <% 
                String error = (String) request.getAttribute("errorMsg");
                if(error != null) { 
            %>
                <div class="alert alert-glass p-2 text-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-1"></i> <%= error %>
                </div>
            <% } %>

            <div class="mb-3">
                <input class="form-control custom-input" type="text" name="username" required placeholder="Username (e.g. hekio)"/>
            </div>
            
            <div class="mb-3">
                <input class="form-control custom-input" type="email" name="email" required placeholder="Email Address"/>
            </div>
            
            <div class="mb-3">
                <input class="form-control custom-input" type="password" name="password" required placeholder="Password"/>
            </div>
            
            <div class="mb-4">
                <input class="form-control custom-input" type="password" name="repassword" required placeholder="Confirm Password"/>
            </div>
            
            <button class="btn btn-neon w-100" type="submit">Sign Up</button>
            
            <div class="text-center mt-4">
                <a href="login" class="text-decoration-none text-secondary" style="font-size: 0.9rem;">
                    Already have an account? <span style="color: var(--neon-blue);">Log in</span>
                </a>
            </div>
        </form>
    </div>

</body>
</html>