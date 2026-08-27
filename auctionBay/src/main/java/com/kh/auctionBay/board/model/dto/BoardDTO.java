package com.kh.auctionBay.board.model.dto;

import java.time.LocalDateTime;
import java.util.List;

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
public class BoardDTO {
    private Long boardId;
    private String title;
    private String content;
    private int price;
    private Long writerNo;
    private String memberId;
    
    private String nickname; 
    
    private int readCount;
    private LocalDateTime createDate;
    
    // 첨부 이미지 목록
    private List<BoardImageDTO> images;
   
}