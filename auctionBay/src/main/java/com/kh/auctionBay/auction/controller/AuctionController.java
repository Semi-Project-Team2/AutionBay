package com.kh.auctionBay.auction.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.auctionBay.auction.model.dto.BidsDTO;
import com.kh.auctionBay.auction.service.AuctionService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.service.ProductService;
import com.kh.auctionBay.user.model.dto.UserDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/auction")
@RequiredArgsConstructor
public class AuctionController {

	private final AuctionService service;
	private final ProductService productService;
	
	
	// ------- 화면 이동 요청 ---------
	
	// 메인페이지에서 경매 관련 게시물을 클릭시
	@GetMapping("/{productId}/detail")
	public String auctionDetail(@PathVariable Long productId, 
					HttpSession session, Model model) {
		
		List<BidsDTO> bids = service.getBidsByProductId(productId);
		ProductDTO product = productService.getProductByProductId(productId);
		
		model.addAttribute("bidCount", bids.size());
		model.addAttribute("product", product);
		model.addAttribute("bids", bids);
		
		return "auction/detail";
	}
	
	@PostMapping("/bid")
	public String auctionBid(@ModelAttribute BidsDTO bidDTO,
			HttpSession session, RedirectAttributes rttr) {
		
//		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_MEMBER);
//		if (loginUser == null) {
//	        rttr.addFlashAttribute("message", "로그인 후 이용해주세요.");
//	        return "redirect:/user/login";
//	    }
//
//		// 로그인한 유저의 UserNo 세팅 
//		bidDTO.setBidderNo(loginUser.getUserNo());

//		test용 코드
		UserDTO testUser = new UserDTO();
		testUser.setUserNo(9L);
		bidDTO.setBidderNo(testUser.getUserNo());
		
	    // 서비스 호출 (비즈니스 로직 처리 후 결과 문자열 리턴 받기)
	    String message = service.processBid(bidDTO);
	    
	    rttr.addFlashAttribute("message", message);
		
		return "redirect:/auction/"+bidDTO.getProductId()+"/detail";
	}
	
	
}
