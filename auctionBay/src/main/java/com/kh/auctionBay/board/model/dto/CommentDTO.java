package com.kh.auctionBay.board.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CommentDTO {
	
	
	private Long commentId;
	private Long productId;
	private Long writerNo;
	private Long paredtNo;
	private String content;
	private LocalDateTime createAt;
	
	private String writerNickname; // 작성자 닉네임
	private String createAtStr;    // 날짜 포맷팅 문자열
}