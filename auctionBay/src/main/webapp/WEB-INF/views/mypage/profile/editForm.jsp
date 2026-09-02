<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AuctionBay - 회원 정보 수정</title>
    <link rel="stylesheet" href="/css/mypage/common.css">
    <link rel="stylesheet" href="/css/join.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="mypage-container">
    <div class="edit-profile-card">
        <h2 class="page-title">회원 정보 수정</h2>

        <c:if test="${message != null}">
            <script>alert("${message}");</script>
        </c:if>
        <c:if test="${uploadError != null}">
            <script>
                window.addEventListener("DOMContentLoaded", function() {
                    alert("${uploadError}");
                });
            </script>
        </c:if>

        <form id="edit-form" action="${pageContext.request.contextPath}/mypage/profile/editForm" method="post" enctype="multipart/form-data">
            <%-- 프로필 사진 삭제 여부 --%>
            <input type="hidden" id="deleteProfileImg" name="deleteProfileImg" value="false">
            
            <%-- 프로필 이미지 업로드 영역 --%>
            <div class="profile-section">
                <div class="profile-preview-wrap">
                    <img id="profile-preview" class="profile-preview" alt="프로필 미리보기"
                         src="${empty user.profileImg ? 
                              pageContext.request.contextPath.concat('/uploads/profile/default-profile.png')
                              : pageContext.request.contextPath.concat(user.profileImg)}">
                </div>
                <div class="profile-buttons">
                    <label class="file-label-btn">
                        이미지 변경
                        <input type="file" id="profile-image" name="profileImage" accept="image/*" style="display: none;">
                    </label>
                    <button type="button" id="reset-profile-btn" class="file-label-btn file-label-btn-danger">
                        이미지 삭제
                    </button>
                </div>
            </div>

            <%-- 닉네임 --%>
            <div class="edit-form-group">
                <label for="nickname">닉네임</label>
                <div class="input-with-btn">
                    <input type="text" name="nickname" id="nickname" class="edit-input" required value="${user.nickname}">
                    <button type="button" id="check-nickname-btn" class="check-btn">중복확인</button>
                </div>
                <p id="check-nickname-result" class="form-tip"></p>
            </div>

            <%-- 이메일 --%>
            <div class="edit-form-group">
                <label for="email">이메일</label>
                <div class="input-with-btn">
                    <input type="email" name="email" id="email" class="edit-input" required value="${user.email}">
                    <button type="button" id="check-email-btn" class="check-btn">중복확인</button>
                </div>
                <p id="check-email-result" class="form-tip"></p>
            </div>

            <%-- 연락처 --%>
            <div class="edit-form-group">
                <label for="phoneNumber">연락처</label>
                <div class="input-with-btn">
                    <input type="text" name="phoneNumber" id="phoneNumber" class="edit-input" required value="${user.phoneNumber}">
                    <button type="button" id="check-phoneNumber-btn" class="check-btn">중복확인</button>
                </div>
                <p id="check-phoneNumber-result" class="form-tip"></p>
            </div>

            <%-- 주소 --%>
            <div class="edit-form-group">
                <label for="regionAddress">주소</label>
                <input type="text" name="regionAddress" id="regionAddress" class="edit-input" value="${user.regionAddress}">
            </div>

            <%-- 버튼 그룹 --%>
            <div class="edit-btn-group">
                <a href="javascript:history.back()" class="edit-cancel-btn">취소</a>
                <button type="submit" class="edit-submit-btn">수정 완료</button>
            </div>
        </form>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script src="${pageContext.request.contextPath}/js/profile.js"></script>
</body>
</html>