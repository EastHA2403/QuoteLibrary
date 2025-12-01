<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="language_setup.jsp" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String sessionId = (String) session.getAttribute("sessionId");
    String sessionRole = (String) session.getAttribute("sessionRole");
%>
<header>
    <div class="collapse bg-black" id="navbarHeader">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-md-7 py-4">
                    <h4 class="text-white"><fmt:message key="menu.intro"/></h4>
                    <p class="text-white-50"><fmt:message key="menu.intro.text"/></p>
                </div>
                <div class="col-sm-4 offset-md-1 py-4">
                    <h4 class="text-white">Menu</h4>
                    <ul class="list-unstyled">
                        <li class="mb-3">
                            <a href="?lang=ko" class="text-decoration-none text-white fw-bold">KO</a>
                            <span class="text-white-50 mx-1">|</span>
                            <a href="?lang=en" class="text-decoration-none text-white fw-bold">EN</a>
                        </li>

                        <% if (sessionId == null) { %>
                            <li><a href="login.jsp" class="text-white"><fmt:message key="menu.login"/></a></li>
                            <li><a href="signup.jsp" class="text-white"><fmt:message key="menu.signup"/></a></li>
                        <% } else { %>
                            <li class="text-white-50 mb-2"><%= sessionId %><fmt:message key="menu.welcome"/></li>
                            <li><a href="logout_process.jsp" class="text-white"><fmt:message key="menu.logout"/></a></li>
                            <li><a href="scrap_list.jsp" class="text-white"><fmt:message key="menu.scrap"/></a></li>

                            <% if ("ADMIN".equals(sessionRole)) { %>
                                <li><a href="quote_add.jsp" class="text-warning fw-bold">명언 등록</a></li>
                                <li><a href="admin_approval.jsp" class="text-danger fw-bold"><fmt:message key="menu.admin"/></a></li>
                            <% } %>
                        <% } %>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <div class="navbar navbar-dark bg-black shadow-sm">
        <div class="container">
            <a href="main.jsp" class="navbar-brand d-flex align-items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" aria-hidden="true" class="me-2" viewBox="0 0 24 24"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/><circle cx="12" cy="13" r="4"/></svg>
                <strong><fmt:message key="site.title"/></strong>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </div>
</header>