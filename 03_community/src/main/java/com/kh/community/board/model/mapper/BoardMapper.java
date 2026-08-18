package com.kh.community.board.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.community.board.model.dto.BoardDTO;
import com.kh.community.board.model.dto.BoardImageDTO;

@Mapper
public interface BoardMapper {
	// 게시글 목록 조회
	List<BoardDTO> selectBoardList();
	
	// 게시글 추가 (DML)
	int insertBoard(BoardDTO board);
	
	// 게시글 이미지 추가
	int insertBoardImage(BoardImageDTO boardImage);
}
