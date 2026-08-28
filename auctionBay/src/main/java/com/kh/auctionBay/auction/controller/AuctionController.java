package com.kh.auctionBay.auction.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.auctionBay.activity.service.ActivityService;
import com.kh.auctionBay.auction.model.dto.BidsDTO;
import com.kh.auctionBay.auction.service.AuctionService;
import com.kh.auctionBay.board.service.BoardService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.common.dto.ApiResponse;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.service.ProductService;
import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.ReviewSummaryDTO;
import com.kh.auctionBay.review.model.dto.SearchCondition;
import com.kh.auctionBay.review.service.ReviewService;
import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.wish.model.dto.WishRequest;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/auction")
@RequiredArgsConstructor
public class AuctionController {

	private final AuctionService service;
	private final ProductService productService;
	private final ReviewService reviewService;
	private final BoardService boardService;
	private final ActivityService activityService;


	// ------- 화면 이동 요청 ---------

	// 메인페이지에서 경매 관련 게시물을 클릭시
	@GetMapping("/{productId}/detail")
	public String auctionDetail(@PathVariable Long productId,
					HttpSession session, Model model, SearchCondition condition) {

		// 세션 영역에서 로그인된 유저 가져오기
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);

		// 상품 조회수 증가 처리
		productService.increaseViewCount(productId);

		// 최근본글 테이블 인서트 (로그인한 회원만)
		if (loginUser != null) {
			activityService.addRecentView(loginUser.getUserNo(), productId);
		}

		// 경매 입찰 내역 조회용
		List<BidsDTO> bids = service.getBidsByProductId(productId);

		// 상품정보 조회용
		ProductDTO product = productService.getProductByProductId(productId);

		// 게시물 등록자의 받은 리뷰요약 조회용(ReviewSummaryDTO에는 reviewAvg, reviewCount 필드 저장되어있음
		ReviewSummaryDTO rs = reviewService.getAvgAndCountReview(product.getWriterNo());

		// 게시물 등록자의 받은 리뷰 보여주기용 리스트
		condition.setUserNo(product.getWriterNo());
		List<ReviewDTO> reviewList = reviewService.getReceivedReviews(condition)
									.getReviews();

		// 찜 여부 조회
		boolean isLiked = false;
		if(loginUser != null) {
			isLiked = boardService.checkIsLiked(loginUser.getUserNo(),productId);
		}

		model.addAttribute("bidCount", bids.size());
		model.addAttribute("product", product);
		model.addAttribute("bids", bids);
		model.addAttribute("reviewSummary", rs);
		model.addAttribute("isLiked", isLiked);
		model.addAttribute("reviewList", reviewList);

		return "auction/detail";
	}


	// -----------------------------------------------
	@PostMapping("/bid")
	public String auctionBid(@ModelAttribute BidsDTO bidDTO,
			HttpSession session, RedirectAttributes rttr) {

		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
	        rttr.addFlashAttribute("message", "로그인 후 이용해주세요.");
	        return "redirect:/user/login";
	    }

		// 로그인한 유저의 UserNo 세팅
		bidDTO.setBidderNo(loginUser.getUserNo());

	    // 서비스 호출 (비즈니스 로직 처리 후 결과 문자열 리턴 받기)
	    String message = service.processBid(bidDTO);

	    rttr.addFlashAttribute("message", message);

		return "redirect:/auction/"+bidDTO.getProductId()+"/detail";
	}

}