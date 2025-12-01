<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로그인 체크
    if (session.getAttribute("sessionId") == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>명언 등록 신청</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    <style> body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fa; } </style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-white">
                        <h4 class="mb-0 fw-bold">명언 등록 신청</h4>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info">
                            관리자의 승인 후 메인 목록에 게시됩니다.<br>
                            (관리자는 즉시 등록됩니다.)
                        </div>

                        <form action="quote_add_process.jsp" method="post" enctype="multipart/form-data">
                            
                            <div class="mb-3">
                                <label class="form-label">카테고리</label>
                                <select class="form-select" name="category">
                                    <option value="person">실존 인물</option>
                                    <option value="movie">영화</option>
                                    <option value="novel">소설</option>
                                    <option value="virtual">애니메이션 & 게임</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">명언 내용</label>
                                <textarea class="form-control" name="content" rows="3" required placeholder="감동적인 문구를 입력하세요"></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">저자 / 작품명</label>
                                <input type="text" class="form-control" name="author" required placeholder="인물이나 작품을 입력하세요">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">배경 이미지 (선택)</label>
                                <input type="file" class="form-control" name="img_file">
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">등록 신청</button>
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