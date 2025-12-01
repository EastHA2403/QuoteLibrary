<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	// 관리자인지 검사
	String sessionRole = (String) session.getAttribute("sessionRole");
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>메인화면</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap"
	rel="stylesheet">

<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #212529;
	color: white;
}

h1, h2, h3, h4, strong {
	font-weight: 700;
}

.hero-section-bg {
	background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
		url('resources/img/library_bg.jpg');
	background-size: cover;
	background-position: center;
	color: white;
}

.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.card {
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.5);
}

a {
	text-decoration: none;
}
</style>
</head>
<body>
	<jsp:include page="language_setup.jsp" />
	<jsp:include page="menu.jsp" />

	<main>
		<section class="py-5 text-center container hero-section-bg">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<h1 class="fw-bold"><fmt:message key="site.intro.title"/></h1>
					<p class="lead" style="color: #e0e0e0;">
					    <fmt:message key="site.intro.desc"/>
					</p>
					<p>
					    <% if (session.getAttribute("sessionId") != null) { %>
					        <a href="quote_add.jsp" class="btn btn-primary my-2"><fmt:message key="btn.add"/></a>
					    <% } else { %>
					        <a href="javascript:alert('로그인이 필요한 기능입니다.'); location.href='login.jsp';" class="btn btn-primary my-2"><fmt:message key="btn.add"/></a>
					    <% } %>
					    
					    <a href="quote_random.jsp" class="btn btn-secondary my-2"><fmt:message key="btn.random"/></a>
					</p>
				</div>
			</div>
		</section>

		<div class="album py-5" style="background-color: #2b3035;">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 g-3">

					<div class="col">
						<div class="card shadow-sm border-0 bg-dark text-white">
							<div
								class="card-img-top d-flex align-items-center justify-content-center"
								style="height: 225px; background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('resources/img/einstein.jpg'); background-size: cover; background-position: center;">
								<h4 class="fw-bold text-white user-select-none"><fmt:message key="cat.person.title"/></h4>
							</div>
							<div class="card-body">
								<p class="card-text"><fmt:message key="cat.person.desc"/></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<a href="quote_list.jsp?category=person"
											class="btn btn-sm btn-outline-light"><fmt:message key="btn.list"/></a>
									</div>
									<small class="text-white-50">Person</small>
								</div>
							</div>
						</div>
					</div>

					<div class="col">
						<div class="card shadow-sm border-0 bg-dark text-white">
							<div
								class="card-img-top d-flex align-items-center justify-content-center"
								style="height: 225px; background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('resources/img/titanic.jpeg'); background-size: cover; background-position: center;">
								<h4 class="fw-bold text-white user-select-none"><fmt:message key="cat.movie.title"/></h4>
							</div>
							<div class="card-body">
								<p class="card-text"><fmt:message key="cat.movie.desc"/></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<a href="quote_list.jsp?category=movie"
											class="btn btn-sm btn-outline-light"><fmt:message key="btn.list"/></a>
									</div>
									<small class="text-white-50">Movie</small>
								</div>
							</div>
						</div>
					</div>

					<div class="col">
						<div class="card shadow-sm border-0 bg-dark text-white">
							<div
								class="card-img-top d-flex align-items-center justify-content-center"
								style="height: 225px; background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('resources/img/book.jpg'); background-size: cover; background-position: center;">
								<h4 class="fw-bold text-white user-select-none"><fmt:message key="cat.novel.title"/></h4>
							</div>
							<div class="card-body">
								<p class="card-text"><fmt:message key="cat.novel.desc"/></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<a href="quote_list.jsp?category=novel"
											class="btn btn-sm btn-outline-light"><fmt:message key="btn.list"/></a>
									</div>
									<small class="text-white-50">Novel</small>
								</div>
							</div>
						</div>
					</div>

					<div class="col">
						<div class="card shadow-sm border-0 bg-dark text-white">
							<div
								class="card-img-top d-flex align-items-center justify-content-center"
								style="height: 225px; background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('resources/img/anime.jpeg'); background-size: cover; background-position: center;">
								<h4 class="fw-bold text-white user-select-none"><fmt:message key="cat.virtual.title"/></h4>
							</div>
							<div class="card-body">
								<p class="card-text"><fmt:message key="cat.virtual.desc"/></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<a href="quote_list.jsp?category=virtual"
											class="btn btn-sm btn-outline-light"><fmt:message key="btn.list"/></a>
									</div>
									<small class="text-white-50">Virtual</small>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</main>

	<footer class="text-white-50 py-5">
		<div class="container">
			<p class="float-end mb-1">
				<a href="#" class="text-white">맨 위로 가기</a>
			</p>
			<p class="mb-1">QuoteLibrary &copy; JSP Project Example</p>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>