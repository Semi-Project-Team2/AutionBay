<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
	
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		

			<h2 class="page-title">회원 정보 수정</h2>

			<c:if test="${ error != null }">
				<p class="alert alert-error">
					${ error }
				</p>
			</c:if>




		<form id="join-form" class="form form-flex"
			action="${pageContext.request.contextPath}/mypage/profile/editForm"
			method="post"
			enctype="multipart/form-data">
			<div class="form-row form-row-center">
				<div class="profile-preview-wrap">
					<div id="profile-preview-placeholder" class="profile-preview profile-preview-placeholder">사진없음
					</div>
					<img id="profile-preview" class="profile-preview" alt="프로필 미리보기" style="display:none;">
				</div>
					<label class="file-label">
					프로필 이미지 선택
					<input type="file" id="profile-image" name="profileImage" accept="image/*">
				</label>
			</div>

			<div class="form-row">
				<label>닉네임</label>
				<input type="text" name="nickname" required value="${loginUser.nickname}">
			</div>

			<div class="form-row">
				<label>이메일</label>
				<input type="email" name="email" required value="${loginUser.email}">
			</div>

			<div class="form-row">
				<label>연락처</label>
				<input type="text" name="phoneNumber" required value="${loginUser.phoneNumber}">
			</div>

			<div class="form-row">
				<label>주소</label>
				<input type="text" name="regionAddress" required value="${loginUser.regionAddress}">
			</div>


			<div class="form-row">
				<button type="submit" class="btn btn-primary">수정 완료</button>
			</div>

		</form>

		<script src="/js/user.js"></script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>