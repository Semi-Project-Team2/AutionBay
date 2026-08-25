package com.kh.auctionBay.message.contoller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.auctionBay.message.model.dto.MessageDTO;
import com.kh.auctionBay.message.service.MessageService;
import com.kh.auctionBay.user.model.dto.UserDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/message")
public class MessageController {
	
	private final MessageService service;
	
	@GetMapping("/received")
	public String received(HttpSession session, Model model) {
		
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		
		Long myNo = loginUser.getUserNo();
		
		List<MessageDTO> messageList = service.findReceived(myNo);
		
		model.addAttribute("messageList", messageList);
		
		return "message/received";
		
	}
	
	@GetMapping("/sent")
    public String sent(HttpSession session, Model model) {

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        Long myNo = loginUser.getUserNo();

        List<MessageDTO> messageList =
                service.findSent(myNo);

        model.addAttribute("messageList", messageList);

        return "message/sent";
    }
	
	
	@GetMapping("/detail/{messageId}")
	public String detail(@PathVariable Long messageId, HttpSession session, Model model) {
		
		
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		
		Long myNo = loginUser.getUserNo();
		
		List<MessageDTO> message = service.detail(myNo, messageId);
		
		model.addAttribute("message", message);
		model.addAttribute("myNo", myNo);
		
		return "message/detail";
		
		
	}
	
	@GetMapping("/write")
	public String writeForm(@RequestParam Long productId,
							@RequestParam Long receiverNo,
							@RequestParam(required = false) String redirectURL,
							Model model) {
		
		model.addAttribute("productId", productId);
		model.addAttribute("receiverNo", receiverNo);
		model.addAttribute("redirectURL", redirectURL);
		
		return "message/write";
		
	}
	
	@PostMapping("/send")
	public String send(@RequestParam Long receiverNo, 
						@RequestParam Long productId, 
						@RequestParam String content,
						@RequestParam(required = false) String redirectURL,
						HttpSession session,
						RedirectAttributes ra) {
		
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		
		Long myNo = loginUser.getUserNo();
		
		Long newMessageId =  service.sendMessage(myNo, receiverNo, productId, content);
		
		if (redirectURL != null && !redirectURL.isBlank()) {
			ra.addFlashAttribute("message","쪽지를 보냈습니다");
			return "redirect:" + redirectURL;
		}
		
		
		return "redirect:/message/detail/" + newMessageId;
		
	}
	
	
	
	
	
	
	
}
