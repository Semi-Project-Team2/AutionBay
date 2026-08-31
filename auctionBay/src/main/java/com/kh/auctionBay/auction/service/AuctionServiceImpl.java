package com.kh.auctionBay.auction.service;

import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.auctionBay.auction.model.dto.BidsDTO;
import com.kh.auctionBay.auction.model.dto.HoldsDTO;
import com.kh.auctionBay.auction.model.mapper.AuctionMapper;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.review.model.dto.TxHistoryDTO;

import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class AuctionServiceImpl implements AuctionService{
	
	private final AuctionMapper mapper;
	
	
	// productId로 경매이력 모두 찾기
	@Override
	public List<BidsDTO> getBidsByProductId(Long productId) {
		return mapper.selectBidsByProductId(productId);
	}
	
	// 입찰 처리
	@Override
	public String processBid(BidsDTO bidDTO) {
		Long productId = bidDTO.getProductId();

	    // 1. 상품 정보 및 마감 여부 조회 (DB 기준)
		// 이 쿼리가 실행되는 순간 해당 productId와 연관된 입찰 테이블의 행들에 배타적 잠금 걸었음
		// (FOR UPDATE로 동시성 제어)
	    ProductDTO product = mapper.selectProductForBid(productId);
	    // productId, auctionStartPrice, auctionEndTime, Status , IS_CLOSED조회
	    
	    if (product == null) {
	        return "존재하지 않는 상품입니다.";
	    }

	    // 2. 상태 및 마감 시간 검증
	    // status가 'ONGOING'이 아니거나, DB 기준 이미 마감된 경우 차단
	    if (!"ONGOING".equals(product.getStatus()) || "Y".equals(product.getIsClosed())) {
	        return "이미 마감된 경매 상품입니다.";
	    }

	    // 3. 현재 최고가 조회
	    Long currentHighestPrice = mapper.getMaxBidPrice(productId);
	    if (currentHighestPrice == null) {
	        currentHighestPrice = product.getAuctionStartPrice();
	    }

	    // 4. 유효성 검증 (입찰 단위 및 최소 가격 체크)
	    Long unit = bidDTO.getBidUnit(); 
	    Long minValidBid = currentHighestPrice + unit;

	    if (bidDTO.getBidPrice() < minValidBid || (bidDTO.getBidPrice() - currentHighestPrice) % unit != 0) {
	        return "다른 사람이 먼저 입찰하여 최소 입찰가가 변경되었습니다. 다시 확인해주세요.";
	    }

	    // 5. 새로운 입찰 내역 INSERT (useGeneratedKeys로 bid_id 획득)
	    // useGeneratedKeys는 selectKey와 역할이 같음
	    // 시퀀스를 안쓰면 useGeneratedKeys를 써야함
	    int insertBidResult = mapper.insertBid(bidDTO);
	    if (insertBidResult <= 0) {
	        return "입찰 등록 중 오류가 발생했습니다.";
	    }
	    Long generatedBidId = bidDTO.getBidId(); 

	    // 6. 이전 최고 입찰자의 홀드 상태를 'OUTBID_RELEASED'로 변경
	    mapper.updateHoldToReleased(productId);
	    
	    // 7. 새로운 입찰자의 홀드 생성 ('HELD' 상태)
	    HoldsDTO newHold = new HoldsDTO();
	    newHold.setBidId(generatedBidId); // 5번에서 받아온 BID_ID의 값
	    newHold.setProductId(productId);
	    newHold.setUserNo(bidDTO.getBidderNo());
	    newHold.setHoldAmount(bidDTO.getBidPrice());
	    
	    mapper.insertAuctionHold(newHold);

	    return "성공적으로 입찰되었습니다!";
	}

	@Scheduled(fixedDelay = 30000)
	@Override
	public void checkAndCloseAuctions() {
		
		// 1. 마감 시간이 지났지만 아직 ONGOING 상태인 상품 리스트 조회
	    List<ProductDTO> expiredProducts = mapper.selectExpiredOngoingProducts();
	    System.out.println("마감시간 지난 아직 ONGOING 상품"+expiredProducts);
	    if (expiredProducts == null || expiredProducts.isEmpty()) {
	        return;
	    }

	    for (ProductDTO product : expiredProducts) {
	        Long productId = product.getProductId();

	        // 2. 해당 상품의 최고 입찰 내역 조회
	        BidsDTO highestBid = mapper.selectHighestBidByProductId(productId);
	        System.out.println("최고 입찰 내역 "+highestBid);
	        if (highestBid == null) {
	            // 입찰자가 없는 경우 (유찰)
	            mapper.updateProductExpired(productId);
	            System.out.println("경매 유찰 처리 (입찰자 없음) - 상품 ID: " + productId);
	            
	        } else {
	            // 입찰자가 존재하는 경우 (낙찰 성공)
	            
	            // 3. 상품 상태를 'EXPIRED' (마감/낙찰완료)로 변경
	            mapper.updateProductExpired(productId);

	            // 4. 최고 입찰자(낙찰자)의 홀드 상태를 'CAPTURED'(낙찰됨) 등으로 변경
	            // highestBid에 담긴 bidId를 이용해 해당 홀드 건을 업데이트합니다.
	            mapper.updateHeldToCaptured(highestBid.getBidId());
	            
	            // 5. Tx_History 테이블에 거래 내역 Insert
	            TxHistoryDTO txHistory = new TxHistoryDTO();
	            txHistory.setProductId(productId);
	            txHistory.setTradeType("AUCTION");
	            txHistory.setSellerNo(product.getWriterNo());
	            txHistory.setBuyerNo(highestBid.getBidderNo());
	            txHistory.setFinalPrice(highestBid.getBidPrice());
	            System.out.println(txHistory);
	            mapper.insertTxHistory(txHistory);
	            
	            System.out.println("경매 낙찰 완료 (홀드 상태 변경 포함) - 상품 ID: " + productId + ", 낙찰가: " + highestBid.getBidPrice());
	        }
	    }
	}
	
	

	
	

	
}
