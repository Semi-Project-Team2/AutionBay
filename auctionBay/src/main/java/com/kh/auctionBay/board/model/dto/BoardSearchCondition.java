package com.kh.auctionBay.board.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardSearchCondition {
	private int page = 1;
	private int size = 10;
	private int offset = 0;
	
	private String type;
	private String keyword;
}