package com.kh.auctionBay.message.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.auctionBay.message.model.dto.MessageDTO;

@Mapper
public interface MessageMapper {

	// 받은 쪽지함
	List<MessageDTO> findReceived(Long myNo);
	
	
	// 보낸 쪽지함
	List<MessageDTO> findSent(Long myNo);
	
}
