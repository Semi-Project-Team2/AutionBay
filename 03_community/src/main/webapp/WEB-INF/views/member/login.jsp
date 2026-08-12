<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h2 class="page-title">로그인</h2>
<c:if test="${ joinSuccess != null }">
	<p class="alert alert-success">
		회원가입이 완료되었습니다. 로그인 해주세요.
	</p>
</c:if>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>