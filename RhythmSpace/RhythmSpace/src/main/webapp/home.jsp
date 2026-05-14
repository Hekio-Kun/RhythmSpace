<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RhythmSpace - Offline Music Universe</title>
    <!-- Bootstrap CSS -->
    <link href="bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        /* CSS Variables cho Theme màu */
        :root {
            --bg-gradient: linear-gradient(135deg, #6c1a6e 0%, #321554 50%, #17183b 100%);
            --taskbar-bg: rgba(20, 20, 35, 0.7);
            --glass-bg: rgba(255, 255, 255, 0.08);
            --glass-border: rgba(255, 255, 255, 0.1);
            --neon-blue: #00f2fe;
            --neon-purple: #ff0844;
        }

        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: var(--bg-gradient);
            color: #ffffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow: hidden; /* Giống màn hình desktop, không cuộn */
        }

        /* --- PHẦN NỘI DUNG GIỮA MÀN HÌNH --- */
        .desktop-content {
            height: calc(100vh - 60px); /* Trừ đi chiều cao taskbar */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .app-icon-large {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #ff7eb3, #ff758c);
            border-radius: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 60px;
            box-shadow: 0 10px 30px rgba(255, 117, 140, 0.4);
            margin-bottom: 20px;
        }

        .brand-title { font-size: 3.5rem; font-weight: bold; margin: 0; letter-spacing: 1px; }
        .brand-subtitle { font-size: 1.2rem; color: #d1d5db; margin-bottom: 30px; }

        .badge-container { display: flex; gap: 15px; margin-bottom: 40px; }
        .feature-badge {
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            padding: 8px 20px;
            border-radius: 50px;
            font-size: 0.9rem;
            backdrop-filter: blur(10px);
        }

        /* --- THANH TASKBAR --- */
        .taskbar {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 60px;
            background: var(--taskbar-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-top: 1px solid rgba(255, 255, 255, 0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 15px;
            z-index: 1000;
        }

        /* Nút Start (RhythmSpace) */
        .start-btn {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.2s;
        }
        .start-btn:hover { background: var(--glass-bg); }
        .start-btn i { font-size: 1.2rem; color: #ff7eb3; }

        /* Search Bar trên taskbar */
        .taskbar-search {
            background: rgba(0,0,0,0.3);
            border: 1px solid var(--glass-border);
            color: white;
            border-radius: 20px;
            padding: 5px 15px;
            width: 250px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .taskbar-search input {
            background: transparent; border: none; color: white; outline: none; width: 100%; font-size: 0.9rem;
        }

        /* Các App đang ghim */
        .pinned-apps { display: flex; gap: 5px; }
        .app-icon {
            width: 40px; height: 40px;
            border-radius: 8px;
            display: flex; justify-content: center; align-items: center;
            cursor: pointer; transition: 0.2s;
            position: relative;
        }
        .app-icon:hover { background: var(--glass-bg); }
        .app-icon.active::after {
            content: ''; position: absolute; bottom: 2px; width: 4px; height: 4px;
            background: var(--neon-blue); border-radius: 50%;
        }

        /* Khay hệ thống bên phải */
        .system-tray { display: flex; align-items: center; gap: 15px; font-size: 0.9rem; }
        .sys-btn { cursor: pointer; padding: 5px 10px; border-radius: 5px; transition: 0.2s; display: flex; gap: 8px; align-items: center; text-decoration: none; color: white;}
        .sys-btn:hover { background: var(--glass-bg); color: var(--neon-blue); }

        /* --- START MENU (MENU CỬA SỔ) --- */
        .start-menu {
            position: absolute;
            bottom: 70px;
            left: 15px;
            width: 350px;
            background: rgba(20, 20, 35, 0.85);
            backdrop-filter: blur(25px);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            padding: 20px;
            transform: translateY(20px);
            opacity: 0;
            pointer-events: none;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            z-index: 999;
        }
        .start-menu.show {
            transform: translateY(0);
            opacity: 1;
            pointer-events: auto;
        }
        
        .user-profile { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid var(--glass-border); }
        .user-avatar { width: 50px; height: 50px; background: var(--neon-blue); border-radius: 50%; display: flex; justify-content: center; align-items: center; font-size: 24px; color: #000; font-weight: bold; }
        
        .menu-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; margin-bottom: 20px; }
        .menu-item { text-align: center; cursor: pointer; padding: 10px; border-radius: 8px; transition: 0.2s; }
        .menu-item:hover { background: var(--glass-bg); }
        .menu-item i { font-size: 24px; color: var(--neon-blue); margin-bottom: 5px; display: block; }
        
        .menu-footer { display: flex; justify-content: space-between; align-items: center; padding-top: 15px; border-top: 1px solid var(--glass-border); }
    </style>
</head>
<body>

    <!-- NỘI DUNG DESKTOP -->
    <div class="desktop-content">
        <div class="app-icon-large">
            <i class="bi bi-music-note"></i>
        </div>
        <h1 class="brand-title">RhythmSpace</h1>
        <p class="brand-subtitle">Your offline music universe</p>

        <div class="badge-container">
            <div class="feature-badge"><i class="bi bi-stars"></i> Offline First</div>
            <div class="feature-badge"><i class="bi bi-music-note-list"></i> High Quality Audio</div>
            <div class="feature-badge"><i class="bi bi-magic"></i> Smart Playlists</div>
        </div>

        <p style="color: #9ca3af; font-size: 0.9rem;">Click the RhythmSpace button in the taskbar to get started</p>
    </div>

    <!-- START MENU (Bảng điều khiển ẩn) -->
    <div class="start-menu" id="startMenu">
        
        <!-- Xử lý hiển thị bằng JSP Session -->
        <c:choose>
            <c:when test="${not empty sessionScope.account}">
                <!-- ĐÃ ĐĂNG NHẬP -->
                <div class="user-profile">
                    <!-- Lấy chữ cái đầu của Username làm Avatar -->
                    <div class="user-avatar">${sessionScope.account.username.substring(0, 1).toUpperCase()}</div>
                    <div>
                        <h6 class="mb-0 fw-bold">${sessionScope.account.username}</h6>
                        <small class="text-secondary">${sessionScope.account.email}</small>
                    </div>
                </div>
                
                <div class="menu-grid">
                    <div class="menu-item"><i class="bi bi-person-gear"></i><small>Hồ sơ</small></div>
                    <div class="menu-item"><i class="bi bi-collection-play"></i><small>Thư viện</small></div>
                    <div class="menu-item"><i class="bi bi-gear"></i><small>Cài đặt</small></div>
                </div>
                
                <div class="menu-footer">
                    <a href="logout" class="btn btn-sm btn-outline-danger"><i class="bi bi-box-arrow-left"></i> Log out</a>
                    <i class="bi bi-power text-danger" style="cursor:pointer; font-size: 20px;"></i>
                </div>
            </c:when>
            
            <c:otherwise>
                <!-- CHƯA ĐĂNG NHẬP -->
                <div class="text-center py-4 border-bottom border-secondary mb-3">
                    <i class="bi bi-shield-lock text-secondary" style="font-size: 40px;"></i>
                    <h6 class="mt-2">Bạn chưa đăng nhập</h6>
                    <small class="text-secondary">Hãy đăng nhập để đồng bộ nhạc.</small>
                </div>
                
                <div class="menu-footer justify-content-center">
                    <a href="login.jsp" class="btn btn-primary w-100 fw-bold"><i class="bi bi-box-arrow-in-right"></i> Log In</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- TASKBAR -->
    <div class="taskbar">
        <!-- Khu vực bên trái & Apps -->
        <div class="d-flex align-items-center gap-3">
            <!-- Nút Start -->
            <div class="start-btn" onclick="toggleStartMenu()">
                <i class="bi bi-music-note-beamed"></i>
                <span class="fw-bold">RhythmSpace</span>
            </div>

            <!-- Thanh tìm kiếm -->
            <div class="taskbar-search">
                <i class="bi bi-search text-secondary"></i>
                <input type="text" placeholder="Search music, artists, playlists...">
            </div>

            <!-- Các ứng dụng ghim -->
            <div class="pinned-apps ms-3">
                <div class="app-icon active"><i class="bi bi-music-note-list fs-5"></i></div>
                <div class="app-icon"><i class="bi bi-search fs-5"></i></div>
                <div class="app-icon"><i class="bi bi-image fs-5"></i></div>
                <div class="app-icon"><i class="bi bi-camera-video fs-5"></i></div>
            </div>
        </div>

        <!-- Khay hệ thống bên phải -->
        <div class="system-tray">
            <!-- Hiện tên hoặc nút Login dựa vào Session -->
            <c:choose>
                <c:when test="${not empty sessionScope.account}">
                    <div class="sys-btn" onclick="toggleStartMenu()">
                        <i class="bi bi-person-circle"></i> ${sessionScope.account.username}
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp" class="sys-btn"><i class="bi bi-person"></i> Login</a>
                </c:otherwise>
            </c:choose>

            <div class="sys-btn"><i class="bi bi-gear"></i></div>
            
            <div class="text-end lh-sm ms-2" style="font-size: 0.8rem;">
                <div id="clockTime" class="fw-bold">--:-- AM</div>
                <div id="clockDate">May 15</div>
            </div>
        </div>
    </div>

    <!-- JavaScript xử lý Start Menu và Đồng hồ -->
    <script>
        // Bật/tắt menu Start
        function toggleStartMenu() {
            const menu = document.getElementById('startMenu');
            menu.classList.toggle('show');
        }

        // Đóng menu nếu bấm ra ngoài desktop
        document.querySelector('.desktop-content').addEventListener('click', function() {
            document.getElementById('startMenu').classList.remove('show');
        });

        // Hàm cập nhật đồng hồ hệ thống góc phải dưới
        function updateClock() {
            const now = new Date();
            
            // Lấy giờ phút (Định dạng 12h)
            let hours = now.getHours();
            let minutes = now.getMinutes();
            const ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // Số 0 thành 12
            minutes = minutes < 10 ? '0' + minutes : minutes;
            document.getElementById('clockTime').innerText = hours + ':' + minutes + ' ' + ampm;

            // Lấy Ngày Tháng (VD: May 15)
            const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            document.getElementById('clockDate').innerText = months[now.getMonth()] + ' ' + now.getDate();
        }

        // Chạy đồng hồ mỗi giây
        setInterval(updateClock, 1000);
        updateClock(); // Chạy ngay lần đầu
    </script>
</body>
</html>