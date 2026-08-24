package com.kh.auctionBay.message.service;

import java.util.List;

import com.kh.auctionBay.message.model.dto.MessageDTO;

public interface MessageService {
	
	
	List<MessageDTO> findReceived(Long myNo);
	
	List<MessageDTO> fintSent(Long myNo);
	
	
}
