package com.kh.auctionBay.auction.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.auction.model.dto.BidsDTO;

@Service
public interface AuctionService {
	List<BidsDTO> getBidsByProductId(Long productId);
}
