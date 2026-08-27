<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
	
<link rel="stylesheet" href="/css/join.css">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<h2 class="page-title">회원 정보 수정</h2>

			<c:if test="${ message != null }">
				
				<script>alert("${ message }")</script>
				
			</c:if>


		<form id="join-form" class="form form-flex"
			action="${pageContext.request.contextPath}/mypage/profile/editForm"
			method="post"
			enctype="multipart/form-data">
			<div class="form-row form-row-center">
				<div class="profile-preview-wrap">
					<!-- 1. 사진이 없을 때 보여줄 '사진없음' 박스 -->
					<div id="profile-preview-placeholder"
					class="profile-preivew profile-preview-placeholder"
					style="display: ${not empty user.profileImg ? 'none' : 'flex'};">
						사진없음
					</div>

					<!-- 2. 프로필 사진이 있을 때만 이미지 태그를 보여주고 src에 경로 삽입 -->
					 <img id="profile-preview"
					 class="profile-preview" alt="프로필 미리보기"
					 src="${pageContext.request.contextPath}${user.profileImg}" 
					 style="display: ${empty user.profileImg ? 'none' : 'block'};">
				</div>
					<label class="file-label">
						프로필 이미지 선택
						<input type="file" id="profile-image" name="profileImage" accept="image/*">
					</label>
			</div>

			<div class="form-row">
				<label>닉네임</label>
				<input type="text" name="nickname" required value="${user.nickname}">
			</div>

			<div class="form-row">
				<label>이메일</label>
				<input type="email" name="email" required value="${user.email}">
			</div>

			<div class="form-row">
				<label>연락처</label>
				<input type="text" name="phoneNumber" required value="${user.phoneNumber}">
			</div>

			<div class="form-row">
				<label>주소</label>
				<input type="text" name="regionAddress" required value="${user.regionAddress}">
			</div>


			<div class="form-row">
				<button type="submit" class="btn btn-primary">수정 완료</button>
			</div>

		</form>

		<script src="/js/user.js"></script>
		<script>
			document.addEventListener('DOMContentLoaded', function() {
				const profileImg = document.querySelector("#profile-image");
				
				if (profileImg) { // 요소가 존재할 때만 실행되도록 안전장치 추가
					profileImg.addEventListener('change', function(e) {
						const file = e.target.files[0];
						if (!file) return;
						
						const reader = new FileReader();
						reader.onload = function(e) {
							const profilePreview = document.querySelector("#profile-preview");
							const placeholder = document.querySelector("#profile-preview-placeholder");
							
							if (profilePreview) {
								profilePreview.src = e.target.result;
								profilePreview.style.display = "block";
							}
							if (placeholder) {
								placeholder.style.display = "none";
							}
						}
						reader.readAsDataURL(file);
					});
				}
			});
		</script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>