package com.kh.auctionBay.message.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.message.model.dto.MessageDTO;
import com.kh.auctionBay.message.model.mapper.MessageMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {
	
	private final MessageMapper mapper;

	@Override
	public List<MessageDTO> findReceived(Long myNo) {
		return mapper.findReceived(myNo);
	}

	@Override
	public List<MessageDTO> findSent(Long myNo) {
		return mapper.findSent(myNo);
	}

	@Override
	public List<MessageDTO> detail(Long myNo, Long messageId) {
		
		MessageDTO message = mapper.findById(messageId);
		
		// 상품이랑 상대방 조회
		Long productId = message.getProductId();
		Long opponentNo = message.getSenderNo().equals(myNo)
						?message.getReceiverNo():message.getSenderNo();	
		
		// 쪽지 읽음 처리
		mapper.markAsRead(myNo, opponentNo, productId);
		
		// 전체 대화 조회
		return mapper.findAllMessage(myNo, opponentNo, productId);
		
	}

	@Override
	public Long sendMessage(Long senderNo, Long receiverNo, Long productId, String content) {
		
		MessageDTO message = new MessageDTO();
		
		message.setSenderNo(senderNo);
		message.setReceiverNo(receiverNo);
		message.setProductId(productId);
		message.setContent(content);
		
		mapper.insertMessage(message);
		
		return message.getMessageId();
		
	}
	
	
	
	
	
	
	
}
