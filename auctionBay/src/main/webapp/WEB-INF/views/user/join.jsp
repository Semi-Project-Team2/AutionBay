<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 회원가입</title>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/join.css">
</head>
<body>

<div class="container">

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="container">

			<h2 class="page-title">회원가입 </h2>

			<c:if test="${ error != null }">
				<p class="alert alert-error">
					${ error }
				</p>
			</c:if>




		<form id="join-form" class="form form-flex" action="/user/join" method="post" enctype="multipart/form-data">
			<div class="form-row form-row-center">
				<div class="profile-preview-wrap">
					<img id="profile-preview"
					     class="profile-preview"
					     src="/uploads/profile/default-profile.png"
					     alt="프로필 미리보기">
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
						프로필 초기화
					</label>
				</div>
			</div>


			<div class="form-row">
				<label>아이디</label>
				<input type="text" name="userId" id="user-id">
				<button type="button" id="check-id-btn">중복확인</button>
				<p id="check-id-result" class="form-tip"></p>
			</div>

			<div class="form-row">
				<label>비밀번호</label>
				<input type="password" name="password" id="user-pwd" required>
			</div>
			<div class="form-row">
			    <label for="user-pwd">비밀번호 확인</label>
			    <input type="password" id="password-confirm" required>
				<p id="check-pwd-result" class="form-tip"></p>
			</div>

			<div class="form-row">
				<label>닉네임</label>
				<input type="text" name="nickname" id="nickname">
				<button type="button" id="check-nickname-btn">중복확인</button>
				<p id="check-nickname-result" class="form-tip"></p>
			</div>

			<div class="form-row">
				<label>이메일</label>
				<input type="email" name="email" id="email">
				<button type="button" id="check-email-btn">중복확인</button>
				<p id="check-email-result" class="form-tip"></p>
			</div>

			<div class="form-row">
				<label>연락처</label>
				<input type="tel" name="phoneNumber" id="phoneNumber" pattern="[0-9]*" maxlength="11" placeholder=" - 제외하고 숫자만 입력">
				<button type="button" id="check-phoneNumber-btn">중복확인</button>
				<p id="check-phoneNumber-result" class="form-tip"></p>
			</div>

			<div class="form-row">
				<label>주소</label>
				<input type="text" name="regionAddress" required>
			</div>


			<div class="form-row">
				<button type="submit" class="btn btn-primary">가입</button>
			</div>

		</form>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</div>

<script src="/js/user.js"></script>
</body>
</html>