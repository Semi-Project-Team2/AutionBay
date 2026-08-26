package com.kh.auctionBay.activity.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.auctionBay.activity.model.dto.MyCommentDTO;
import com.kh.auctionBay.activity.model.dto.RecentViewDTO;
import com.kh.auctionBay.activity.model.dto.WishlistDTO;
import com.kh.auctionBay.activity.service.ActivityService;
import com.kh.auctionBay.common.SessionConst;
import com.kh.auctionBay.user.model.dto.UserDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor 
public class ActivityController {

	private final ActivityService activityService;

	/**
	 * [공통 메서드: 로그인 회원 번호 추출]
	 * - 처리 과정: HttpSession에서 팀원들과 공통으로 사용하는 SessionConst.LOGIN_USER 키를 통해 
	 *             현재 로그인된 UserDTO 객체를 꺼내옵니다.
	 * - 예외 처리: 로그인이 되어 있지 않거나 세션이 만료된 경우 테스트 및 에러 방지를 위해 1L(기본 회원 번호)을 반환합니다.
	 */
	private long getLoginUserNo(HttpSession session) {
	    UserDTO loginUser = (UserDTO) session.getAttribute(SessionConst.LOGIN_USER);
	    return (loginUser != null) ? loginUser.getUserNo() : 1L; 
	}

	

}