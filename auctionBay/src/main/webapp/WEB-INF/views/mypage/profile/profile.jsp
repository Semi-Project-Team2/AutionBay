<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="/css/join.css">

<div class="profile-area">
    <div class="profile-info">
        <div class="profile-preview-wrap">
            <img id="profile-preview" class="profile-preview"
                alt="프로필 미리보기"
                src="${empty sessionScope.loginUser.profileImg ? 
                    pageContext.request.contextPath.concat('/uploads/profile/default-profile.png')
                    : pageContext.request.contextPath.concat(sessionScope.loginUser.profileImg)}">
        </div>

        <div class="profile-text">
            <h2>${sessionScope.loginUser.nickname}님</h2>
            <p>${sessionScope.loginUser.email}</p>
        </div>
    </div>
    <div class="profile-right">
        <a href="${pageContext.request.contextPath}/mypage/profile/editForm" 
            class="btn-edit">회원 정보 수정</a>
        <a href="${pageContext.request.contextPath}/user/withdraw"
            class="btn-withdraw" id="btn-withdraw">회원 탈퇴</a>
    </div>
</div>

<script>
    /* 회원 탈퇴 확인 */

document.addEventListener("click", function(e) {
    const btnWithdraw = e.target.closest("#btn-withdraw");

    if (btnWithdraw) {
        e.preventDefault();
        const isWithdraw = confirm("정말 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.");

        if (isWithdraw) {
            location.href=btnWithdraw.getAttribute("href");
        } else {
            return;
        }
    }
}); 

</script>