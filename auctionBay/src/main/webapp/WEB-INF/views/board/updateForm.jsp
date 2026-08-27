<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 수정</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/boardWrite.css">
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="page-container">
    <div class="form-card">
        <h2>게시글 수정</h2>

        <form action="${pageContext.request.contextPath}/board/update/${board.boardId}" method="post" enctype="multipart/form-data">
            
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="${board.title}" required />
            </div>

            <div class="form-group">
                <label for="price">판매 가격 (원)</label>
                <input type="number" id="price" name="price" value="${board.price}" required />
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" rows="10" required>${board.content}</textarea>
            </div>


            <div class="btn-group">
                <button type="submit" class="btn btn-primary">수정 완료</button>
                <a href="${pageContext.request.contextPath}/board/${board.boardId}/detail" class="btn btn-secondary">취소</a>
            </div>

        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>