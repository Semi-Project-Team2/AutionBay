<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2 class="page-title">게시판</h2>
	
	<c:choose>
		<c:when test="${empty boardList}">
			<p>등록된 게시글이 없습니다.</p>
		</c:when>
		<c:otherwise>
			<div class="board-table-wrap">
				<table class="board-table">
					<thead>
					    <tr>
					        <th class="board-table_col-no">번호</th>
					        <th class="board-table_col-category">카테고리</th>
					        <th class="board-table_col-title">제목</th>
					        <th class="board-table_col-writer">작성자</th>
					        <th class="board-table_col-date">작성일</th>
					        <th class="board-table_col-count">조회수</th>
					    </tr>
					 </thead>
					 <tbody>
						<c:forEach var="board" items="${boardList}" varStatus="status">
							<tr>
								<td class="board-table_col-no">번호</td>
								<td class="board-table_col-category">카테고리</td>
								<td class="board-table_col-title">제목</td>
								<td class="board-table_col-writer">작성자</td>
								<td class="board-table_col-date">작성일</td>
								<td class="board-table_col-count">조회수</td>								
							</tr>
						</c:forEach>
					 </tbody>
				</table>
			</div>
		</c:otherwise>	
	</c:choose>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>





