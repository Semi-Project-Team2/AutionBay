package com.kh.auctionBay.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.auctionBay.product.controller.ProductController;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class HomeController {
	private final ProductController productController;
	
	@GetMapping("/")
    public String home(@ModelAttribute ProductSearchCondition condition, Model model) {
        return productController.getProductList(condition, model);
    }
}
