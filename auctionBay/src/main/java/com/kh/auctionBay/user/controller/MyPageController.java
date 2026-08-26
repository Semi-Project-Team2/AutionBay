package com.kh.auctionBay.user.controller;

import java.io.IOException;

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

import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.common.util.FileUploadUtil;
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
//	private final ProductService productService;
	
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
		
		return "mypage/txHistories";
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
	public String editProfile() {
		return "mypage/profile/editForm";
	}
	
	/* ----------------------------------------- */

	/**
	 * 후기 작성 폼
	 */
	@ResponseBody	// 뷰리졸버를 타지 않고 문자열을 그대로 브라우저에 보내도록 처리
	@PostMapping("/review/writeForm")
	public String writeReview(Long historyId,
			@ModelAttribute ReviewDTO review, 
			Model model, HttpSession session) 
				throws IllegalStateException, IOException {
		// 1. 로그인한 사용자 정보 가져오기
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "<script>alert('로그인이 필요합니다.'); location.href='/user/login';</script>";
		}
		
		// 2. DB에서 거래내역 조회 후 변수에 저장
		TxHistoryDTO txHistory = txService.getTxHistoryDetail(historyId);
	    if (txHistory == null) {
	        return "<script>alert('잘못된 접근입니다.'); window.close();</script>";
	    }
	    
		// 브라우저에서 "txHistory"로 요청 시 txHistory 전달
		model.addAttribute("txHistory", txHistory);
		
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
			return "<script>" +
		               "  alert('후기가 성공적으로 등록되었습니다.');" +
		               "  window.opener.location.href = '/mypage/txHistories';" +
		               // 원래 창으로 이동
		               "  window.close();" + // 팝업창 닫기
		               "</script>";
		    } else {
		        return "<script>alert('후기 등록에 실패했습니다.'); history.back();</script>";
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
	@PostMapping("/profile/editForm")
	public String editProfile(@ModelAttribute UserDTO user, HttpSession session, 
			RedirectAttributes redirectAttr)
				throws IllegalStateException, IOException {
		
		// 1. 로그인한 사용자 정보
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			return "<script>alert('로그인이 필요합니다.'); location.href='/user/login';</script>";
		}
		// 2. userNo를 로그인한 사용자의 것으로 set
		user.setUserNo(loginUser.getUserNo());
		
		// 3. UserService 호출 후 저장된 값 업데이트
		//		닉네임 중복 확인
		int result = userService.editProfile(user);
		
		System.out.println(result);
		
		// 4. 로그인한 사용자 정보를 변경된 값으로 최신화
		if (result > 0) {
			UserDTO updatedUser = userService.getUserByUserNo(loginUser.getUserNo());
			session.setAttribute(SessionConst.LOGIN_USER, updatedUser);
			
			redirectAttr.addAttribute("message", "프로필이 수정되었습니다.");
		} else {
			redirectAttr.addAttribute("message", "프로필 수정에 실패했습니다.");
		}
		
		return "redirect:/mypage/txHistories";
	}
	
	
}
