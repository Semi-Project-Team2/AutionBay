package com.kh.auctionBay.user.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.auctionBay.activity.model.dto.MyCommentDTO;
import com.kh.auctionBay.activity.model.dto.RecentViewDTO;
import com.kh.auctionBay.activity.model.dto.WishlistDTO;
import com.kh.auctionBay.activity.service.ActivityService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.review.model.dto.ReviewDTO;
import com.kh.auctionBay.review.model.dto.ReviewResultList;
import com.kh.auctionBay.review.model.dto.SearchCondition;
import com.kh.auctionBay.review.model.dto.TxHistoryDTO;
import com.kh.auctionBay.review.model.dto.TxHistoryResultList;
import com.kh.auctionBay.review.service.ReviewService;
import com.kh.auctionBay.review.service.TxHistoryService;
import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.user.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class MyPageController {
	// service DI (생성자 주입)
	private final TxHistoryService txService;
	private final ReviewService reviewService;
	private final UserService userService;
//	private final ProductService productService;
	
	// 팀원 코드를 건드리지 않기 위해 맨 아래에 추가하는 내 파트용 서비스 주입
	private final ActivityService activityService;
	
	
	/* ------------- 화면 이동 요청 --------------- */
	
	/**
	 * 거래 목록 화면
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/txHistories")
	public String txHistories(HttpSession session, Model model,
				@ModelAttribute SearchCondition condition) {
		
		// 로그인한 사용자 정보를 loginUser로 백엔드에 저장
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		// 로그인 진행 X(또는 로그인 세션 만료) 시 로그인 페이지로 리다이렉트
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		// 검색 조건 중 userNo 필드에 로그인한 사용자 넘버 저장
		Long userNo = loginUser.getUserNo();
		condition.setUserNo(userNo);
		
		// DB에서 데이터 조회 후 변수에 저장
		TxHistoryResultList list = txService.getTxHistories(condition);
		
		// 브라우저에서 "list"로 요청 시 컨트롤러 클래스에 list라고 저장된 데이터 전달
		model.addAttribute("list", list);
		// 브라우저에서 "txHistories"로 요청 시 컨트롤러 클래스에 txHistories라고 저장된 데이터를 전달
		model.addAttribute("txHistories", list.getTxHistories());
		// 검색 상태 유지를 위해 condition 저장
		model.addAttribute("condition", condition);
		// 페이지 정보 저장
		model.addAttribute("pageInfo", list.getPageInfo());
		
		return "mypage/txHistories";
	}
	
	/**
	 * 거래내역 상세 화면
	 */
	@GetMapping("/txHistory/{historyId}")
	public String txHistoryDetail(@PathVariable Long historyId,	Model model) {
		
		// DB에서 거래내역 조회 후 변수에 저장
		TxHistoryDTO txHistory = txService.getTxHistoryDetail(historyId);
		
		// 브라우저에서 "txHistory"로 요청 시 txHistory 전달
		model.addAttribute("txHistory", txHistory);
		
		return "mypage/txHistory/detail";
	}
	
	/**
	 * 후기 목록 화면
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/reviews")
	public String reviews(HttpSession session, Model model,
				@ModelAttribute SearchCondition condition) {
		
		// 로그인한 사용자 정보를 loginUser로 백엔드에 저장
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		// 로그인 진행 X(또는 로그인 세션 만료) 시 로그인 페이지로 리다이렉트
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		// 검색 조건 중 userNo 필드에 로그인한 사용자 넘버 저장
		Long userNo = loginUser.getUserNo();
		condition.setUserNo(userNo);
		
		// DB에서 데이터 조회 후 변수에 저장
		ReviewResultList receivedReviews = reviewService.getReceivedReviews(condition);
		ReviewResultList sentReviews = reviewService.getSentReviews(condition);

		// 브라우저에서 "receivedReviews"로 요청 시 컨트롤러 클래스의 receivedReviews 전달
		model.addAttribute("receivedReviews", receivedReviews.getReviews());
		// 브라우저에서 "sentReviews"로 요청 시 컨트롤러 클래스의 sentReviews 전달
		model.addAttribute("sentReviews", sentReviews.getReviews());
		// 페이징 정보 저장 (받은 후기: receivedPageInfo, 보낸 후기: sentPageInfo)
		model.addAttribute("receivedPageInfo", receivedReviews.getPageInfo());
		model.addAttribute("sentPageInfo", sentReviews.getPageInfo());
		
		
		return "mypage/reviews";
	}
	
	
	/**
	 * 거래내역 중 후기 작성 버튼
	 * @return
	 */
	@GetMapping("/review/writeForm")
	public String reviewForm() {	
		return "mypage/review/writeForm";
	}
	
	/**
	 * 마이페이지 회원 정보 수정 버튼
	 * @return
	 */
	@GetMapping("/profile/editForm")
	public String editProfile() {
		return "mypage/profile/editForm";
	}
	
	/* ----------------------------------------- */

	/**
	 * 후기 작성 폼
	 */
	@PostMapping("/writeReview")
	public String writeReview(Long historyId,
			@ModelAttribute ReviewDTO review, 
			Model model, HttpSession session) 
				throws IllegalStateException, IOException {
		// MessageController에서 불러오게 될 것 같긴 함
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		// DB에서 거래내역 조회 후 변수에 저장
		TxHistoryDTO txHistory = txService.getTxHistoryDetail(historyId);
				
		// 브라우저에서 "txHistory"로 요청 시 txHistory 전달
		model.addAttribute("txHistory", txHistory);
		
		int result = reviewService.writeReview(review);
		
		return "redirect:/mypage/reviews";
	}
	
	@PostMapping("/user/edit")
	public String editProfile(@ModelAttribute UserDTO user, HttpSession session, 
			RedirectAttributes redirectAttr)
	// addFlash어쩌고(자세한 내용은 실습코드를 참조하세요 ㅋ)
				throws IllegalStateException, IOException {
		
		// 
		
		return "redirect:/mypage/txHistories";
	}
	
	/* ========================================================================= */
	/*   마이페이지 활동 내역 및 상품/댓글/찜 관리 컨트롤러            */
	/* ========================================================================= */
	/**
	 * [내가 작성한 게시글 목록 페이지 이동 및 데이터 조회]
	 * - 요청 URL: GET /mypage/boards
	 * - 처리 과정: 
	 *    1. 세션에서 로그인된 회원 정보를 가져옵니다. 비로그인 시 로그인 페이지로 리다이렉트합니다.
	 *    2. ActivityService를 통해 현재 회원이 작성한 상품 게시글 리스트를 조회합니다.
	 *    3. 조회한 데이터를 Model에 담아 "mypage/boards" 뷰로 전달합니다.
	 */
	
	@GetMapping("/products")
	public String MyProductList(String keyword, HttpSession session, Model model) {
	    UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
	    if (loginUser == null) {
	        return "redirect:/user/login";
	    }

	    List<ProductDTO> productList = activityService.selectMyProductList(loginUser.getUserNo(), keyword); 
	    model.addAttribute("productList", productList);
	    model.addAttribute("keyword", keyword);

	    return "mypage/products";
	}

	/**
	 * [내가 작성한 댓글 목록 페이지 이동 및 데이터 조회]
	 * - 요청 URL: GET /mypage/comments
	 * - 처리 과정:
	 *    1. 로그인 여부를 확인하고, 로그인된 회원의 번호로 작성한 댓글 목록을 조회합니다.
	 *    2. 조회된 댓글 리스트를 Model에 담아 "mypage/comments" 뷰로 전달합니다.
	 */
	@GetMapping("/comments")
	public String myCommentList(HttpSession session, Model model) {
		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		List<MyCommentDTO> commentList = activityService.selectMyCommentList(loginUser.getUserNo());
		model.addAttribute("commentList", commentList);
		return "mypage/comments";
	}

	/**
	 * [찜 목록 페이지 이동 및 데이터 조회]
	 * - 요청 URL: GET /mypage/wishlist
	 * - 처리 과정:
	 *    1. 로그인한 회원의 번호를 바탕으로 찜 등록한 상품 목록을 조회합니다.
	 *    2. 조회된 찜 목록 데이터를 Model에 담아 "mypage/wishlist" 뷰로 전달합니다.
	 */
	@GetMapping("/wishlists")
	public String myWishlist(HttpSession session, Model model) {
		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		List<WishlistDTO> wishlist = activityService.selectMyWishlist(loginUser.getUserNo());
		model.addAttribute("wishlist", wishlist);
		return "mypage/wishlists"; 
	}

	/**
	 * [최근 본 상품 목록 페이지 이동 및 데이터 조회]
	 * - 요청 URL: GET /mypage/recent
	 * - 처리 과정:
	 *    1. 로그인한 회원의 최근 조회 히스토리 목록을 서비스로부터 가져옵니다.
	 *    2. 조회된 최근 본 글 리스트를 Model에 담아 "mypage/recent" 뷰로 전달합니다.
	 */
	@GetMapping("/recents")
	public String recentViews(HttpSession session, Model model) {
		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		List<RecentViewDTO> recentList = activityService.selectRecentViews(loginUser.getUserNo());
		model.addAttribute("recentList", recentList);
		return "mypage/recents";
	}

	/**
	 * [내가 작성한 게시글 삭제 처리 (AJAX 비동기 통신)]
	 * - 요청 URL: GET /mypage/deleteBoard?productNo=상품번호
	 * - 처리 과정:
	 *    1. 비동기 요청 시 파라미터로 넘어온 상품 번호(productNo)와 로그인 유저 번호를 확인합니다.
	 *    2. 소프트 딜리트(삭제 상태값 변경) 방식을 통해 게시글 삭제 처리를 수행합니다.
	 * - 응답 데이터: 처리가 성공하면 "SUCCESS", 실패하거나 비로그인 시 "FAIL" 문자열을 반환합니다.
	 */
	@GetMapping("/deleteProduct")
	@ResponseBody 
	public String deleteMyProduct(Long productNo, HttpSession session) {
		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "FAIL";
		}

		boolean isDeleted = activityService.deleteMyProduct(productNo, loginUser.getUserNo());
		return isDeleted ? "SUCCESS" : "FAIL";
	}

	/**
	 * [내가 작성한 댓글 삭제 처리 (AJAX 비동기 통신)]
	 * - 요청 URL: GET /mypage/deleteComment?commentNo=댓글번호
	 * - 처리 과정:
	 *    1. 전달받은 댓글 번호와 로그인 유저 번호를 검증합니다.
	 *    2. 해당 댓글의 내용을 마스킹 처리('삭제된 댓글입니다.')하는 소프트 삭제를 수행합니다.
	 * - 응답 데이터: 성공 시 "SUCCESS", 실패 시 "FAIL" 문자열을 비동기로 반환합니다.
	 */
	@GetMapping("/deleteComment")
	@ResponseBody 
	public String deleteMyComment( Long commentNo, HttpSession session) {
		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "FAIL";
		}

		boolean isDeleted = activityService.deleteMyComment(commentNo, loginUser.getUserNo());
		return isDeleted ? "SUCCESS" : "FAIL";
	}
}