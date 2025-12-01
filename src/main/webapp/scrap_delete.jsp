<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String sessionId = (String) session.getAttribute("sessionId");
    String scrapIdStr = request.getParameter("scrap_id");

    if (sessionId == null || scrapIdStr == null) {
        response.sendRedirect("main.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String url = "jdbc:mysql://localhost:3306/QuoteLibDB?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul";
        String dbId = "root";
        String dbPw = "dongha0812";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbId, dbPw);

        // 본인의 스크랩 삭제
        String sql = "DELETE FROM scrap WHERE num = ? AND member_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(scrapIdStr));
        pstmt.setString(2, sessionId);
        pstmt.executeUpdate();

        response.sendRedirect("scrap_list.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) conn.close();
    }
%>