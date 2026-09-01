package com.kh.auctionBay.user.controller;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;
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

import com.kh.auctionBay.activity.model.dto.MyCommentDTO;
import com.kh.auctionBay.activity.model.dto.RecentViewDTO;
import com.kh.auctionBay.activity.model.dto.WishlistDTO;
import com.kh.auctionBay.activity.service.ActivityService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.common.dto.ApiResponse;
import com.kh.auctionBay.common.util.FileUploadUtil;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.service.ProductService;
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
	private final FileUploadUtil fileUploadUtil;
	// service DI (생성자 주입)
	private final TxHistoryService txService;
	private final ReviewService reviewService;
	private final UserService userService;
	private final ProductService productService;
	

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
		// 거래 후기 작성여부 확인
		for (TxHistoryDTO tx : list.getTxHistories()) {
			tx.setReviewWrited(txService.checkReviewWrited(tx.getHistoryId()));
		}
		
		// 브라우저에서 "list"로 요청 시 컨트롤러 클래스에 list라고 저장된 데이터 전달
		model.addAttribute("list", list);
		// 브라우저에서 "txHistories"로 요청 시 컨트롤러 클래스에 txHistories라고 저장된 데이터를 전달
		model.addAttribute("txHistories", list.getTxHistories());
		// 검색 상태 유지를 위해 condition 저장
		model.addAttribute("condition", condition);
		// 페이지 정보 전달
		model.addAttribute("pageInfo", list.getPageInfo());
		// 현재 페이지 정보 전달
		model.addAttribute("currentPage", condition.getPage());
		// 로그인한 유저 정보 전달 (프로필 영역에 설정한 프로필 이미지 표시용)
		model.addAttribute("user", loginUser);
		
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
				@ModelAttribute SearchCondition condition,
				@RequestParam(defaultValue = "received") String tab
				/* jsp에서 tab의 기본값을 received로 지정하여 기본적으로 받은 후기탭으로 보내기 */) {
		
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
		// 로그인한 유저 정보 전달 (프로필 영역에 설정한 프로필 이미지 표시용)
		model.addAttribute("user", loginUser);
		
		// 현재 활성화된 탭 정보를 브라우저로 전달
		model.addAttribute("activeTab", tab);
		
		// 현재 클릭한 페이지 번호 전달
		model.addAttribute("currentPage", condition.getPage());
		
		return "mypage/reviews";
	}
	
	
	/**
	 * 거래내역 중 후기 작성 버튼
	 * @return
	 */
	@GetMapping("/review/writeForm")
	public String reviewForm(Long historyId, Model model) {
		TxHistoryDTO txHistory = txService.getTxHistoryDetail(historyId);
		model.addAttribute("txHistory", txHistory);
		
		return "mypage/review/writeForm";
	}
	
	/**
	 * 마이페이지 회원 정보 수정 버튼
	 * @return
	 */
	@GetMapping("/profile/editForm")
	public String editProfile(HttpSession session, Model model) {
		// 프로필 수정 페이지 진입 시 로그인된 사용자 정보 전달
		// 아래 POST 메서드에서는 변경 실패 시 미리 수정했던 부분을 전달하기 위해 GET 메서드에서
		// 따로 전달함
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		if (!model.containsAttribute("user")) {
			// 처음 진입 시 세션정보(로그인 유저) 전달
			// FlashAttribute가 전달한 값이 없으면 "user" 키에 loginUser를 담고,
			// FlashAttribute가 전달한 값이 있으면 그 값을 유지
			model.addAttribute("user", loginUser);
		}
		
		return "mypage/profile/editForm";
	}
	
	@GetMapping("/reviewForm")
	public String reviewForm() {	
		return "review/form";
	}
	
	/**
	 * 마이페이지 회원 정보 수정 버튼 클릭 시
	 * @return
	 */
	@GetMapping("/profileEditForm")
	public String editProfile() {
		return "editProfile";
	}
	
	/* ----------------------------------------- */

	/**
	 * 후기 작성 폼
	 */
	@ResponseBody	// 뷰리졸버를 타지 않고 문자열을 그대로 브라우저에 보내도록 처리
	@PostMapping("/review/writeForm")
	public ApiResponse<Void> writeReview(Long historyId, @ModelAttribute ReviewDTO review, 
			Model model, HttpSession session) 
				throws IllegalStateException, IOException {
		// 1. 로그인한 사용자 정보 가져오기
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return ApiResponse.fail("로그인이 필요합니다.");
		}
		
		// 2. DB에서 거래내역 조회 후 변수에 저장
		TxHistoryDTO txHistory = txService.getTxHistoryDetail(historyId);
	    if (txHistory == null) {
	        return ApiResponse.fail("잘못된 접근입니다.");
	    }
		
		// 3. review 객체에 누락된 필수 정보(productId 등) set
		review.setProductId(txHistory.getProductId());
		review.setReviewerNo(loginUser.getUserNo());
		
		if (loginUser.getUserNo().equals(txHistory.getBuyerNo())) {
			review.setRevieweeNo(txHistory.getSellerNo());
		} else if (loginUser.getUserNo().equals(txHistory.getSellerNo())) {
			review.setRevieweeNo(txHistory.getBuyerNo());
		}
		
		// 4. DB에 후기 저장
		int result = reviewService.writeReview(review);
		
		// 5. 후기 작성 여부 true로 변경
		txHistory.setReviewWrited(true);

		if (result > 0) {
			return ApiResponse.success("후기가 등록되었습니다.", null);
	    } else {
	        return ApiResponse.fail("후기 등록에 실패하였습니다.");
	    }
	}
	
	/**
	 * 프로필 변경 폼
	 * @param user
	 * @param session
	 * @param redirectAttr
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@ResponseBody
	@PostMapping("/profile/editForm")
	public ApiResponse<Void> editProfile(@ModelAttribute UserDTO user, 
	// 성공/실패 여부와 메시지 외에 전달할 데이터가 없기 때문에 Void
			HttpSession session, String deleteProfileImg,
			@RequestParam(required=false) MultipartFile profileImage)
				throws IllegalStateException, IOException,
				SQLIntegrityConstraintViolationException {
		
		boolean isDelete = "true".equals(deleteProfileImg);
		
		// 1. 로그인한 사용자 정보
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return ApiResponse.fail("로그인이 필요합니다.");
		}
		
		// 2. userNo를 로그인한 사용자의 것으로 set
		user.setUserNo(loginUser.getUserNo());
		
		try {
			// 3. UserService 호출 후 저장된 값 업데이트
			int result = userService.editProfile(user, profileImage, isDelete);
			
			if (result > 0) {
				// 4. 로그인한 사용자 정보를 변경된 값으로 최신화
				UserDTO updatedUser 
					= userService.getUserByUserNo(loginUser.getUserNo());
				session.setAttribute(SessionConst.LOGIN_USER, updatedUser);
				
				// message 반환 (전달할 데이터 없어서 data 부분은 null)
				return ApiResponse.success("프로필이 수정되었습니다.", null);
			} else {
				// 수정 실패 시 실패 응답 반환
				return ApiResponse.fail("프로필을 수정할 수 없습니다.");
			}
			
		} catch (RuntimeException e) {
			// 예외 발생 시 해당 예외 메시지를 담아 실패 응답 반환		
			return ApiResponse.fail(e.getMessage());
		}
	}
	
	@GetMapping("/checkNickname")
	@ResponseBody
	public ApiResponse<Boolean> checkNickname(HttpSession session, String nickname) {
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return ApiResponse.fail("로그인이 필요합니다.");
		}
		
		// 로그인한 사용자의 userNo를 서비스에 함께 전달
		boolean isDuplicate = userService.checkNickname(nickname, loginUser.getUserNo());
		
		String message = isDuplicate ? "이미 사용중인 닉네임입니다." : "사용 가능한 닉네임입니다.";
		
		return ApiResponse.success(message, isDuplicate);
	}
	
	@GetMapping("/checkPhoneNumber")
	@ResponseBody
	public ApiResponse<Boolean> checkPhoneNumber(HttpSession session, String phoneNumber) {
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return ApiResponse.fail("로그인이 필요합니다.");
		}
		// 로그인한 사용자의 userNo를 서비스에 함께 전달
		boolean isDuplicate = userService.checkPhoneNumber(phoneNumber, loginUser.getUserNo());
		
		String message = isDuplicate ? "이미 사용중인 전화번호입니다." : "사용 가능한 전화번호입니다.";
		
		return ApiResponse.success(message, isDuplicate);
	}
	
	@GetMapping("/checkEmail")
	@ResponseBody
	public ApiResponse<Boolean> checkEmail(HttpSession session, String email) {
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return ApiResponse.fail("로그인이 필요합니다.");
		}
		// 로그인한 사용자의 userNo를 서비스에 함께 전달
		boolean isDuplicate = userService.checkEmail(email, loginUser.getUserNo());
		
		String message = isDuplicate ? "이미 사용중인 이메일입니다." : "사용 가능한 이메일입니다.";
		
		return ApiResponse.success(message, isDuplicate);
	}
	
	/* ========================================================================= */
	/*   마이페이지 활동 내역 및 상품/댓글/찜 관리 컨트롤러            */
	/* ========================================================================= */
	/**
	 * [내가 작성한 게시글 목록 페이지 이동 및 데이터 조회]
	 * - 요청 URL: GET /mypage/products
	 * - 처리 과정: 
	 *    1. 세션에서 로그인된 회원 정보를 가져옵니다. 비로그인 시 로그인 페이지로 리다이렉트합니다.
	 *    2. ActivityService를 통해 현재 회원이 작성한 상품 게시글 리스트를 조회합니다.
	 *    3. 조회한 데이터를 Model에 담아 "mypage/products" 뷰로 전달합니다.
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
		// 로그인한 유저 정보 전달 (프로필 영역에 설정한 프로필 이미지 표시용)
		model.addAttribute("user", loginUser);

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
		// 로그인한 유저 정보 전달 (프로필 영역에 설정한 프로필 이미지 표시용)
		model.addAttribute("user", loginUser);
		return "mypage/comments";
	}

	/**
	 * [찜 목록 페이지 이동 및 데이터 조회]
	 * - 요청 URL: GET /mypage/wishlists
	 * - 처리 과정:
	 *    1. 로그인한 회원의 번호를 바탕으로 찜 등록한 상품 목록을 조회합니다.
	 *    2. 조회된 찜 목록 데이터를 Model에 담아 "mypage/wishlists" 뷰로 전달합니다.
	 */
	@GetMapping("/wishlists")
	public String myWishlist(HttpSession session, Model model) {
		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		List<WishlistDTO> wishlist = activityService.selectMyWishlist(loginUser.getUserNo());
		model.addAttribute("wishlist", wishlist);
		// 로그인한 유저 정보 전달 (프로필 영역에 설정한 프로필 이미지 표시용)
		model.addAttribute("user", loginUser);
		return "mypage/wishlists"; 
	}

	/**
	 * [최근 본 상품 목록 페이지 이동 및 데이터 조회]
	 * - 요청 URL: GET /mypage/recents
	 * - 처리 과정:
	 *    1. 로그인한 회원의 최근 조회 히스토리 목록을 서비스로부터 가져옵니다.
	 *    2. 조회된 최근 본 글 리스트를 Model에 담아 "mypage/recents" 뷰로 전달합니다.
	 */
	@GetMapping("/recents")
	public String recentViews(HttpSession session, Model model) {
		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		List<RecentViewDTO> recentList = activityService.selectRecentViews(loginUser.getUserNo());
		model.addAttribute("recentList", recentList);
		// 로그인한 유저 정보 전달 (프로필 영역에 설정한 프로필 이미지 표시용)
		model.addAttribute("user", loginUser);
		return "mypage/recents";
	}
	
	

	/**
	 * [내가 작성한 게시글 삭제 처리 (AJAX 비동기 통신)]
	 * - 요청 URL: DELETE /mypage/deleteProduct?productNo=상품번호
	 * - 처리 과정:
	 *    1. 비동기 요청 시 파라미터로 넘어온 상품 번호(productNo)와 로그인 유저 번호를 확인합니다.
	 *    2. 소프트 딜리트(삭제 상태값 변경) 방식을 통해 게시글 삭제 처리를 수행합니다.
	 * - 응답 데이터: 처리가 성공하면 "SUCCESS", 실패하거나 비로그인 시 "FAIL" 문자열을 반환합니다.
	 */
	@DeleteMapping("/deleteProduct") 
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
	 * - 요청 URL: DELETE /mypage/deleteComment?commentNo=댓글번호
	 * - 처리 과정:
	 *    1. 전달받은 댓글 번호와 로그인 유저 번호를 검증합니다.
	 *    2. 해당 댓글의 내용을 마스킹 처리('삭제된 댓글입니다.')하는 소프트 삭제를 수행합니다.
	 * - 응답 데이터: 성공 시 "SUCCESS", 실패 시 "FAIL" 문자열을 비동기로 반환합니다.
	 */
	@DeleteMapping("/deleteComment")
	@ResponseBody 
	public String deleteMyComment(Long commentNo, HttpSession session) {
		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "FAIL";
		}

		boolean isDeleted = activityService.deleteMyComment(commentNo, loginUser.getUserNo());
		return isDeleted ? "SUCCESS" : "FAIL";
	}
	
	/**
	 * [최근 본 글 개별 삭제 처리 (AJAX 비동기 통신)]
	 * - 요청 URL: DELETE /mypage/recents/delete
	 * - 처리 과정:
	 *    1. 전달받은 상품 번호(productNo) 누락 여부를 확인합니다. (누락 시 400 Bad Request)
	 *    2. 세션에서 로그인된 유저 정보를 확인합니다. (비로그인 시 401 Unauthorized)
	 *    3. 서비스(activityService)를 통해 해당 회원의 특정 최근 본 글 기록을 삭제합니다.
	 * - 응답 데이터: 성공 시 "SUCCESS", 실패 시 "FAIL" 혹은 에러 메시지를 ResponseEntity로 반환합니다.
	 */
	@DeleteMapping("/recents/delete")
	@ResponseBody
	public ResponseEntity<String> deleteRecentView(
			Long productNo, 
			HttpSession session) {
		
		if (productNo == null) {
			return ResponseEntity.badRequest().body("PRODUCT_NO_MISSING");
		}

		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("LOGIN_REQUIRED");
		}

		boolean result = activityService.removeRecentView(loginUser.getUserNo(), productNo);
		return result ? ResponseEntity.ok("SUCCESS") : ResponseEntity.badRequest().body("FAIL");
	}

	/**
	 * [최근 본 글 전체 삭제 처리 (AJAX 비동기 통신)]
	 * - 요청 URL: DELETE /mypage/recents/clear
	 * - 처리 과정:
	 *    1. 세션에서 로그인된 유저 정보를 확인합니다. (비로그인 시 401 Unauthorized)
	 *    2. 서비스(activityService)를 통해 해당 회원의 모든 최근 본 글 기록을 일괄 삭제합니다.
	 * - 응답 데이터: 성공 시 "SUCCESS"를 ResponseEntity로 반환합니다.
	 */
	@DeleteMapping("/recents/clear")
	@ResponseBody
	public ResponseEntity<String> clearAllRecentViews(HttpSession session) {
		UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("LOGIN_REQUIRED");
		}

		activityService.removeAllRecentViews(loginUser.getUserNo());
		return ResponseEntity.ok("SUCCESS");
	}
	
	@PostMapping("/form")
	public String editProfile(@ModelAttribute UserDTO user, HttpSession session)
				throws IllegalStateException, IOException {
		
		
		return "redirect:/mypage/txHistories";
	}
	
	
}
