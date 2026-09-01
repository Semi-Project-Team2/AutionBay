package com.kh.auctionBay.message.service;

import java.util.List;

import com.kh.auctionBay.message.model.dto.MessageDTO;

import jakarta.servlet.http.HttpSession;

public interface MessageService {
	
	// 받은 메세지 조회
	List<MessageDTO> findReceived(Long myNo);
	
	// 보낸 메세지 조회
	List<MessageDTO> findSent(Long myNo);
	
	// 내용 조회와 쪽지 읽음 같이 처리
	List<MessageDTO> detail(Long myNo, Long messageId, HttpSession session);
	
	// 메세지 보내기
	Long sendMessage(Long senderNo, Long receiverNo, Long productId, String content);
	
	// 안 읽은 받은 메시지 개수
	int getUnreadCount(Long userNo);
	
	
}
