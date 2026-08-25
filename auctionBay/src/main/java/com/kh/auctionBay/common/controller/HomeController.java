package com.kh.auctionBay.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.product.controller.ProductController;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;
import com.kh.auctionBay.user.model.dto.UserDTO;
import com.kh.auctionBay.user.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
public class HomeController {
	
	@GetMapping("/")
    public String home(@ModelAttribute ProductSearchCondition condition, Model model) {
        return "redirect:/product/list";
    }
	
}
