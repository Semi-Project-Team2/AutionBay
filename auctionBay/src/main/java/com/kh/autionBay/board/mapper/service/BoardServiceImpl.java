package com.kh.autionBay.board.mapper.service;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.autionBay.board.dto.BoardDTO;
import com.kh.autionBay.board.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;

/*
 * "게시판" 비즈니스 로직 처리를 담당하는 서비스 구현체
 */
@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper;

	// 1. 게시글 목록 조회
	@Override
	public List<BoardDTO> getBoardList() {
		return mapper.selectBoardList();
	}

	@Override
	public Long writeBoard(BoardDTO board, List<MultipartFile> images) throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardDTO getBoardDetail(Long boardId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteBoard(Long boardId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateBoard(BoardDTO board, List<MultipartFile> images) {
		// TODO Auto-generated method stub
		
	}

	// 2. 게시글 작성
	

	// 3. 게시글 상세 조회
	
	// 4. 게시글 삭제
	
}