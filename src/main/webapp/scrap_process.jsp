<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%
    String sessionId = (String) session.getAttribute("sessionId");
    if (sessionId == null) {
        out.println("<script>alert('로그인이 필요한 기능입니다.'); location.href='login.jsp';</script>");
        return;
    }

    String quoteNumStr = request.getParameter("num");
    if (quoteNumStr == null) {
        response.sendRedirect("main.jsp");
        return;
    }
    int quoteNum = Integer.parseInt(quoteNumStr);

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String url = "jdbc:mysql://localhost:3306/QuoteLibDB?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul";
        String dbId = "root";
        String dbPw = "dongha0812";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbId, dbPw);

        // 이미 스크랩했는지 중복 검사
        String checkSql = "SELECT * FROM scrap WHERE member_id = ? AND quote_num = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, sessionId);
        pstmt.setInt(2, quoteNum);
        rs = pstmt.executeQuery();

        // 이미 존재할 때
        if (rs.next()) {
            out.println("<script>");
            out.println("alert('이미 스크랩한 명언입니다.');");
            out.println("history.back();");
            out.println("</script>");
        } else {
            // pstmt 재사용
            pstmt.close(); 
            
            String insertSql = "INSERT INTO scrap (member_id, quote_num, regist_day) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, sessionId);
            pstmt.setInt(2, quoteNum);
            pstmt.setString(3, LocalDate.now().toString());
            pstmt.executeUpdate();

            out.println("<script>");
            out.println("if(confirm('스크랩 완료! 나의 스크랩 목록으로 이동할까요?')) {");
            out.println("   location.href='scrap_list.jsp';");
            out.println("} else {");
            out.println("   history.back();");
            out.println("}");
            out.println("</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생'); history.back();</script>");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>