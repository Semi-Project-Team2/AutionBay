# 중고거래사이트

Spring / MyBatis / JSP 기반 중고 거래 세미 프로젝트입니다.
쪽지(메시지) 기능을 통해 구매자-판매자 간 거래를 유도하는 것이 핵심 기능입니다.

## 기술 스택

* Backend: Spring, MyBatis
* View: JSP
* DB: Oracle

## 주요 기능

* 상품 등록/조회
* 쪽지(1:1 문의) 기능

  * 실시간 채팅 대신 게시판 형태의 비동기 쪽지 방식
  * room 테이블 없이 product\_id + 상대방 user\_no 조합으로 대화 필터링

## ERD / 테이블

* USERS
* PRODUCTS
* MESSAGES (message\_id, sender\_no, receiver\_no, product\_id, content, is\_read, sender\_deleted, receiver\_deleted, created\_at)

  * USERS, PRODUCTS와 FK 연결

## 실행 방법

(추후 작성)

