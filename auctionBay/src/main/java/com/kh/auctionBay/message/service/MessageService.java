package com.kh.auctionBay.message.service;

import java.util.List;

import com.kh.auctionBay.message.model.dto.MessageDTO;

public interface MessageService {
	
	
	List<MessageDTO> findReceived(Long myNo);
	
	List<MessageDTO> findSent(Long myNo);
	
	// 내용 조회와 쪽지 읽음 같이 처리
	List<MessageDTO> detail(Long myNo, Long messageId);
	
	Long sendMessage(Long senderNo, Long receiverNo, Long productId, String content);
	
	
}
