package com.kh.auctionBay.myPage.model.dto;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MyCommentDTO {
    private Long commentId;     // 댓글 ID
    private Long productId;     // 원본 게시글 ID
    private String productTitle;// 원본 게시글 제목
    private String content;     // 댓글 내용
    private Date createdAt;     // 댓글 작성일
}