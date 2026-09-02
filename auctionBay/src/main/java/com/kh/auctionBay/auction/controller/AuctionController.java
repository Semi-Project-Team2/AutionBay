package com.kh.auctionBay.auction.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.auctionBay.activity.service.ActivityService;
import com.kh.auctionBay.auction.model.dto.BidsDTO;
import com.kh.auctionBay.auction.service.AuctionService;
import com.kh.auctionBay.board.model.dto.CommentDTO;
import com.kh.auctionBay.board.service.BoardService;
import com.kh.auctionBay.board.service.CommentService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.dto.ProductMediaDTO;
import com.kh.auctionBay.product.service.ProductService;
import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.ReviewSummaryDTO;
import com.kh.auctionBay.review.model.dto.SearchCondition;
import com.kh.auctionBay.review.service.ReviewService;
import com.kh.auctionBay.user.model.dto.UserDTO;

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
	private final CommentService commentService;
	private final ActivityService activityService;


	// ------- 화면 이동 요청 ---------

	// 메인페이지에서 경매 관련 게시물을 클릭시
	@GetMapping("/{productId}/detail")
	public String auctionDetail(@PathVariable Long productId,
					HttpSession session, Model model, SearchCondition condition, RedirectAttributes rttr) {

		// 세션 영역에서 로그인된 유저 가져오기
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		// 상품정보 조회용
		ProductDTO product = productService.getProductByProductId(productId);
		
		// 삭제된 게시물 여부
    	if(product.getIsDeleted() > 0) {
			rttr.addFlashAttribute("message", "이미 삭제된 게시글입니다.");
			return "redirect:/product/list";
		}

		// 최근본글 테이블 인서트 (로그인한 회원만)
		if (loginUser != null) {
			activityService.addRecentView(loginUser.getUserNo(), productId);
		}

		// 경매 입찰 내역 조회용
		List<BidsDTO> bids = service.getBidsByProductId(productId);

		// 게시물 등록자의 받은 리뷰요약 조회용(ReviewSummaryDTO에는 reviewAvg, reviewCount 필드 저장되어있음
		ReviewSummaryDTO rs = reviewService.getAvgAndCountReview(product.getWriterNo());

		// 게시물 등록자의 받은 리뷰 보여주기용 리스트
		condition.setUserNo(product.getWriterNo());
		List<ReviewDTO> reviewList = reviewService.getReceivedReviews(condition)
									.getReviews();
		
		// 작성자인지 여부
		boolean isOwner = false;
	    if (loginUser != null && product != null) {
	        if (loginUser.getUserNo() != null && loginUser.getUserNo().equals(product.getWriterNo())) {
	        	isOwner = true;
	        }
	    }
		// 찜 여부 조회
		boolean isLiked = false;
		if(loginUser != null) {
			isLiked = boardService.checkIsLiked(loginUser.getUserNo(),productId);
		}
		
		// 댓글 목록 가져오기
		List<CommentDTO> comments = commentService.getComments(productId);
		model.addAttribute("comments", comments);
		model.addAttribute("isOwner", isOwner);
		model.addAttribute("bidCount", bids.size());
		model.addAttribute("product", product);
		model.addAttribute("bids", bids);
		model.addAttribute("reviewSummary", rs);
		model.addAttribute("isLiked", isLiked);
		model.addAttribute("reviewList", reviewList);

		// 상품 조회수 증가 처리
		productService.increaseViewCount(productId);
		
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
		
		ProductDTO product = productService.getProductByProductId(bidDTO.getProductId());
		// 입찰자가 작성자인지 체크 후 같을시 거부
		if(bidDTO.getBidderNo().equals(product.getWriterNo())) {
			rttr.addFlashAttribute("message", "서버 : 작성자는 입찰 할 수 없습니다.");
			return "redirect:/auction/"+bidDTO.getProductId()+"/detail";
		}
		
		// 삭제된 게시물 여부
    	if(product.getIsDeleted() > 0) {
			rttr.addFlashAttribute("message", "이미 삭제된 게시글입니다.");
			return "redirect:/product/list";
		}

	    // 서비스 호출 (비즈니스 로직 처리 후 결과 문자열 리턴 받기)
	    String message = service.processBid(bidDTO);

	    rttr.addFlashAttribute("message", message);

		return "redirect:/auction/"+bidDTO.getProductId()+"/detail";
	}
	
	// 게시글 수정 폼
	@GetMapping("/{productId}/update")
	public String auctionUpdateForm(@PathVariable Long productId, RedirectAttributes rttr, Model model, HttpSession session) {
		
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		if (loginUser == null) {
	        rttr.addFlashAttribute("message", "로그인 후 이용해주세요.");
	        return "redirect:/user/login";
	    }
		ProductDTO product = productService.getProductByProductId(productId);
		if(!loginUser.getUserNo().equals(product.getWriterNo())) {
			rttr.addFlashAttribute("message", "작성자만 수정할 수 있습니다.");
			return "redirect:/auction/"+productId+"/detail";
		}
		
		if(!product.getStatus().equals("ONGOING")) {
			rttr.addFlashAttribute("message", "거래완료, 마감된 상품은 수정할 수 없습니다.");
			return "redirect:/auction/"+productId+"/detail";
		}
			
		
		// 입찰이력이 존재하는 경우
		List<BidsDTO> list = service.getBidsByProductId(productId);
		if(list != null && list.size() > 0) {
			rttr.addFlashAttribute("message", "입찰이력이 존재하면 수정할 수 없습니다.");
			return "redirect:/auction/"+productId+"/detail";
		}
		
		// 입찰이력이 존재하지 않는 경우
		List<CategoryDTO> categoryList = productService.findAllCategories();
		
		model.addAttribute("product", product);
		model.addAttribute("categoryList", categoryList);
		return "auction/updateForm";
	}
	
	// 게시글 수정
	@PostMapping("{productId}/update")
	public String actionUpdate(@PathVariable Long productId, @ModelAttribute ProductDTO product, HttpSession session, RedirectAttributes rttr,
								@RequestParam(required=false) List<MultipartFile> images, String deletedMediaIds) {
		
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		if (loginUser == null) {
	        rttr.addFlashAttribute("message", "로그인 후 이용해주세요.");
	        return "redirect:/user/login";
	    }
		
		if(!loginUser.getUserNo().equals(product.getWriterNo())) {
			rttr.addFlashAttribute("message", "작성자만 수정할 수 있습니다.");
			return "redirect:/auction/"+productId+"/detail";
		}
		ProductDTO originalProduct = productService.getProductByProductId(productId);
		if(!originalProduct.getStatus().equals("ONGOING")) {
			rttr.addFlashAttribute("message", "거래완료, 마감된 상품은 수정할 수 없습니다.");
			return "redirect:/auction/"+productId+"/detail";
		}
		
		// 입찰이력이 존재하는 경우
		List<BidsDTO> list = service.getBidsByProductId(productId);
		if(list != null && list.size() > 0) {
			rttr.addFlashAttribute("message", "입찰이력이 존재하면 수정할 수 없습니다.");
			return "redirect:/auction/"+productId+"/detail";
		}
		// 상품 ID 설정 (경로 변수값을 DTO에 확실하게 주입)
	    product.setProductId(productId);
	    
	    try {
	        // 서비스 레이어로 위임
	        productService.updateProduct(product, images, deletedMediaIds);
	        rttr.addFlashAttribute("message", "경매 게시글이 성공적으로 수정되었습니다.");
	    } catch (Exception e) {
	        e.printStackTrace();
	        rttr.addFlashAttribute("message", "게시글 수정 중 오류가 발생했습니다.");
	        return "redirect:/auction/" + productId + "/update";
	    }
		
		return "redirect:/auction/"+productId+"/detail";
	}

}