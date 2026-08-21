package com.kh.auctionBay.myPage.model.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.kh.auctionBay.myPage.model.dto.MyBoardDTO;
import com.kh.auctionBay.myPage.model.dto.MyCommentDTO;
import com.kh.auctionBay.myPage.model.dto.WishlistDTO;
import com.kh.auctionBay.myPage.model.dto.RecentViewDTO;

@Mapper
public interface MyPageMapper {

    // 1. 내가 작성한 게시글 목록
    List<MyBoardDTO> selectMyBoardList(Long userNo);

    // 2. 내가 작성한 댓글 목록
    List<MyCommentDTO> selectMyCommentList(Long userNo);

    // 3. 찜 목록
    List<WishlistDTO> selectMyWishlist(Long userNo);

    // 4. 최근 본 글 목록
    List<RecentViewDTO> selectRecentViews(Long userNo);
}