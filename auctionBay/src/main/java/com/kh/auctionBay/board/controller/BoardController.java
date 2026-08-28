package com.kh.auctionBay.board.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.board.model.dto.BoardDTO;
import com.kh.auctionBay.board.model.dto.BoardListResult;
import com.kh.auctionBay.board.model.dto.BoardSearchCondition;
import com.kh.auctionBay.board.model.dto.CommentDTO;
import com.kh.auctionBay.board.service.BoardService;
import com.kh.auctionBay.board.service.CommentService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.common.dto.ApiResponse;
import com.kh.auctionBay.product.model.dto.CategoryDTO;
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
      
    
    // ------- 게시글  상세 조회 ---------
    @GetMapping("/{productId}/detail")
    public String boardDetail(@PathVariable("productId") Long productId, Model model, HttpSession session, SearchCondition condition) {

    	// 1. 상품정보 조회용
    	ProductDTO product = productService.getProductByProductId(productId);
        
        // 2. 댓글 목록 가져오기 (Long 타입 productId 전달)
        List<CommentDTO> comments = commentService.getComments(productId);
    	model.addAttribute("comments", comments);
        
        // 3. 로그인 회원 작성자 여부 체크
        UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
        
        boolean isOwner = false;
        if (loginUser != null && product != null) {
            if (loginUser.getUserNo() != null && loginUser.getUserNo().equals(product.getWriterNo())) {
                isOwner = true;
            }
        }
        
        // 리뷰 정보 조회 (product가 존재할 때만 실행)
        ReviewSummaryDTO rs = null;
        List<ReviewDTO> reviewList = null;
        if (product != null && product.getWriterNo() != null) {
            rs = reviewService.getAvgAndCountReview(product.getWriterNo());
            condition.setUserNo(product.getWriterNo());
            reviewList = reviewService.getReceivedReviews(condition).getReviews();
        }
 		
		// 찜 여부 조회
    	boolean isLiked = false;
		if (loginUser != null) {
			isLiked = service.checkIsLiked(loginUser.getUserNo(), productId);
		}
		
		model.addAttribute("product", product);
		model.addAttribute("isOwner", isOwner);
		model.addAttribute("isLiked", isLiked);
		model.addAttribute("reviewSummary", rs);
		model.addAttribute("reviewList", reviewList);
		
		return "board/detail";
		
		//
    }
    
 
}