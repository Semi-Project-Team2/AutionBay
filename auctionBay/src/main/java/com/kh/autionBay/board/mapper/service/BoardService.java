package com.kh.autionBay.board.mapper.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.autionBay.board.dto.BoardDTO;

public interface BoardService {

	// 1. 게시글 목록 조회
	List<BoardDTO> getBoardList();

	// 2. 게시글 작성
	Long writeBoard(BoardDTO board, List<MultipartFile> images) throws IllegalStateException, IOException;

	// 3. 게시글 상세 조회
	BoardDTO getBoardDetail(Long boardId);

	// 4. 게시글 삭제
	void deleteBoard(Long boardId);

	void updateBoard(BoardDTO board, List<MultipartFile> images);

}