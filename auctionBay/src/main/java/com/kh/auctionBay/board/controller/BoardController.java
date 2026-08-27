package com.kh.auctionBay.board.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.board.model.dto.BoardDTO;
import com.kh.auctionBay.board.model.dto.BoardListResult;
import com.kh.auctionBay.board.model.dto.BoardSearchCondition;
import com.kh.auctionBay.board.model.dto.CommentDTO;
import com.kh.auctionBay.board.service.BoardService;
import com.kh.auctionBay.board.service.CommentService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.service.ProductService;
import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.ReviewSummaryDTO;
import com.kh.auctionBay.review.model.dto.SearchCondition;
import com.kh.auctionBay.review.service.ReviewService;
import com.kh.auctionBay.user.model.dto.UserDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
    
    private final BoardService service;
    private final CommentService commentService;
    private final ReviewService reviewService;
    private final ProductService productService;
    
    // ------- 게시글 목록 ---------
    @GetMapping("/list")
    public String boardList(@ModelAttribute BoardSearchCondition condition, Model model) {
        BoardListResult result = service.getBoardList(condition);
        model.addAttribute("boardList", result.getBoardList());
        model.addAttribute("pageInfo", result.getPageInfo());
        model.addAttribute("condition", condition);
    
        return "board/list";
    }
    
    // ------- 게시글 작성 ---------
    @GetMapping("/write")
    public String writeForm() {
        return "board/form";
    }
    
    @PostMapping("/write")
    public String write(@ModelAttribute BoardDTO board,
                        @RequestParam(value="imageFiles", required=false) List<MultipartFile> images,
                        HttpSession session) throws IllegalStateException, IOException {
        UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
        if (loginUser != null) {
            board.setMemberId(loginUser.getUserId());
        }
        
        service.writeBoard(board, images);
        return "redirect:/board/list";
    }
    
    // ------- 게시글 상세 조회 ---------
    @GetMapping("/{productId}/detail")
    public String boardDetail(@PathVariable Long productId, Model model, HttpSession session,SearchCondition condition) {

    	// 상품정보 조회용
    	ProductDTO product = productService.getProductByProductId(productId);
        
        // 2. 댓글 목록 가져오기
        List<CommentDTO> comments = commentService.getComments(productId);
        model.addAttribute("comments", comments);
        
        // 3. 로그인 회원 작성자 여부 체크 (getMemberId 사용)
        UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
        
        boolean isOwner = false;
        if (loginUser != null && product != null) {
            if (loginUser.getUserId() != null && loginUser.getUserId().equals(product.getWriterNo())) {
                isOwner = true;
            }
        }
        // 게시물 등록자의 받은 리뷰요약 조회용(ReviewSummaryDTO에는 reviewAvg, reviewCount 필드 저장되어있음
 		ReviewSummaryDTO rs = reviewService.getAvgAndCountReview(product.getWriterNo());
 		
 		// 게시물 등록자의 받은 리뷰 보여주기용 리스트
 		condition.setUserNo(product.getWriterNo());
 		List<ReviewDTO> reviewList = reviewService.getReceivedReviews(condition)
 									.getReviews();
 		

		// 찜 여부 조회
    	boolean isLiked = false;
		if(loginUser != null) {
			isLiked = service.checkIsLiked(loginUser.getUserNo(),productId);
		}
		
		model.addAttribute("product", product);
		model.addAttribute("isOwner", isOwner);
		model.addAttribute("isLiked", isLiked);
		model.addAttribute("reviewSummary", rs);
		model.addAttribute("reviewList", reviewList);
		
		return "board/detail";
		

    }
    
//    // ------- 게시글 수정 화면 이동 ---------
//    @GetMapping("/update/{boardId}")
//    public String updateForm(@PathVariable("boardId") Long boardId, Model model, HttpSession session) {
//        // 게시글 상세 조회
//        BoardDTO board = boardService.getBoardDetail(boardId);
//        UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
//
//        // 2. 비로그인 사용자 처리
//        if (loginUser == null) {
//            return "redirect:/login";
//        }
//
//        // 3. 작성자 본인 확인 (본인이 아니면 상세 페이지로)
//        if (board == null || !loginUser.getUserId().equals(board.getMemberId())) {
//            return "redirect:/board/" + boardId + "/detail";
//        }
//
//        // 4. Model에 데이터 담고 수정 폼 이동
//        model.addAttribute("board", board);
//        return "board/updateForm";
//    }
//
//    // ------- 게시글 수정 처리 ---------
//    @PostMapping("/update/{boardId}")
//    public String update(@PathVariable("boardId") Long boardId,
//                         @ModelAttribute BoardDTO board,
//                         @RequestParam(value="imageFiles", required=false) List<MultipartFile> images,
//                         HttpSession session) throws IllegalStateException, IOException {
//
//        UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
//        BoardDTO originalBoard = boardService.getBoardDetail(boardId);
//
//        // POST 요청 검증
//        if (loginUser == null || originalBoard == null || !loginUser.getUserId().equals(originalBoard.getMemberId())) {
//            return "redirect:/board/" + boardId + "/detail";
//        }
//
//        board.setBoardId(boardId);
//        board.setMemberId(loginUser.getUserId());
//        board.setWriterNo(loginUser.getUserNo());
//
//        // 인터페이스의 updateBoard 호출
//        boardService.updateBoard(board, images);
//        return "redirect:/board/" + boardId + "/detail";
//    }
//
//    // ------- 게시글 삭제 ---------
//    @PostMapping("/delete/{boardId}")
//    public String delete(@PathVariable("boardId") Long boardId, HttpSession session) {
//        UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
//        BoardDTO board = boardService.getBoardDetail(boardId);
//
//        // 삭제 전 권한 검증
//        if (loginUser == null || board == null || !loginUser.getUserId().equals(board.getMemberId())) {
//            return "redirect:/board/" + boardId + "/detail";
//        }
//
//        // 인터페이스의 deleteBoard 호출
//        boardService.deleteBoard(boardId);
//        return "redirect:/board/list";
//    }
}
