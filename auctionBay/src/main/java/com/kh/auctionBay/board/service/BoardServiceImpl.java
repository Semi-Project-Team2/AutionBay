package com.kh.auctionBay.board.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.board.model.dto.BoardDTO;
import com.kh.auctionBay.board.model.dto.BoardImageDTO;
import com.kh.auctionBay.board.model.dto.BoardListResult;
import com.kh.auctionBay.board.model.dto.BoardSearchCondition;
import com.kh.auctionBay.board.model.dto.CommentDTO;
import com.kh.auctionBay.board.model.mapper.BoardMapper;
import com.kh.auctionBay.common.dto.PageInfo;
import com.kh.auctionBay.common.util.FileUploadUtil;
import com.kh.auctionBay.common.util.SavedFile;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper;
	private final FileUploadUtil fileUploadUtil;
	
	@Value("${file.upload-dir.board}")
	private String boardUploadDir;

	@Override
	public BoardListResult getBoardList(BoardSearchCondition condition) {
		int totalCount = mapper.selectBoardListCount(condition);
		PageInfo pi = new PageInfo(condition.getPage(), condition.getSize(), totalCount);
		condition.setOffset(pi.getOffset());
		
		return new BoardListResult(mapper.selectBoardList(condition), pi);
	}

	@Override
	@Transactional
	public Long writeBoard(BoardDTO board, List<MultipartFile> images) throws IllegalStateException, IOException {
		mapper.insertBoard(board);
		Long boardId = board.getBoardId();
		
		saveImages(boardId, images);
		return boardId;
	}
	
	private void saveImages(Long boardId, List<MultipartFile> images) throws IllegalStateException, IOException {
		if (images == null || images.isEmpty()) {
			return;
		}
		
		int order = 0;
		for (MultipartFile file : images) {
			SavedFile saved = fileUploadUtil.save(file, boardUploadDir, "/uploads/board");
			if (saved == null) {
				continue;
			}
			
			BoardImageDTO boardImage = new BoardImageDTO(
				null,
				boardId,
				saved.getOriginalName(),
				saved.getSaveName(),
				saved.getPath(),
				order++,
				null
			);
			
			mapper.insertBoardImage(boardImage);
		}
	}

	@Override
	@Transactional
	public BoardDTO getBoardDetail(Long boardId) {
		// 1. 게시글 상세 조회
		BoardDTO board = mapper.selectBoardDetail(boardId);
		
		// 2. 첨부 이미지 목록 조회 후 세팅
		if (board != null) {
			board.setImages(mapper.selectImagesByBoardId(boardId));
		}
		
		return board;
	}

	@Override
	@Transactional
	public void updateBoard(BoardDTO board, List<MultipartFile> images) throws IllegalStateException, IOException {
	    // 1. 게시글 정보 수정 (title, content, price 등)
	    int result = mapper.updateBoard(board);

	    // 2. 새 이미지가 실제로 첨부되어 들어온 경우에만 기존 이미지 제거 후 신규 저장
	    boolean hasNewImages = false;
	    if (images != null && !images.isEmpty()) {
	        for (MultipartFile file : images) {
	            if (file != null && !file.isEmpty()) {
	                hasNewImages = true;
	                break;
	            }
	        }
	    }

	    if (hasNewImages) {
	        List<BoardImageDTO> oldImages = mapper.selectImagesByBoardId(board.getBoardId());
	        
	        // DB에서 기존 이미지 정보 삭제
	        mapper.deleteBoardImages(board.getBoardId());

	        // 서버 실물 파일 삭제
	        if (oldImages != null && !oldImages.isEmpty()) {
	            for (BoardImageDTO image : oldImages) {
	                fileUploadUtil.delete(image.getImagePath(), boardUploadDir);
	            }
	        }
	        
	        // 신규 이미지 서버 및 DB 저장
	        saveImages(board.getBoardId(), images);
	    }
	}

	@Override
	@Transactional
	public void deleteBoard(Long boardId) {
		// 삭제 전 이미지 정보 조회
		List<BoardImageDTO> images = mapper.selectImagesByBoardId(boardId);
		
		// DB에서 게시글 삭제
		mapper.deleteBoard(boardId);
		
		// 실물 파일 서버에서 삭제
		if (images != null && !images.isEmpty()) {
			for (BoardImageDTO image : images) {
				fileUploadUtil.delete(image.getImagePath(), boardUploadDir);
			}
		}
	}

	@Override
	public List<CommentDTO> getCommentList(Long boardId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public boolean checkIsLiked(Long userNo, Long productId) {
	    return mapper.checkIsLiked(userNo, productId) > 0;
	}

	@Override
	public boolean toggleWish(Long userNo, Long productId) {
		boolean isAlreadyLiked = mapper.checkIsLiked(userNo, productId) > 0;

		if (isAlreadyLiked) {
	        // 이미 찜 되어있다면 -> 삭제 (취소)
	        mapper.deleteWish(userNo, productId);
	        return false; // 최종 상태: 찜 해제됨
	    } else {
	        // 찜 안 되어있다면 -> 추가
	        mapper.insertWish(userNo, productId);
	        return true; // 최종 상태: 찜 등록됨
	    }
	}
	
}