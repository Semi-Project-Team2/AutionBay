package com.kh.auctionBay.product.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.auctionBay.auction.model.dto.BidsDTO;
import com.kh.auctionBay.auction.service.AuctionService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.dto.ProductListResult;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;
import com.kh.auctionBay.product.service.ProductService;
import com.kh.auctionBay.user.model.dto.UserDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {
	private final ProductService service;
	private final AuctionService auctionService;
	private String type_status;

	// 메인페이지 ( HomeController에서 리다이렉트됨)
    @GetMapping("/list")
    public String getProductList(@ModelAttribute ProductSearchCondition condition, Model model) {
        ProductListResult result = service.getProductList(condition);
        
        for(ProductDTO product : result.getProductList()) {
        	
        	String tradeType = productTradeType(product);
        	
            if("COMPLETED".equals(product.getStatus())) {
            	
            	type_status = tradeType + " 완료";
            }
            else {
            	type_status = tradeType;
            }
            product.setTypeStatus(type_status);
        }
        
        
        List<CategoryDTO> categoryList = service.findAllCategories();
        model.addAttribute("categoryList", categoryList);
        
        model.addAttribute("result", result);
        model.addAttribute("condition", condition);
        
        return "product/list"; // 메인 홈이자 상품 목록 뷰
    }
    
    private String productTradeType(ProductDTO product) {
    	String result = "";
    	if("SELL".equals(product.getTradeType())) {
    		result = "판매";
    	}
    	else if("BUY".equals(product.getTradeType())) {
    		result = "구매";
    	}
    	else if("AUCTION".equals(product.getTradeType())) {
    		result = "경매";
    	}
    	return result;
    }


    @GetMapping("/write")
    public String productWrite(Model model, HttpSession session) {
    	
    	UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
    	if(loginUser == null) {
    		return "redirect:/user/login";
    	}
    	
    	List<CategoryDTO> categoryList = service.findAllCategories();
    	
    	model.addAttribute("categoryList", categoryList);
    	
    	return "product/productWrite";
    }
    
    @PostMapping("/write")
    public String productWrite(ProductDTO product, @RequestParam(value = "images", required = false)List<MultipartFile> images, HttpSession session) throws IOException{
    	
    	UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
    	if(loginUser == null) {
    		return "redirect:/user/login";
    	}
    	
    	
    	product.setWriterNo(loginUser.getUserNo());
    	
    	service.createProduct(product, images);
    	
    	return "redirect:/product/list";
    }
    
    @GetMapping("/{productId}/delete")
    public String deleteProduct(@PathVariable Long productId,HttpSession session, RedirectAttributes rttr) {
    	UserDTO loginUser = (UserDTO)session.getAttribute(SessionConst.LOGIN_USER);
		
		if (loginUser == null) {
	        rttr.addFlashAttribute("message", "로그인 후 이용해주세요.");
	        return "redirect:/user/login";
	    }
		ProductDTO product = service.getProductByProductId(productId);
		
		if(!loginUser.getUserNo().equals(product.getWriterNo())) {
			rttr.addFlashAttribute("message", "작성자만 수정할 수 있습니다.");
			if(product.getTradeType().equals("AUCTION"))
				return "redirect:/auction/"+productId+"/detail";
			else
				return "redirect:/board/"+productId+"/detail";
		}
		
		// 이미 삭제된글일 경우
		if(product.getIsDeleted() > 0) {
			rttr.addFlashAttribute("message", "이미 삭제된 게시글 입니다.");
			if(product.getTradeType().equals("AUCTION"))
				return "redirect:/auction/"+productId+"/detail";
			else
				return "redirect:/board/"+productId+"/detail";
		}
		
		// 입찰이력이 존재하는 경우
		List<BidsDTO> list = auctionService.getBidsByProductId(productId);
		if(list != null && list.size() > 0) {
			rttr.addFlashAttribute("message", "입찰이력이 존재하면 삭제할 수 없습니다.");
			return "redirect:/auction/"+productId+"/detail";
		}
    	
    	String message = service.deleteProduct(productId);
    	
    	rttr.addFlashAttribute("message", message);
    	return "redirect:/product/list";
    }
    
    
    
  
}


