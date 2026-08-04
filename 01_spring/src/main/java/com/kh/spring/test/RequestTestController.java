package com.kh.spring.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;

/*
 * @Controller : 요청을 받기 위한 클래스에 설정. 기본적으로 @Component 기능이 포함.
 * 
 * @Component  : 이 어노테이션이 설정된 클래스는 스프링이 생성 및 삭제 등 관리를 수행.
 * 				 스프링이 객체를 만들 클래스들을 모아놓은 목록을 Bean Factory(빈 팩토리)라고 함.
 * 				 스프링은 빈 팩토리에 등록된 클래스로만 객체를 생성해서 활용할 수 있음.
 * 				@Component 를 사용하면 해당 클래스를 빈으로 등록해서 스프링이 사용할 수 있음!
 */
@Controller
@RequestMapping("/test")	// 주소 매핑. 해당 컨트롤러의 모든 메소드 호출 시 앞에 붙는 주소.
/*
 * @ResponseBody : 메소드의 return 값을 View(화면)이 아니라
 * 				   HTTP 응답 body에 직접 텍스트로 보냄.
 * 		* @RestController = @Controller + @ResponseBody
 */
@ResponseBody
public class RequestTestController {
	// =============== 스프링의 컨트롤러에서 요청 데이터를 처리하는 방법 =================

	// * 기존 방법 HttpServletRequest 객체를 사용
	@GetMapping("/servlet-request") // => /test/servlet-request 의 get 요청을 해당 메소드로 처리
	public String servletRequestTest(HttpServletRequest req) {
		// 요청 파라미터 추출 => getParameter(키값)
		String userId = req.getParameter("userId");
		int age = Integer.parseInt( req.getParameter("age") );
		
		return "servletRequest 응답: " + userId + ", " + age;
	}
	// => localhost:8888/test/servlet-request?userId=xxx&age=xx
}










