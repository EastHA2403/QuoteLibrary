<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 파라미터로 언어 설정이 들어오면 세션에 저장
    String lang = request.getParameter("lang");
    if (lang != null && !lang.isEmpty()) {
        session.setAttribute("sessionLang", lang);
    }
    
    // 세션에 저장된 언어가 없으면 기본값 'ko'
    String sessionLang = (String) session.getAttribute("sessionLang");
    if (sessionLang == null) {
        sessionLang = "ko";
        session.setAttribute("sessionLang", "ko");
    }
%>

<fmt:setLocale value="${sessionScope.sessionLang}" scope="session" />
<fmt:setBundle basename="bundle.message" scope="session" />