package com.kh.auctionBay.activity.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MyCommentDTO {
	private Long commentNo;             // 댓글 ID
	private Long productNo;             // 원본 게시글 ID
	private Long writerNo;              // 댓글 작성자 ID
	private Long parentNo;              // 부모 댓글 ID (대댓글용)
	private String content;             // 댓글 내용
	private LocalDateTime createdAt;    // 작성 일시
	
	// 화면 표시용 가공 필드
	private String createdAtStr;        // 작성일시 포맷팅 (YYYY-MM-DD HH:mm)
	private String productTitle;        // 원본 게시글 제목 (PRODUCTS JOIN)
}
