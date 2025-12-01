<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 카테고리 받기
    String category = request.getParameter("category");
    if (category == null) {
        category = "person";
    }

    // 한국어 제목 및 설명 설정
    String categoryTitle = "";
    String categoryDesc = "";
    
    if ("person".equals(category)) {
        categoryTitle = "실존 인물";
        categoryDesc = "위대한 발자취를 남긴 거인들의 어깨 위에서 세상을 바라봅니다.";
    } else if ("movie".equals(category)) {
        categoryTitle = "영화";
        categoryDesc = "인생이라는 영화 속, 오직 당신만을 위한 명장면.";
    } else if ("novel".equals(category)) {
        categoryTitle = "소설";
        categoryDesc = "활자 속에 숨겨진 깊은 통찰과 여운.";
    } else if ("virtual".equals(category)) {
        categoryTitle = "애니메이션 & 게임";
        categoryDesc = "또 다른 세계에서 피어난 진심 어린 이야기.";
    }

    String sessionId = (String) session.getAttribute("sessionId");
    
    String uploadPath = request.getContextPath() + "/resources/upload/";
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>명언 목록</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #212529;
            color: white;
        }
        /* 카드 기본 스타일링 */
        .quote-card {
            background-color: #2b3035; /* 이미지가 없을 때 기본 배경색 */
            border: 1px solid #373b3e;
            transition: transform 0.2s, border-color 0.2s;
            /* 배경 이미지가 있을 때 글씨 가독성을 위해 그림자 추가 */
            text-shadow: 0 1px 3px rgba(0,0,0,0.8); 
        }
        .quote-card:hover {
            transform: translateY(-3px);
            border-color: #adb5bd;
        }
        /* 저자 이름 색상 변경 */
        .author-text {
            color: #e0e0e0;
            font-style: italic;
        }
    </style>
</head>
<body>

    <jsp:include page="menu.jsp" />

    <main class="container py-5">
        
        <div class="p-4 p-md-5 mb-4 rounded text-bg-dark" style="background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('resources/img/library_bg.jpg'); background-size: cover; background-position: center;">
            <div class="col-md-6 px-0">
                <h1 class="display-4 fst-italic fw-bold"><%= categoryTitle %></h1>
                <p class="lead my-3"><%= categoryDesc %></p>
            </div>
        </div>

        <div class="row mb-2">
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/QuoteLibDB?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul";
                    String dbId = "root";
                    String dbPw = "dongha0812";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbId, dbPw);

                    // 승인된 명언 가져옴
                    String sql = "SELECT * FROM quote WHERE category = ? AND status = 'APPROVED' ORDER BY num DESC";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, category);
                    rs = pstmt.executeQuery();

                    // 명언 카드 생성
                    while (rs.next()) {
                        int num = rs.getInt("num");
                        String content = rs.getString("content");
                        String author = rs.getString("author");
                        String date = rs.getString("regist_day");
                        String imgFile = rs.getString("img_file");

                        // 동적 스타일 문자열 준비
                        String cardStyle = "";
                        
                        if (imgFile != null && !imgFile.isEmpty()) {
                            cardStyle = "background-image: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('" + uploadPath + imgFile + "'); background-size: cover; background-position: center;";
                        }
            %>
            
            <div class="col-md-6">
                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative quote-card" style="<%= cardStyle %>">
                    <div class="col p-4 d-flex flex-column position-static">
                        <strong class="d-inline-block mb-2 text-primary-emphasis"><%= categoryTitle %></strong>
                        
                        <h3 class="mb-3 fs-4 fw-bold">"<%= content %>"</h3>
                        
                        <div class="mb-1 author-text">- <%=author.replace("<", "&lt;").replace(">", "&gt;") %></div>
                        <div class="mb-auto text-white-50 small"><%= date %></div>
                        
                        <div class="mt-3">
                            <% if (sessionId != null) { %>
                                <a href="scrap_process.jsp?num=<%= num %>" class="btn btn-sm btn-outline-warning">⭐ 스크랩</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    } // 명언 카드 생성 종료
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <div class="alert alert-danger">데이터를 불러오는 중 오류가 발생했습니다.</div>
            <%
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div> 
        
        <div class="text-center mt-4">
            <a href="main.jsp" class="btn btn-secondary">메인으로 돌아가기</a>
        </div>

    </main>

    <footer class="text-white-50 py-5">
        <div class="container text-center">
            <p>QuoteLibrary &copy; JSP Project Example</p>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>