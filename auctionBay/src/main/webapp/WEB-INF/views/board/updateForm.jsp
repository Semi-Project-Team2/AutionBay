<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 수정</title>
    <link rel="stylesheet" href="/css/common.css">
    <style>
        .update-container {
            width: 600px;
            margin: 40px auto;
            background: #ffffff;
            padding: 28px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
        }

        .update-title {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 2px solid #e2e8f0;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }

        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            outline: none;
            transition: border-color 0.2s;
        }

        .form-control:focus {
            border-color: #0f172a;
        }

        textarea.form-control {
            height: 160px;
            resize: vertical;
            line-height: 1.5;
        }

        .file-input-info {
            font-size: 12px;
            color: #64748b;
            margin-top: 4px;
        }

        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 24px;
        }

        .btn-cancel {
            padding: 10px 20px;
            background-color: #f1f5f9;
            color: #334155;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }

        .btn-submit {
            padding: 10px 20px;
            background-color: #0f172a;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-submit:hover {
            background-color: #1e293b;
        }
    </style>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="update-container">
        <h2 class="update-title">게시글 수정</h2>

        <!-- 이미지 업로드가 가능하므로 enctype="multipart/form-data" 필수 -->
        <form id="updateForm" action="/board/update/${board.boardId}" method="POST" enctype="multipart/form-data">
            
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" class="form-control" value="${board.title}" required>
            </div>

            <div class="form-group">
                <label for="price">가격 (원)</label>
                <input type="number" id="price" name="price" class="form-control" value="${board.price}" required>
            </div>
			
            <div class="form-group">
                <label for="content">상품 설명</label>
                <textarea id="content" name="content" class="form-control" required>${board.content}</textarea>
            </div>

            <div class="form-group">
                <label for="imageFiles">첨부 이미지 변경</label>
                <input type="file" id="imageFiles" name="imageFiles" class="form-control" multiple accept="image/*">
                <p class="file-input-info">* 새로운 이미지를 첨부하면 기존 이미지가 대체됩니다.</p>
            </div>

            <div class="btn-group">
                <a href="/board/${board.boardId}/detail" class="btn-cancel">취소</a>
                <button type="submit" class="btn-submit">수정하기</button>
            </div>
        </form>
    </div>

    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- 폼 유효성 검사 스크립트 연결 -->
    <script src="/js/boardUpdate.js"></script>
</body>
</html>s