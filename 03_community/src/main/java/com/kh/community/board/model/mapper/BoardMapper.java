package com.kh.community.board.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.community.board.model.dto.BoardDTO;

@Mapper
public interface BoardMapper {
	// 게시글 목록 조회
	List<BoardDTO> selectBoardList();
}
