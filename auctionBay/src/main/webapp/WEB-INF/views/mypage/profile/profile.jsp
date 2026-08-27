<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="/css/join.css">

<div class="profile-area">
    <div class="profile-info">
        <div class="profile-preview-wrap">
            <img id="profile-preview" class="profile-preview"
                alt="프로필 미리보기"
                src="${empty user.profileImg ? 
                    pageContext.request.contextPath.concat('/uploads/profile/default-profile.png')
                    : pageContext.request.contextPath.concat(user.profileImg)}">
        </div>

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
