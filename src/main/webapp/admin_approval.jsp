<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 관리자가 아니면 쫓아냄
    String sessionRole = (String) session.getAttribute("sessionRole");
    if (sessionRole == null || !"ADMIN".equals(sessionRole)) {
        out.println("<script>alert('관리자만 접근 가능합니다.'); location.href='main.jsp';</script>");
        return;
    }
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>승인 대기 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    <style> 
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fa; }
        .table-img { width: 50px; height: 50px; object-fit: cover; border-radius: 5px; }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <div class="container py-5">
        <h2 class="fw-bold mb-4">📢 승인 대기 목록</h2>
        <div class="alert alert-warning">
            사용자들이 신청한 명언 목록입니다. 내용을 확인 후 <strong>승인</strong> 또는 <strong>삭제</strong>해주세요.
        </div>

        <div class="card shadow-sm">
            <div class="card-body p-0">
                <table class="table table-hover mb-0 text-center align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>번호</th>
                            <th>이미지</th>
                            <th class="w-25">내용</th> <!-- 내용이 길면 너비 조정 -->
                            <th>저자</th>
                            <th>카테고리</th>
                            <th>신청자</th>
                            <th>신청일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
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
                                
                                // 승인된 것만 가져옴
                                String sql = "SELECT * FROM quote WHERE status = 'PENDING' ORDER BY num ASC";
                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();
                                
                                boolean hasData = false;
                                
                                // 목록 생성
                                while(rs.next()) {
                                    hasData = true;
                                    int num = rs.getInt("num");
                                    String content = rs.getString("content");
                                    String author = rs.getString("author");
                                    String category = rs.getString("category");
                                    String nickname = rs.getString("nickname"); // 신청자 아이디랑 동일
                                    String date = rs.getString("regist_day");
                                    String img = rs.getString("img_file");
                                    
                                    // 내용이 너무 길면 자르기
                                    if(content.length() > 20) content = content.substring(0, 20) + "...";
                        %>
                        <tr>
                            <td><%= num %></td>
                            <td>
                                <% if(img != null) { %>
                                    <img src="resources/upload/<%= img %>" class="table-img">
                                <% } else { %>
                                    <span class="text-muted small">No Img</span>
                                <% } %>
                            </td>
                            <td class="text-start"><%= content %></td>
                            <td><%= author %></td>
                            <td><span class="badge bg-secondary"><%= category %></span></td>
                            <td><%= nickname %></td>
                            <td><%= date %></td>
                            <td>
                                <!-- 승인 버튼 -->
                                <a href="admin_approval_process.jsp?mode=approve&num=<%= num %>" class="btn btn-sm btn-success" onclick="return confirm('이 명언을 승인하시겠습니까?');">승인</a>
                                
                                <!-- 삭제 버튼 -->
                                <a href="admin_process.jsp?mode=delete&num=<%= num %>" class="btn btn-sm btn-danger" onclick="return confirm('정말 삭제(거절)하시겠습니까?');">삭제</a>
                            </td>
                        </tr>
                        <%
                                } // 목록 생성 종료
                                
                                if(!hasData) {
                        %>
                            <tr>
                                <td colspan="8" class="py-5 text-muted">승인 대기 중인 명언이 없습니다.</td>
                            </tr>
                        <%
                                }
                            } catch(Exception e) {
                                e.printStackTrace();
                            } finally {
                                if(rs!=null) rs.close();
                                if(pstmt!=null) pstmt.close();
                                if(conn!=null) conn.close();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>