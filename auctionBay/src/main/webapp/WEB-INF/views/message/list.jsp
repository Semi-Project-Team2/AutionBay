<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="message-list">
    <c:choose>
        <c:when test="${not empty messageList}">
            <c:forEach var="m" items="${messageList}">
                <a class="message-item ${m.isRead == 0 ? 'unread' : ''}"
                   href="${pageContext.request.contextPath}/message/detail/${m.messageId}">

                    <div class="message-item-top">
                        <span class="message-opponent">
                            <c:if test="${m.isRead == 0}"><span class="unread-dot"></span></c:if>
                            ${m.opponentNickname}
                        </span>
                        <span class="message-product">${m.productTitle}</span>
                    </div>

                    <div class="message-item-bottom">
                        <span class="message-content">${m.content}</span>
                        <span class="message-date">${m.createdAt}</span>
                    </div>

                </a>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="message-empty">
                <c:choose>
                    <c:when test="${boxType == 'sent'}">보낸 쪽지가 없습니다.</c:when>
                    <c:otherwise>받은 쪽지가 없습니다.</c:otherwise>
                </c:choose>
            </div>
        </c:otherwise>
    </c:choose>
</div>