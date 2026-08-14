package com.kh.community.board.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.community.board.model.dto.BoardDTO;
import com.kh.community.board.model.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper;

	@Override
	public List<BoardDTO> getBoardList() {
		return mapper.selectBoardList();
	}

	@Override
	public int writeBoard(BoardDTO board, List<MultipartFile> images) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public BoardDTO getBoardDetail(Long boardId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
