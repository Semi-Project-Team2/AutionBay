package com.kh.community.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.community.board.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService service;
	
	// ------- 화면 이동 요청 ---------
	@GetMapping("/list")
	public String boardList(Model model) {
		
		// DB에서 데이터를 조회하여 저장
		model.addAttribute("boardList", service.getBoardList());
		
		return "board/list";
	}
	
	// -----------------------------
}
