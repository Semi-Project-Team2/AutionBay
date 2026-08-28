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

	@Override
	@Transactional
	public void completeTrade(Long productId, Long myNo, Long opponentNo) {
		
		ProductDTO product = productMapper.selectProductById(productId);
		
		if (product == null) {
			throw new IllegalArgumentException("존재하지 않는 게시글입니다.");
		}
		
		if(!"ONGOING".equals(product.getStatus())) {
			throw new IllegalStateException("판매완료된 게시글입니다.");
		}
		
		Long sellerNo;
		Long buyerNo;
		
		if("SELL".equals(product.getTradeType())) {
			// 판매글일 경우 글쓴 사람이 판매자
			sellerNo = product.getWriterNo();
			buyerNo = myNo;
		}
		else {
			// 구매글인 경우 대화상대가 판매자
			sellerNo = opponentNo;
			buyerNo = product.getWriterNo();
		}
		
		//TODO
		// 구매자만 거래완료 가능
		if(!buyerNo.equals(myNo)) {
			throw new IllegalStateException("구매자만 거래완료 할수 있습니다.");
		}
		
		// 상품 거래 상태 변경
		productMapper.updateProductStatus(productId, "COMPLETED");
		
		
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
