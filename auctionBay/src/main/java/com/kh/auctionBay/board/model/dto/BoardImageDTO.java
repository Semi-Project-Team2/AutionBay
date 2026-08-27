package com.kh.auctionBay.board.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BoardImageDTO {
    private Long imageId;
    private Long boardId;
    private String originalName;
    private String saveName;
    private String imagePath;
    private int imageOrder;
    private LocalDateTime createDate;
}