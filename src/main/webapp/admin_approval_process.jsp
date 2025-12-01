<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String sessionRole = (String) session.getAttribute("sessionRole");
    if (sessionRole == null || !"ADMIN".equals(sessionRole)) {
        out.println("<script>alert('권한이 없습니다.'); history.back();</script>");
        return;
    }

    String mode = request.getParameter("mode"); // approve 또는 delete
    String numStr = request.getParameter("num");
    
    if (numStr == null || mode == null) {
        response.sendRedirect("admin_approval.jsp");
        return;
    }
    
    int num = Integer.parseInt(numStr);

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String url = "jdbc:mysql://localhost:3306/QuoteLibDB?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul";
        String dbId = "root";
        String dbPw = "dongha0812";
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbId, dbPw);

        String sql = "";
        String msg = "";

        if ("approve".equals(mode)) {
            // [승인] 버튼 클릭 시 -> status를 APPROVED로 변경
            sql = "UPDATE quote SET status = 'APPROVED' WHERE num = ?";
            msg = "승인이 완료되었습니다. 목록에 게시됩니다.";
        } else if ("delete".equals(mode)) {
            // [삭제] 버튼 클릭 시 -> DB에서 데이터 삭제
            sql = "DELETE FROM quote WHERE num = ?";
            msg = "해당 신청이 삭제(거절)되었습니다.";
        }

        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, num);
        pstmt.executeUpdate();

        out.println("<script>");
        out.println("alert('" + msg + "');");
        out.println("location.href='admin_approval.jsp';");
        out.println("</script>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('처리 중 오류 발생'); history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>