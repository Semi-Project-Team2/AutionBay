package com.kh.community.member.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.kh.community.member.model.dto.MemberDTO;

@Mapper
public interface MemberMapper {

	// 회원 가입 -> 데이터를 추가
	int insertMember(MemberDTO member);
	
}
