<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 카테고리 파라미터 받기
    String category = request.getParameter("category");
    if (category == null) {
        category = "person";
    }

    String titleKey = "cat." + category + ".title";  
    String descKey = "list." + category + ".desc";

    String sessionId = (String) session.getAttribute("sessionId");
    String uploadPath = request.getContextPath() + "/resources/upload/";

    // 파라미터로 'lang'이 있으면 최우선으로 반영
    String reqLang = request.getParameter("lang");
    String currentLang = null;

    if (reqLang != null && !reqLang.isEmpty()) {
        currentLang = reqLang;
        // 세션 업데이트
        session.setAttribute("sessionLang", currentLang);
    } else {
        currentLang = (String) session.getAttribute("sessionLang");
    }

    // 기본값
    if (currentLang == null) currentLang = "ko";
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><fmt:message key="<%= titleKey %>"/> - QuoteLibrary</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #212529;
            color: white;
        }
        .quote-card {
            background-color: #2b3035; 
            border: 1px solid #373b3e;
            transition: transform 0.2s, border-color 0.2s;
            text-shadow: 0 1px 3px rgba(0,0,0,0.8); 
        }
        .quote-card:hover {
            transform: translateY(-3px);
            border-color: #adb5bd;
        }
        .author-text {
            color: #e0e0e0;
            font-style: italic;
        }
    </style>
</head>
<body>
    <jsp:include page="language_setup.jsp" />
    
    <jsp:include page="menu.jsp" />

    <main class="container py-5">
        
        <div class="p-4 p-md-5 mb-4 rounded text-bg-dark" style="background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('resources/img/library_bg.jpg'); background-size: cover; background-position: center;">
            <div class="col-md-6 px-0">
                <h1 class="display-4 fst-italic fw-bold">
                    <fmt:message key="<%= titleKey %>"/>
                </h1>
                <p class="lead my-3">
                    <fmt:message key="<%= descKey %>"/>
                </p>
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

                    String sql = "SELECT * FROM quote WHERE category = ? AND status = 'APPROVED' ORDER BY num DESC";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, category);
                    rs = pstmt.executeQuery();

                    boolean hasData = false;
                    while (rs.next()) {
                        int num = rs.getInt("num");
                        
                        String content = rs.getString("content");
                        String author = rs.getString("author");
                        String contentEn = rs.getString("content_en");	//영어 데이터
                        String authorEn = rs.getString("author_en");
                        
                        String date = rs.getString("regist_day");
                        String imgFile = rs.getString("img_file");

                        // 영어 번역 로직
                        if ("en".equals(currentLang) && contentEn != null && !contentEn.isEmpty()) {
                            content = contentEn;
                            author = authorEn;
                        }
                        
						String cardStyle = "";
                        
                        if (imgFile != null && !imgFile.isEmpty()) {
                            cardStyle = "background-image: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('" + uploadPath + imgFile + "'); background-size: cover; background-position: center;";
                        }
            %>
            
            <div class="col-md-6">
                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative quote-card" style="<%= cardStyle %>">
                    <div class="col p-4 d-flex flex-column position-static">
                        <strong class="d-inline-block mb-2 text-primary-emphasis">
                            <fmt:message key="<%= titleKey %>"/>
                        </strong>
                        
                        <h3 class="mb-3 fs-4 fw-bold">"<%= content %>"</h3>
                        
                        <div class="mb-1 author-text">- <%= author.replace("<", "&lt;").replace(">", "&gt;") %></div>
                        <div class="mb-auto text-white-50 small"><%= date %></div>
                        
                        <div class="mt-3">
                            <% if (sessionId != null) { %>
                                <a href="scrap_process.jsp?num=<%= num %>" class="btn btn-sm btn-outline-warning">
                                    <fmt:message key="btn.scrap"/>
                                </a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    } // while 종료
                    
                    if (!hasData) {
            %>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <div class="alert alert-danger">Error loading data.</div>
            <%
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div> 
        
        <div class="text-center mt-4">
            <a href="main.jsp" class="btn btn-secondary">
                <fmt:message key="btn.home"/>
            </a>
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