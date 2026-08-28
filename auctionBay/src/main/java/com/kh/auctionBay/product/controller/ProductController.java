package com.kh.auctionBay.product.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.dto.ProductListResult;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;
import com.kh.auctionBay.product.service.ProductService;
import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.common.SessionConst;

import jakarta.servlet.http.HttpSession;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {
	private final ProductService service;

	// 메인페이지 ( HomeController에서 리다이렉트됨)
    @GetMapping("/list")
    public String getProductList(@ModelAttribute ProductSearchCondition condition, Model model) {
        ProductListResult result = service.getProductList(condition);
        
        List<CategoryDTO> categoryList = service.findAllCategories();
        model.addAttribute("categoryList", categoryList);
        
        model.addAttribute("result", result);
        model.addAttribute("condition", condition);
        
        return "product/list"; // 메인 홈이자 상품 목록 뷰
    }
    


    @GetMapping("/write")
    public String productWrite(Model model) {
    	
    	List<CategoryDTO> categoryList = service.findAllCategories();
    	
    	model.addAttribute("categoryList", categoryList);
    	
    	return "product/productWrite";
    }
    
    @PostMapping("/write")
    public String productWrite(ProductDTO product, @RequestParam(value = "images", required = false)List<MultipartFile> images, HttpSession session) {
    	
    	UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
    	
    	if(loginUser == null) {
    		return "redirect:/user/login";
    	}
    	
    	product.setWriterNo(loginUser.getUserNo());
    	
    	service.createProduct(product, images);
    	
    	return "redirect:/product/list";
    }
    


  
}


