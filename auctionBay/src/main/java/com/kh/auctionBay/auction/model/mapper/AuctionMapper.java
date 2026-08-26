package com.kh.auctionBay.auction.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.auction.model.dto.BidsDTO;
import com.kh.auctionBay.auction.model.dto.HoldsDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.review.model.dto.TxHistoryDTO;

@Mapper
public interface AuctionMapper {

	// productId로 해당하는 모든 경매이력 조회
	List<BidsDTO> selectBidsByProductId(Long productId);
	
	// 경매 입찰 처리용 조회 쿼리
	// FOR UPDATE를 사용하여 해당 상품의 입찰 레코드들을 행 잠금(Row Lock)
	ProductDTO selectProductForBid(Long productId);
	
	// 최고가를 조회
    Long getMaxBidPrice(Long productId);
    
    // 입찰기록 INSERT
    int insertBid(BidsDTO bidDTO);
    
    // 이전 입찰자의 상태를 HOLD 에서 OUTBID_RELEASED로 변경
    void updateHoldToReleased(Long productId);
    
    // 현재 입찰자를 HOLD상태로 추가
    void insertAuctionHold(HoldsDTO newHold);
    
    // 시간이 지났지만 아직 상태가 ONGOING인 데이터 조회
    List<ProductDTO> selectExpiredOngoingProducts();
    
    // 최고 입찰가인 입찰기록 조회
    BidsDTO selectHighestBidByProductId(Long productId);
    
    // Product 테이블 데이터 경매 마감 처리
    void updateProductExpired(Long productId);
    
    // 최고입찰가 bids 정보를 이용해 auction_holds 테이블 상태 held에서 captured로 바꾸기
    void updateHeldToCaptured(Long bidId);
    
    // TxHistory테이블에 경매내역 INSERT
    void insertTxHistory(TxHistoryDTO txHistory);
    
    // 찜 여부 조회
    int checkIsLiked(Long userNo, Long productId);
    
    void deleteWish(Long userNo, Long productId);
    
    void insertWish(Long userNo, Long productId);
    
}
