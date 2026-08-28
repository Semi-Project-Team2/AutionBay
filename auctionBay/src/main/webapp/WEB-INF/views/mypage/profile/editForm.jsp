<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 회원정보 수정</title>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/join.css">
</head>
<body>

<div class="container">

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="container">

			<h2 class="page-title">회원 정보 수정</h2>

			<c:if test="${ message != null }">
				<script>alert("${message}")</script>
			</c:if>


		<form id="edit-form" class="form form-flex" 
			action="${pageContext.request.contextPath}/mypage/profile/editForm"
			method="post" enctype="multipart/form-data">
			<%-- 프로필 사진 삭제 여부 조회 --%>
			<input type="hidden" id="deleteProfileImg" name="deleteProfileImg" value="false">
			
			<div class="form-row form-row-center">
				<div class="profile-preview-wrap">
					<img id="profile-preview" class="profile-preview"
					 	alt="프로필 미리보기"
						src="${empty user.profileImg ? 
							pageContext.request.contextPath.concat('/uploads/profile/default-profile.png')
							: pageContext.request.contextPath.concat(user.profileImg)}">
				</div>
				<div class="profile-buttons">
				    <label class="file-label">
				        프로필 이미지 선택
				        <input type="file"
				               id="profile-image"
				               name="profileImage"
				               accept="image/*">
				    </label>
				    <label id="reset-profile-btn" class="file-label">
						프로필 이미지 삭제
					</label>
				</div>
			</div>

			<div class="form-row">
				<label>닉네임</label>
				<input type="text" name="nickname" id="nickname" required value="${user.nickname}">
				<button type="button" id="check-nickname-btn">중복확인</button>
				<p id="check-nickname-result" class="form-tip"></p>
			</div>

			<div class="form-row">
				<label>이메일</label>
				<input type="email" name="email" id="email" required value="${user.email}">
				<button type="button" id="check-email-btn">중복확인</button>
				<p id="check-email-result" class="form-tip"></p>
			</div>

			<div class="form-row">
				<label>연락처</label>
				<input type="text" name="phoneNumber" id="phoneNumber" required value="${user.phoneNumber}">
				<button type="button" id="check-phoneNumber-btn">중복확인</button>
				<p id="check-phoneNumber-result" class="form-tip"></p>
			</div>

			<div class="form-row">
				<label>주소</label>
				<input type="text" name="regionAddress" value="${user.regionAddress}">
			</div>


			<div class="form-row">
				<button type="submit" class="btn btn-primary">수정 완료</button>
			</div>

		</form>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</div>

<script src="/js/profile.js"></script>
</body>
</html>