package com.kh.auctionBay.review.model.dto;

import java.util.List;

import com.kh.auctionBay.common.dto.PageInfo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TxHistoryResultList {
	private List<TxHistoryDTO> txHistories;
	private PageInfo pageInfo;
}
