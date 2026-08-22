package com.kh.autionBay.board.controller;

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

import com.kh.autionBay.board.dto.BoardDTO;
import com.kh.autionBay.board.dto.CommentDTO;
import com.kh.autionBay.board.mapper.service.BoardService;
import com.kh.autionBay.board.mapper.service.CommentService;

import lombok.RequiredArgsConstructor;

/*
 * "게시판" 관련 화면 이동, 폼 처리 등을 담당할 컨트롤러
 */
@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService service;
	private final CommentService commentService;
	
	// ------- 화면 이동 요청 ---------
	@GetMapping("/list")
	public String boardList(Model model) {
		List<BoardDTO> boardList = service.getBoardList();
		model.addAttribute("boardList", boardList);
		return "board/list";
	}
	
	@GetMapping("/write")
	public String writeForm() {
		return "board/form";
	}
	
	@GetMapping("/detail/{boardId}")
	public String detail(@PathVariable Long boardId, Model model) {
		BoardDTO board = service.getBoardDetail(boardId);
		// TODO 오류 해결 ------------------ List<CommentDTO> comments = commentService.getComments(boardId); 
		
		model.addAttribute("board", board);
		// TODO 오류 해결 ------------------model.addAttribute("comments", comments);
		return "board/detail";
	}
	
	@GetMapping("/edit/{boardId}")
	public String editForm(@PathVariable Long boardId, Model model) {
		BoardDTO board = service.getBoardDetail(boardId);
		model.addAttribute("board", board);
		return "board/edit";
	}

	@PostMapping("/write")
	public String write(@ModelAttribute BoardDTO board,
						@RequestParam(value="imageFiles", required=false) List<MultipartFile> images) throws IllegalStateException, IOException {
		service.writeBoard(board, images);
		return "redirect:/board/list";
	}
	
	@PostMapping("/edit/{boardId}")
	public String edit(@PathVariable Long boardId,
					   @ModelAttribute BoardDTO board,
					   @RequestParam(value="imageFiles", required=false) List<MultipartFile> images) throws IllegalStateException, IOException {
		board.setBoardId(boardId);
		service.updateBoard(board, images);
		return "redirect:/board/detail/" + boardId;
	}
	
	@PostMapping("/delete/{boardId}")
	public String delete(@PathVariable Long boardId) {
		service.deleteBoard(boardId);
		return "redirect:/board/list";
	}
}