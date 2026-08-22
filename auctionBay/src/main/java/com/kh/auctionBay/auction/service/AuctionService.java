package com.kh.auctionBay.auction.service;

import java.util.List;

import com.kh.auctionBay.auction.model.dto.BidsDTO;

public interface AuctionService {
	List<BidsDTO> getBidsByProductId(Long productId);
}
