package com.kh.auctionBay.auction.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.auctionBay.auction.model.dto.BidsDTO;
import com.kh.auctionBay.auction.service.AuctionService;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.service.ProductService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/auction")
@RequiredArgsConstructor
public class AuctionController {

	private final AuctionService service;
	private final ProductService productService;
	
	@GetMapping("/{productId}/detail")
	public String auctionDetail(@PathVariable Long productId, HttpSession session, Model model) {
		
		List<BidsDTO> bids = service.getBidsByProductId(productId);
		ProductDTO product = productService.getProductByProductId(productId);
		
		model.addAttribute("product", product);
		model.addAttribute("bids", bids);
		
		return "auction/detail";
	}
}
