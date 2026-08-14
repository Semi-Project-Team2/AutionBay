package com.kh.community.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {
	// ------- 화면 이동 요청 ---------
	@GetMapping("/list")
	public String boardList() {
		return "board/list";
	}
	
	// -----------------------------
}
