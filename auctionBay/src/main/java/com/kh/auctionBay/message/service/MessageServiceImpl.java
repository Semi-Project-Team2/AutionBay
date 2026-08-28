package com.kh.auctionBay.message.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.auctionBay.message.model.dto.MessageDTO;
import com.kh.auctionBay.message.model.mapper.MessageMapper;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.mapper.ProductMapper;
import com.kh.auctionBay.review.model.dto.TxHistoryDTO;
import com.kh.auctionBay.review.model.mapper.TxHistoryMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {
	
	private final MessageMapper mapper;
	private final ProductMapper productMapper;
	private final TxHistoryMapper txMapper;
	
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
	
	// 판매자만 가능하게 
	@Override
	@Transactional
	public void acceptTrade(Long productId, Long myNo, Long opponentNo) {
	    
	    ProductDTO product = productMapper.selectProductById(productId);
	    
	    if (product == null) {
	        throw new IllegalArgumentException("존재하지 않는 게시글입니다.");
	    }
	    
	    if (!"ONGOING".equals(product.getStatus())) {
	        throw new IllegalStateException("판매중인 게시글만 예약할 수 있습니다.");
	    }
	    
	    // 판매자만 수락 가능
	    Long sellerNo;
	    if ("SELL".equals(product.getTradeType())) {
	        sellerNo = product.getWriterNo();
	    } 
	    else { // BUY 글인 경우
	        sellerNo = opponentNo; // 대화 상대가 판매자
	    }
	    
	    if (!sellerNo.equals(myNo)) {
	        throw new IllegalStateException("판매자만 거래를 수락할 수 있습니다.");
	    }
	    
	    // 예약 처리 (상대방을 예약 구매자로 지정)
	    int result = productMapper.updateToReserved(productId, opponentNo);
	    
	    if (result == 0) {
	        throw new IllegalStateException("예약 처리에 실패했습니다.");
	    }
	}

	// 예약된 구매자만 가능하게
	@Override
	@Transactional
	public void completeTrade(Long productId, Long myNo, Long opponentNo) {
		
		ProductDTO product = productMapper.selectProductById(productId);
		
		if (product == null) {
			throw new IllegalArgumentException("존재하지 않는 게시글입니다.");
		}
		
		if (!"RESERVED".equals(product.getStatus())) {
	        throw new IllegalStateException("예약된 거래만 완료할 수 있습니다.");
	    }
		
		// 예약된 구매글만 완료 가능
		if (product.getReservedUserNo() == null || !product.getReservedUserNo().equals(myNo)) {
	        throw new IllegalStateException("예약된 거래만 완료할 수 있습니다.");
	    }
		
		Long sellerNo;
		Long buyerNo = product.getReservedUserNo();
		
		if("SELL".equals(product.getTradeType())) {
			// 판매글일 경우 글쓴 사람이 판매자
			sellerNo = product.getWriterNo();
		}
		else {
			// 구매글인 경우 대화상대가 판매자
			sellerNo = opponentNo;
		}
		
		// 상품 상태 변경
	    int result = productMapper.updateToCompleted(productId);
		
	    if (result == 0) {
	    	throw new IllegalStateException("거래 완료 실패");
	    }
		
		
		
		// 거래내역 TXHISTORY에 저장
		TxHistoryDTO tx = new TxHistoryDTO();
		
		tx.setProductId(productId);
		tx.setTradeType(product.getTradeType());
		tx.setSellerNo(sellerNo);
		tx.setBuyerNo(buyerNo);
		tx.setFinalPrice(product.getPrice());
		
		txMapper.insertTxHistory(tx);
		
	}
	
	
	
	
	
	
	
}
