package com.kh.auctionBay.common;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	/**
	 * 파일 업로드 용량 초과 예외 처리
	 * @param e
	 * @param rttr
	 * @param request
	 * @return
	 */
	@ExceptionHandler(MaxUploadSizeExceededException.class)
	public Object handleMaxSizeException(MaxUploadSizeExceededException e,
				RedirectAttributes rttr, HttpServletRequest request) {
		
		String ajaxHeader = request.getHeader("X-Requested-With");
		boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);
		
		String referer = request.getHeader("Referer");
		
		if (isAjax) {
			// 비동기 요청이라면 JSON 형태로 응답
			Map<String, Object> response = new HashMap<>();
			response.put("success", false);
			response.put("message", "업로드 가능한 파일 용량을 초과했습니다.");
			return ResponseEntity.ok(response);
		} else {
			// 일반 요청인 경우 기존 방식대로 리다이렉트 또는 에러 페이지 처리
			
			// Referer 정보가 없을 경우 메인 페이지(안전한 기본 경로)로 설정
			if (referer == null || referer.trim().isEmpty()) {
				referer = "/";
			}
			
			rttr.addFlashAttribute("uploadError", "업로드 가능한 파일 용량을 초과했습니다.");
			return "redirect:" + referer;
		}
	}

}
