<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String sessionId = (String) session.getAttribute("sessionId");
    if (sessionId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }
    
    String uploadPath = request.getContextPath() + "/resources/upload/";
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>나의 스크랩 - QuoteLibrary</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #212529; color: white; }
        .quote-card { background-color: #2b3035; border: 1px solid #373b3e; transition: transform 0.2s; text-shadow: 0 1px 3px rgba(0,0,0,0.8); }
        .quote-card:hover { transform: translateY(-3px); border-color: #adb5bd; }
        .author-text { color: #e0e0e0; font-style: italic; }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <main class="container py-5">
        <h2 class="mb-4 fw-bold text-warning">⭐ 나의 스크랩 보관함</h2>
        
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

                    // 현재 로그인한 사용자의 스크랩 목록을 가져옴
                    String sql = "SELECT q.*, s.num AS scrap_id " + 
                                 "FROM quote q JOIN scrap s ON q.num = s.quote_num " +
                                 "WHERE s.member_id = ? ORDER BY s.num DESC";
                                 
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, sessionId);
                    rs = pstmt.executeQuery();
                    
                    boolean hasData = false;

                    while (rs.next()) {
                        hasData = true;
                        int scrapId = rs.getInt("scrap_id");
                        String content = rs.getString("content");
                        String author = rs.getString("author");
                        String date = rs.getString("regist_day");
                        String imgFile = rs.getString("img_file");
                        String category = rs.getString("category");

                        String cardStyle = "";
                        if (imgFile != null && !imgFile.isEmpty()) {
                            cardStyle = "background-image: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('" + uploadPath + imgFile + "'); background-size: cover; background-position: center;";
                        }
            %>
            
            <div class="col-md-6">
                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative quote-card" style="<%= cardStyle %>">
                    <div class="col p-4 d-flex flex-column position-static">
                        <strong class="d-inline-block mb-2 text-warning"><%= category %></strong>
                        
                        <h3 class="mb-3 fs-4 fw-bold">"<%= content %>"</h3>
                        
                        <div class="mb-1 author-text">- <%= author.replace("<", "&lt;").replace(">", "&gt;") %></div>
                        <div class="mb-auto text-white-50 small"><%= date %></div>
                        
                        <div class="mt-3">
                            <a href="scrap_delete.jsp?scrap_id=<%= scrapId %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('보관함에서 삭제하시겠습니까?');">🗑️ 삭제</a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    } // while 종료
                    
                    if (!hasData) {
            %>
                <div class="col-12 py-5 text-center">
                    <h5 class="text-white-50">아직 스크랩한 명언이 없습니다.</h5>
                    <a href="main.jsp" class="btn btn-primary mt-3">명언 보러 가기</a>
                </div>
            <%
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (conn != null) conn.close();
                }
            %>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>