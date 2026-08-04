package com.kh.spring.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/test")
public class ResponseTestController {
	// ============= 응답 방식 ====================
	
	/*
	 * @ResponseBody : 화면(View) 없이 결과를 바로 텍스트로 응답
	 */
	@ResponseBody
	@GetMapping		// => /test
	public String responseBodyTest() {
		return "결과를 텍스트로 응답!";
	}
	
	// 기본적으로 forward 방식으로 응답 처리됨!
	@GetMapping("/index")		// => /test/index
	public String responseIndex() {
		
		// prefix, suffix
		// {prefix}리턴값{suffix}
		// => /WEB-INF/views/페이지경로.jsp 이 파일을 ViewResolver 가 매칭시켜 응답해줄 것임!
		// return "포워드처리할페이지경로";
		return "test/index";  // => /WEB-INF/views/test/index.jsp
	}
}




