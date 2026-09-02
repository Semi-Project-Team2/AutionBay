package com.kh.auctionBay.message.contoller;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.message.service.MessageService;
import com.kh.auctionBay.user.model.dto.UserDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
/**
 * 안 읽은 쪽지 개수 비동기 처리를 위한 ApiController
 */
@RestController
@RequestMapping("/message")
@RequiredArgsConstructor
public class MessageApiController {
	private final MessageService messageService;
	
	@GetMapping("/unread-count")
	public ResponseEntity<Integer> getUnreadCount(HttpSession session) {
		UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		if (loginUser == null) {
			// build(): HTTP 응답에 추가로 담을 body가 없을 때 응답 객체를
			//		최종적으로 완성(조립)하여 반환하는 메서드
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}
		
		int unreadCount = messageService.getUnreadCount(loginUser.getUserNo());
		
		loginUser.setUnreadCount(unreadCount);
		session.setAttribute(SessionConst.LOGIN_USER, loginUser);
		
		return ResponseEntity.ok(unreadCount);
	}

}
