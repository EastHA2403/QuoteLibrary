<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 파일을 저장할 서버의 실제 경로
    String savePath = request.getServletContext().getRealPath("/resources/upload");
    
    // 폴더가 없으면 새로 만듦
    File fileDir = new File(savePath);
    if (!fileDir.exists()) {
        fileDir.mkdirs();
    }

    int maxSize = 10 * 1024 * 1024;
    String encoding = "UTF-8";

    // 파일 서버에 업로드
    MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

    String category = mr.getParameter("category");
    String content = mr.getParameter("content");
    String author = mr.getParameter("author");
    
    String img_file = mr.getFilesystemName("img_file");

    String sessionId = (String) session.getAttribute("sessionId");
    String sessionRole = (String) session.getAttribute("sessionRole");
    
    // 승인 상태 결정
    String status = "PENDING";
    if ("ADMIN".equals(sessionRole)) {
        status = "APPROVED";
    }

    String regist_day = LocalDate.now().toString();

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String url = "jdbc:mysql://localhost:3306/QuoteLibDB?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul";
        String dbId = "root";
        String dbPw = "dongha0812";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbId, dbPw);

        String sql = "INSERT INTO quote (content, author, category, img_file, regist_day, status, nickname) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, content);
        pstmt.setString(2, author);
        pstmt.setString(3, category);
        pstmt.setString(4, img_file);
        pstmt.setString(5, regist_day);
        pstmt.setString(6, status);
        pstmt.setString(7, sessionId); // 신청자의 ID로 닉네임 설정

        pstmt.executeUpdate();

        // 결과 메시지
        out.println("<script>");
        if ("ADMIN".equals(sessionRole)) {
            out.println("alert('명언이 등록되었습니다.');");
        } else {
            out.println("alert('명언 등록 신청이 완료되었습니다.\\n관리자 승인 후 게시됩니다.');");
        }
        out.println("location.href='main.jsp';");
        out.println("</script>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("에러 발생: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>