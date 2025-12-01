<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
<body class="bg-light">  

    <jsp:include page="menu.jsp" />
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <h3 class="text-center mb-4 fw-bold">로그인</h3>
                        
                        <form action="login_process.jsp" method="post">
                            <div class="mb-3">
                                <label for="id" class="form-label">아이디</label>
                                <input type="text" class="form-control" id="id" name="id" required placeholder="User ID">
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">비밀번호</label>
                                <input type="password" class="form-control" id="password" name="password" required placeholder="Password">
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">로그인</button>
                                <a href="main.jsp" class="btn btn-secondary">취소</a>
                            </div>
                        </form>                       
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>