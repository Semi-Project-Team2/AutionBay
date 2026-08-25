<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="boxType" value="received" scope="request" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 받은 쪽지함</title>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/message.css">
</head>
<body>

<div class="container">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="container message-container">

    <h2 class="message-title">쪽지함</h2>

    <!-- 받은함 / 보낸함 탭 -->
    <div class="message-tabs">
        <a class="tab-item active" href="${pageContext.request.contextPath}/message/received">받은 쪽지함</a>
        <a class="tab-item" href="${pageContext.request.contextPath}/message/sent">보낸 쪽지함</a>
    </div>

    <jsp:include page="/WEB-INF/views/message/list.jsp" />

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</div>
</body>
</html>