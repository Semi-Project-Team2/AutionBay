package com.kh.auctionBay.message.contoller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
                service.fintSent(myNo);

        model.addAttribute("messageList", messageList);

        return "message/sent";
    }
	
	
}
