package com.finalproject.firstimpression.dao;

import java.util.ArrayList;
import java.util.List;

import com.finalproject.firstimpression.model.AnoFeed;
import com.finalproject.firstimpression.model.HashTag;
import com.finalproject.firstimpression.model.LikeFeed;
import com.finalproject.firstimpression.model.MasterAnBoard;
import com.finalproject.firstimpression.model.Reply;
import com.finalproject.firstimpression.model.Report;
import com.finalproject.firstimpression.model.ShowCondition;

public interface AnoFeedDao {
	
	List<MasterAnBoard> selectMpList();

	int insertFeed(AnoFeed anoFeed);

	AnoFeed selectFeed(AnoFeed anoFeed);

	int insertTag(HashTag hash);

	ShowCondition selectselconbyNic(String nick);

	List<AnoFeed> selectanobyNick(String nick);

	List<AnoFeed> selectAllano();

	List<HashTag> selectHashTag(String tag);

	AnoFeed selectanobynum(int anNum);

	List<HashTag> selecttagbynum(int anNum);

	List<AnoFeed> selectanobyAll(String tempnick, String tag);
	
	int deleteanobynum(int anNum);

	int restoreanobynum(int anNum);

	List<LikeFeed> selectLikeList(String nick);

	int selectShowCondition(String nick);

	int insertShowCondition(ShowCondition condition);

	int updateShowCondition(ShowCondition condition);

	List<AnoFeed> selectMyAno(String nick);

	void insertLike(LikeFeed likeFeed);

	int selectLikeCount(int anNum);

	void deleteLike(LikeFeed likeFeed);

	void insertReply(Reply reply);

	int selectReplyCount(int anNum);

	int selectLikeCheck(LikeFeed likeFeed);

	List<Reply> selectReplyListAjax(int anNum);

	List<Reply> selectReplyListDetail(int anNum);

	int selectAnoByRp(int rpNum);

	void deleteReply(Reply reply);

	Reply selectReplyByRp(int rpNum);

	void updateReply(Reply reply);

	void insertReReply(Reply reply);

	List<Reply> deleteByRef(int ref);

	void deleteAllAno(String nick);

	Object selectReplyByNick(String nick);

	void deleteAllRp(String nick);

	void deleteLikeAll(String nick);

	void deleteShowCondition(String nick);

	Object selectanobyNickTwo(String nick);

	int updateFeed(AnoFeed anoFeed);

	void deleteHashTag(int anNum);

	int report(Report report);

	Report selectReport(Report report);

	void deletelikebynum(int anNum);

}
