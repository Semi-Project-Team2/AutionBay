package com.kh.auctionBay.product.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductListResult;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;
import com.kh.auctionBay.product.service.ProductService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {
	private final ProductService service;

	// 메인페이지 ( HomeController에서 이 메소드를 호출해서 url링크가 없으면 이 메소드가 호출됨)
    @GetMapping("/list")
    public String getProductList(@ModelAttribute ProductSearchCondition condition, Model model) {
        ProductListResult result = service.getProductList(condition);
        
        List<CategoryDTO> categoryList = service.findAllCategories();
        model.addAttribute("categoryList", categoryList);
        
        model.addAttribute("result", result);
        model.addAttribute("condition", condition);
        
        return "product/list"; // 메인 홈이자 상품 목록 뷰
    }
}
