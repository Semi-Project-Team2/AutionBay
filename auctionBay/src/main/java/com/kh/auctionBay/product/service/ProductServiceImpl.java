package com.kh.auctionBay.product.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.auctionBay.common.dto.PageInfo;
import com.kh.auctionBay.common.util.FileUploadUtil;
import com.kh.auctionBay.common.util.SavedFile;
import com.kh.auctionBay.product.model.dto.CategoryDTO;
import com.kh.auctionBay.product.model.dto.ProductDTO;
import com.kh.auctionBay.product.model.dto.ProductListResult;
import com.kh.auctionBay.product.model.dto.ProductMediaDTO;
import com.kh.auctionBay.product.model.dto.ProductSearchCondition;
import com.kh.auctionBay.product.model.mapper.ProductMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService{

	private final ProductMapper mapper;
	
	private final FileUploadUtil fileUploadUtil;

	@Value("${file.upload-dir.product}")
	private String productUploadDir;
	
	// productId로 ProductDTO 1개 조회
	@Override
	public ProductDTO getProductByProductId(Long productId) {
		// 상품 기본 정보 조회
		ProductDTO product = mapper.selectProductById(productId);
		
		if (product != null) {
	        // 상품 미디어 목록 조회 후 세팅
	        List<ProductMediaDTO> mediaList = mapper.getMediaListByProductId(productId);
	        product.setMediaList(mediaList);
	    }
		return product;
	}

	@Override
	public ProductListResult getProductList(ProductSearchCondition condition) {
		// 검색 조건에 일치하는 전체 상품 개수 조회 (count 쿼리)
        int totalCount = mapper.selectProductCount(condition);
        
        // PageInfo 객체 생성 (검색 조건과 전체 개수를 전달하여 페이징 계산)
        PageInfo pageInfo = new PageInfo(condition.getPage(),condition.getSize(), totalCount);
        
        
        condition.setOffset(pageInfo.getOffset());
        
        // 조건에 맞는 상품 목록 조회
        List<ProductDTO> productList = mapper.selectProductList(condition);
        
        if (productList != null && !productList.isEmpty()) {
            for (ProductDTO product : productList) {
                List<ProductMediaDTO> mediaList = mapper.getMediaListByProductId(product.getProductId());
                product.setMediaList(mediaList);
            }
        }
        
        // 조회된 목록과 페이징 정보를 ProductListResult에 담아서 반환
        return new ProductListResult(productList, pageInfo);
	}

	// 전체 카테고리 조회
	@Override
	public List<CategoryDTO> findAllCategories() {
		return mapper.selectCategories();
	}

	@Override
	public void increaseViewCount(Long productId) {
		mapper.updateViewCount(productId);
	}
	
	
	@Override
	@Transactional
	public int createProduct(ProductDTO product, List<MultipartFile> images)
	        throws IOException {

	    String tradeType = product.getTradeType();


	    // =========================
	    // 거래 방식 처리
	    // =========================

	    if ("BUY".equals(tradeType)) {

	        product.setAuctionStartPrice(null);
	        product.setAuctionEndTime(null);

	    }

	    else if ("SELL".equals(tradeType)) {

	        product.setAuctionStartPrice(null);
	        product.setAuctionEndTime(null);

	    }

	    else if ("AUCTION".equals(tradeType)) {

	        product.setPrice(product.getAuctionStartPrice());

	    }

	    else {

	        throw new IllegalArgumentException(
	            "잘못된 거래 방식입니다."
	        );
	    }


	    // =========================
	    // 기본값
	    // =========================

	    product.setStatus("ONGOING");
	    product.setViewCount(0L);


	    // =========================
	    // 상품 등록
	    // =========================

	    int result = mapper.insertProduct(product);


	    if (result == 0) {
	        throw new IllegalStateException(
	            "상품 등록에 실패했습니다."
	        );
	    }


	    // =========================
	    // 생성된 상품 번호
	    // =========================

	    Long productId = product.getProductId();


	    if (productId == null) {

	        throw new IllegalStateException(
	            "상품 번호를 가져오지 못했습니다."
	        );
	    }


	    // =========================
	    // 이미지 / 동영상 저장
	    // =========================

	    if (images == null || images.isEmpty()) {
	        return result;
	    }


	    int order = 1;
	    String defaultVideoThumbnail = "/uploads/product/common/default_thumb.png";

	    for (MultipartFile file : images) {

	        if (file == null || file.isEmpty()) {
	            continue;
	        }
	        
	        // 최대 5개
	        if (order > 5) {
	            break;
	        }

	        
	        // =========================
	        // 이미지 / 동영상 구분
	        // =========================

	        String contentType = file.getContentType();

	        String mediaType;


	        if (contentType != null
	                && contentType.startsWith("image/")) {

	            mediaType = "IMAGE";

	        }

	        else if (contentType != null
	                && contentType.startsWith("video/")) {

	            mediaType = "VIDEO";

	        }

	        else {

	            throw new IllegalArgumentException(
	                "이미지 또는 동영상 파일만 등록할 수 있습니다."
	            );
	        }


	        // =========================
	        // 실제 파일 저장
	        // =========================

	        SavedFile saved =
	            fileUploadUtil.save(
	                file,
	                productUploadDir,
	                "/uploads/product"
	            );


	        if (saved == null) {
	            continue;
	        }


	        // =========================
	        // PRODUCT_MEDIA DTO 생성
	        // =========================

	        ProductMediaDTO media =
	            new ProductMediaDTO();

	        media.setProductId(productId);

	        media.setMediaType(mediaType);

	        media.setMediaUrl(saved.getPath());

	        

	        media.setMediaOrder((long) order);

	        // =========================
	        // order가 1인 경우 썸네일 처리
	        // =========================
	        if (order == 1) {
	            if ("IMAGE".equals(mediaType)) {
	                // 첫 번째 미디어가 이미지면 썸네일 URL에 이미지 경로 저장
	                media.setThumbnailUrl(saved.getPath());
	            } else {
	                // 첫 번째 미디어가 동상이면 기본 썸네일 저장
	                media.setThumbnailUrl(defaultVideoThumbnail);
	            }
	        } else {
	            // 1번 순서가 아니면 썸네일은 null 처리
	            media.setThumbnailUrl(null);
	        }

	        // =========================
	        // PRODUCT_MEDIA 저장
	        // =========================

	        mapper.insertProductMedia(media);


	        order++;
	    }


	    return result;
	}
	
	@Override
	public List<ProductDTO> getProductList(){
		return mapper.selectProuctList();
	}
	
	@Override
	public List<ProductDTO> getProductByPrice(Long minPrice, Long maxPrice){
		return mapper.selectProductByPrice(minPrice, maxPrice);
	}
	
	@Override
    @Transactional
    public void updateProduct(ProductDTO product, List<MultipartFile> images, String deletedMediaIds) {
        
        // 1. 상품 기본 정보(제목, 가격, 설명 등) 업데이트
        if(product.getTradeType().equals("AUCTION"))
            mapper.updateAuctionProduct(product);
        else
            mapper.updateNormalProduct(product);
        
        // 2. 삭제된 기존 미디어가 있는 경우 처리
        if (deletedMediaIds != null && !deletedMediaIds.trim().isEmpty()) {
            String[] idArr = deletedMediaIds.split(",");
            for (String idStr : idArr) {
                Long mediaId = Long.parseLong(idStr.trim());
                
                ProductMediaDTO media = mapper.getMediaByMediaId(mediaId);
                if (media != null && media.getMediaUrl() != null) {
                    fileUploadUtil.delete(media.getMediaUrl(), productUploadDir);
                }
                
                mapper.deleteProductMedia(mediaId);
            }
        }
        
        // 3. 새로 추가된 미디어가 있는 경우 파일 업로드 및 DB 저장
        if (images != null && !images.isEmpty()) {
            
            // 👉 [핵심 수정] 현재 이 상품에 남아있는 미디어의 최대 순서(MAX_ORDER)를 가져옵니다. 
            // (만약 아직 미디어가 없다면 0을 반환하도록 쿼리나 자바에서 처리)
            Integer maxOrder = mapper.getMaxMediaOrderByProductId(product.getProductId());
            int order = (maxOrder != null) ? maxOrder + 1 : 1; 
            
            String defaultVideoThumbnail = "/uploads/product/common/default_thumb.png";
            for (MultipartFile file : images) {
                if (file == null || file.isEmpty()) {
                    continue;
                }
                
                String contentType = file.getContentType();
                String mediaType;
                
                if (contentType != null && contentType.startsWith("image/")) {
                    mediaType = "IMAGE";
                } else if (contentType != null && contentType.startsWith("video/")) {
                    mediaType = "VIDEO";
                } else {
                    throw new IllegalArgumentException("이미지 또는 동영상 파일만 등록할 수 있습니다.");
                }
                
                try {
                    SavedFile savedFile = fileUploadUtil.save(
                        file, 
                        productUploadDir, 
                        "/uploads/product"
                    );
                
                    if (savedFile != null) {
                        ProductMediaDTO mediaDTO = new ProductMediaDTO();
                        mediaDTO.setProductId(product.getProductId());
                        mediaDTO.setMediaUrl(savedFile.getPath());
                        mediaDTO.setMediaType(mediaType);
                        mediaDTO.setMediaOrder((long) order); 
                        
                        // 👉 [핵심 수정] 기존에 이미지가 전혀 없는 상태에서 새로 추가하는 첫 번째 파일(order == 1)일 때만 썸네일 부여
                        if (order == 1) {
                            if ("IMAGE".equals(mediaType)) {
                                mediaDTO.setThumbnailUrl(savedFile.getPath());
                            } else {
                                mediaDTO.setThumbnailUrl(defaultVideoThumbnail);
                            }
                        } else {
                            mediaDTO.setThumbnailUrl(null);
                        }
                        
                        mapper.insertProductMedia(mediaDTO);
                        order++; // 다음 파일은 순서를 1씩 증가
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.", e);
                }
            }
        }
    }

	@Override
	public String deleteProduct(Long productId) {
		int result = mapper.deleteProduct(productId);
		if(result > 0) {
			List<ProductMediaDTO> MediaList = mapper.selectMediaListByProductId(productId);
			for (ProductMediaDTO media : MediaList) {
	            
	            // DB에서 미디어 정보 조회 후 실제 물리 파일 삭제
	            if (media != null && media.getMediaUrl() != null) {
	                fileUploadUtil.delete(media.getMediaUrl(), productUploadDir);
	            }
	            
	            // DB에서 미디어 레코드 삭제
	            mapper.deleteProductMedia(media.getMediaId());
	        }
			return "성공적으로 삭제하였습니다.";
		}
		else
			return "삭제과정에서 오류가 발생하였습니다.";
	}
}
