<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    <style> body { font-family: 'Noto Sans KR', sans-serif; } </style>
</head>
<body class="bg-light">
    
    <jsp:include page="menu.jsp" />

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <h3 class="text-center mb-4 fw-bold">회원가입</h3>
                        
                        <form action="signup_process.jsp" method="post" name="newMember" onsubmit="return checkForm()">
                            <div class="mb-3">
                                <label class="form-label">아이디</label>
                                <input type="text" class="form-control" name="id" placeholder="ID">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">비밀번호</label>
                                <input type="password" class="form-control" name="password" placeholder="Password">
                            </div>
                             <div class="mb-3">
                                <label class="form-label">이름</label>
                                <input type="text" class="form-control" name="name" placeholder="Name">
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">가입하기</button>
                                <a href="main.jsp" class="btn btn-secondary">취소</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function checkForm() {
            var form = document.newMember;
            if (!form.id.value) {
                alert("아이디를 입력해주세요.");
                form.id.focus();
                return false;
            }
            if (!form.password.value) {
                alert("비밀번호를 입력해주세요.");
                form.password.focus();
                return false;
            }
            if (!form.name.value) {
                alert("이름을 입력해주세요.");
                form.name.focus();
                return false;
            }
            return true;
        }
    </script>
</body>
</html>