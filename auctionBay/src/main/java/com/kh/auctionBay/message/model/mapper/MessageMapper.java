package com.kh.auctionBay.message.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.auctionBay.message.model.dto.MessageDTO;

@Mapper
public interface MessageMapper {

	// 받은 쪽지함
	List<MessageDTO> findReceived(Long myNo);
	
	
	// 보낸 쪽지함
	List<MessageDTO> findSent(Long myNo);
	
	// 쪽지함 목록
	MessageDTO findById(Long messageId);
	
	// 쪽지함 전체
	List<MessageDTO> findAllMessage(@Param("myNo") Long myNo, @Param("opponentNo") Long opponentNo, @Param("productId") Long productId);
	
	// 쪽지 읽음 처리
	int markAsRead(Long myNo, Long opponentNo, Long productId);
	
	// 쪽지 저장
	int insertMessage(MessageDTO message);
	
	
}
