<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    
    String regist_day = LocalDate.now().toString();

    String url = "jdbc:mysql://localhost:3306/QuoteLibDB?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul";
    String dbId = "root";
    String dbPw = "dongha0812";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbId, dbPw);

        // 회원 정보 삽입 (role은 기본값 'USER'로 설정)
        String sql = "INSERT INTO member VALUES(?, ?, ?, 'USER', ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, password);
        pstmt.setString(3, name);
        pstmt.setString(4, regist_day);

        pstmt.executeUpdate();

        // 가입 성공 시 로그인 페이지로 이동
        out.println("<script>");
        out.println("alert('회원가입이 완료되었습니다! 로그인해주세요.');");
        out.println("location.href='login.jsp';");
        out.println("</script>");

    } catch (SQLException e) {
    	e.printStackTrace();
        out.println("<script>");
        out.println("alert('에러 발생: " + e.getMessage() + "');"); // 에러 메시지 출력
        out.println("history.back();");
        out.println("</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>