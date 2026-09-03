<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AuctionBay - 회원가입</title>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/login_join.css">
</head>
<body>

<!-- 1. 헤더는 바깥에 독립 배치 (화면 전체 너비 사용) -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- 2. 중앙 폼 카드만 auth-card 클래스로 감싸기 -->
<main class="auth-card">

    <h2 class="page-title">회원가입</h2>

    <c:if test="${ error != null }">
        <p class="error-msg">${ error }</p>
    </c:if>
    <c:if test="${not empty uploadError}">
        <script>
            alert("${uploadError}");
        </script>
    </c:if>

    <form id="join-form" action="/user/join" method="post" enctype="multipart/form-data">
        
        <!-- 프로필 사진 영역 -->
        <div class="profile-area">
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
                <button type="button" id="reset-profile-btn" class="file-label-btn">
                    프로필 초기화
                </button>
            </div>
        </div>

        <!-- 아이디 -->
        <div class="field-row">
            <label for="user-id">아이디</label>
            <div class="input-with-btn">
                <input type="text" name="userId" id="user-id">
                <button type="button" id="check-id-btn" class="btn-sub">중복확인</button>
            </div>
            <p id="check-id-result" class="form-tip"></p>
        </div>

        <!-- 비밀번호 -->
        <div class="field-row">
            <label for="user-pwd">비밀번호</label>
            <input type="password" name="password" id="user-pwd" required>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="field-row">
            <label for="password-confirm">비밀번호 확인</label>
            <input type="password" id="password-confirm" required>
            <p id="check-pwd-result" class="form-tip"></p>
        </div>

        <!-- 닉네임 -->
        <div class="field-row">
            <label for="nickname">닉네임</label>
            <div class="input-with-btn">
                <input type="text" name="nickname" id="nickname">
                <button type="button" id="check-nickname-btn" class="btn-sub">중복확인</button>
            </div>
            <p id="check-nickname-result" class="form-tip"></p>
        </div>

        <!-- 이메일 -->
        <div class="field-row">
            <label for="email">이메일</label>
            <div class="input-with-btn">
                <input type="email" name="email" id="email">
                <button type="button" id="check-email-btn" class="btn-sub">중복확인</button>
            </div>
            <p id="check-email-result" class="form-tip"></p>
        </div>

        <!-- 연락처 -->
        <div class="field-row">
            <label for="phoneNumber">연락처</label>
            <div class="input-with-btn">
                <input type="tel" name="phoneNumber" id="phoneNumber" pattern="[0-9]*" maxlength="11" placeholder="- 제외하고 숫자만 입력">
                <button type="button" id="check-phoneNumber-btn" class="btn-sub">중복확인</button>
            </div>
            <p id="check-phoneNumber-result" class="form-tip"></p>
        </div>

        <!-- 주소 -->
        <div class="field-row">
            <label>주소</label>
            <input type="text" name="regionAddress">
        </div>

        <!-- 제출 버튼 -->
        <div class="submit-row">
            <button type="submit" class="btn-primary">가입하기</button>
        </div>

    </form>

</main>

<!-- 3. 푸터도 바깥에 독립 배치 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script src="/js/user.js"></script>
</body>
</html>