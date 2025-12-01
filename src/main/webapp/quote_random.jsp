<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String sessionId = (String) session.getAttribute("sessionId");
    String uploadPath = request.getContextPath() + "/resources/upload/";
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title><fmt:message key="random.page.title"/> - QuoteLibrary</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #212529; color: white; height: 100vh; display: flex; align-items: center; }
        .quote-card {
            background-color: #2b3035; 
            border: 1px solid #373b3e; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            text-shadow: 0 1px 3px rgba(0,0,0,0.8);
        }
        .author-text { color: #e0e0e0; font-style: italic; }
    </style>
</head>
<body>
    <jsp:include page="language_setup.jsp" />

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">     
                <h2 class="text-center mb-4 fw-bold"><fmt:message key="random.header"/></h2>
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
                       
                        String sql = "SELECT * FROM quote WHERE status = 'APPROVED' ORDER BY RAND() LIMIT 1";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            int num = rs.getInt("num");
                            String content = rs.getString("content");
                            String author = rs.getString("author");
                            String contentEn = rs.getString("content_en");
                            String authorEn = rs.getString("author_en");
                            String category = rs.getString("category"); // 예: person, movie
                            String imgFile = rs.getString("img_file");

                            String currentLang = (String) session.getAttribute("sessionLang");
                            
                            // 영어로 교체 로직
                            if ("en".equals(currentLang) && contentEn != null) {
                                content = contentEn;
                                author = authorEn;
                            }
                            
                            // DB값(person) -> 키(cat.person.title)로 변환
                            String categoryKey = "cat." + category + ".title";

                            String cardStyle = "";
                            if (imgFile != null && !imgFile.isEmpty()) {
                                cardStyle = "background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('" + uploadPath + imgFile + "'); background-size: cover; background-position: center; min-height: 400px;";
                            } else {
                                cardStyle = "min-height: 300px;";
                            }
                %>

                <div class="card quote-card border-0 rounded-4 overflow-hidden" style="<%= cardStyle %>">
                    <div class="card-body d-flex flex-column justify-content-center align-items-center text-center p-5">
                        
                        <span class="badge bg-warning text-dark mb-3">
                            <fmt:message key="<%= categoryKey %>"/>
                        </span>
                        
                        <h3 class="display-6 fw-bold mb-4" style="line-height: 1.5;">
                            "<%= content %>"
                        </h3>
                        
                        <p class="fs-5 author-text mb-4">
                            - <%= author.replace("<", "&lt;").replace(">", "&gt;") %>
                        </p>

                        <div class="d-flex gap-2">
                            <a href="quote_random.jsp" class="btn btn-light btn-lg fw-bold">
                                <fmt:message key="btn.refresh"/>
                            </a>
                            
                            <% if (sessionId != null) { %>
                                <a href="scrap_process.jsp?num=<%= num %>" class="btn btn-outline-warning btn-lg">
                                    <fmt:message key="btn.scrap"/>
                                </a>
                            <% } %>
                        </div>
                    </div>
                </div>

                <%
                        } else {
                %>
                    <div class="alert alert-secondary text-center">
                        <fmt:message key="msg.no.quote"/>
                    </div>
                <%
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
                %>

                <div class="text-center mt-5">
                    <a href="main.jsp" class="text-white-50 text-decoration-none">
                        <fmt:message key="btn.home"/>
                    </a>
                </div>

            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>