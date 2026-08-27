package com.kh.auctionBay.board.model.dto;

import java.util.List;

import com.kh.auctionBay.common.dto.PageInfo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BoardListResult {
	private List<BoardDTO> boardList;
	private PageInfo pageInfo;
}