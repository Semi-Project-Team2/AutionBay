package com.kh.auctionBay.board.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.board.model.dto.BoardDTO;
import com.kh.auctionBay.board.model.dto.BoardImageDTO;
import com.kh.auctionBay.board.model.dto.BoardSearchCondition;
import com.kh.auctionBay.board.model.dto.CommentDTO;

@Mapper
public interface BoardMapper {

    // ==================== 게시글 ====================
    // 게시글 목록 및 개수 조회
    List<BoardDTO> selectBoardList(BoardSearchCondition condition);
    
    int selectBoardListCount(BoardSearchCondition condition);
    
    // 게시글 및 이미지 등록
    int insertBoard(BoardDTO board);
    
    int insertBoardImage(BoardImageDTO boardImage);
    
    // 게시글 상세 내용 조회
    BoardDTO selectBoardDetail(Long boardId);
    
    // 찜 여부 조회
    int checkIsLiked(Long userNo, Long productId);
    // 찜 제거
    void deleteWish(Long userNo, Long productId);
    // 찜 추가
    void insertWish(Long userNo, Long productId);
    
    // 게시글 첨부 이미지 목록 
    List<BoardImageDTO> selectImagesByBoardId(Long boardId);
    
    // 게시글 및 이미지 수정 / 삭제
    int updateBoard(BoardDTO board);
    
    int deleteBoard(Long boardId);
    
    int deleteBoardImages(Long boardId);

    // ==================== 댓글 ====================
    // 댓글 목록 조회
    List<CommentDTO> selectCommentList(Long boardId);
    
    // 댓글 작성
    int insertComment(CommentDTO comment);

    // 댓글 작성자 조회 (본인 삭제 권한 검증용)
    Long getCommentWriterNo(Long commentId);

    // 댓글 삭제
    int deleteComment(Long commentId);
}