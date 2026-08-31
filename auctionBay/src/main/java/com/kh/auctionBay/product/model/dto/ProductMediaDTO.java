package com.kh.auctionBay.product.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProductMediaDTO {

	private Long mediaId;
	private Long productId;
	private String mediaType;
	private String mediaUrl;
	private String thumbnailUrl;
	private Long mediaOrder;

}
