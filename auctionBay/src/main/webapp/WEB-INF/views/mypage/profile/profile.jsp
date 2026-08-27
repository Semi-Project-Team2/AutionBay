<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="/css/join.css">

<div class="profile-area">
    <div class="profile-info">
        <!-- 프로필 이미지가 없을 때 보여줄 기본 영역 -->
        <div class="profile-img"
            style="display: ${not empty sessionScope.loginUser.profileImg ? 'none' : 'flex'};">
            사진없음
        </div>

        <!-- 프로필 이미지가 있을 때 보여줄 이미지 태그 -->
        <img id="profile-preview"
            class="profile-preview" alt="프로필 미리보기"
            src="${pageContext.request.contextPath}${sessionScope.loginUser.profileImg}"
            style="display: ${empty sessionScope.loginUser.profileImg ? 'none' : 'blcok'};">

        <div class="profile-text">
            <h2>${sessionScope.loginUser.nickname}님</h2>
            <p>${sessionScope.loginUser.email}</p>
        </div>
    </div>
    <div class="profile-right">
        <a href="${pageContext.request.contextPath}/mypage/profile/editForm" class="btn-edit">회원 정보 수정</a>
        <a href="${pageContext.request.contextPath}/user/withdraw" class="btn-withdraw">회원 탈퇴</a>
    </div>
</div>

		<script>
			document.addEventListener('DOMContentLoaded', function() {
                // 1. 현재 페이지에 프로필 이미지 인풋이 있는지 먼저 검사합니다.
                const profileImg = document.querySelector("#profile-image");
                
                // 2. 인풋창이 존재할 때만 아래 코드를 실행합니다. (마이페이지 메인에서는 에러 안 나고 그냥 조용히 넘어감)
                if (profileImg) {
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