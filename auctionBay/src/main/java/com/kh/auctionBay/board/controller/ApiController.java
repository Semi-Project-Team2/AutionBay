package com.kh.auctionBay.board.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.auctionBay.board.service.BoardService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.common.dto.ApiResponse;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.service.ProductService;
import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.wish.model.dto.WishRequest;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequestMapping("/api/board")
@RequiredArgsConstructor
@RestController // @Responsebody + @Controller
public class ApiController {
	// /api/board/wish
	// /api/board/commentAdd
	// /api/board/commentDel
	
	private final BoardService service;
	private final ProductService productService;
	
	@PostMapping("/wish")
	public ResponseEntity<ApiResponse<Boolean>> wish(@RequestBody WishRequest wishRequest, HttpSession session){
		
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if(loginUser == null)
			return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.fail("로그인이 필요합니다."));
		
		// 찜 누르는 사람과 글 작성자가 같은지 체크 후 같을시 거부
		ProductDTO product = productService.getProductByProductId(wishRequest.getProductId());
		if(product.getWriterNo().equals(loginUser.getUserNo())) 
			return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.fail("본인 게시물에는 찜을 할 수 없습니다."));
		
		try {
			boolean isLiked = service.toggleWish(loginUser.getUserNo(), wishRequest.getProductId());
			
			return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(isLiked));
		
		} catch (RuntimeException e) {
			e.printStackTrace(); // 
	        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.fail("찜 처리 중 문제가 발생했습니다. 다시 시도해주세요."));
		}
	}
}
