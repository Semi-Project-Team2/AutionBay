package com.kh.auctionBay.message.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.auctionBay.message.model.dto.MessageDTO;
import com.kh.auctionBay.message.model.mapper.MessageMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {
	
	private final MessageMapper mapper;

	@Override
	public List<MessageDTO> findReceived(Long myNo) {
		return mapper.findReceived(myNo);
	}

	@Override
	public List<MessageDTO> fintSent(Long myNo) {
		return mapper.findSent(myNo);
	}
	
	
	
	
}
