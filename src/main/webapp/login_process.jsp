<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/QuoteLibDB?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul";
    String dbId = "root";
    String dbPw = "dongha0812"; 

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbId, dbPw);

        // 아이디와 비밀번호가 일치하는 회원 조회
        String sql = "SELECT * FROM member WHERE id = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);	// DB에게 미완성된 쿼리를 미리 준비시킴
        pstmt.setString(1, id);			// 첫 번째 '?' 자리에 들어감
        pstmt.setString(2, password);	// 두 번째 '?' 자리에 들어감
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String name = rs.getString("name");
            String role = rs.getString("role"); // ADMIN 또는 USER

            // 세션에 정보 저장
            session.setAttribute("sessionId", id);
            session.setAttribute("sessionName", name);
            session.setAttribute("sessionRole", role); 

            // 메인 페이지로 이동
            response.sendRedirect("main.jsp");
        } else {
            // 로그인 실패
            out.println("<script>");
            out.println("alert('아이디 또는 비밀번호가 일치하지 않습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("DB 연결 오류: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>