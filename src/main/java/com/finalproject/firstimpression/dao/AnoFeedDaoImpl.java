package com.finalproject.firstimpression.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalproject.firstimpression.model.AnoFeed;
import com.finalproject.firstimpression.model.HashTag;
import com.finalproject.firstimpression.model.LikeFeed;
import com.finalproject.firstimpression.model.MasterAnBoard;
import com.finalproject.firstimpression.model.Reply;
import com.finalproject.firstimpression.model.Report;
import com.finalproject.firstimpression.model.ShowCondition;

@Repository
public class AnoFeedDaoImpl implements AnoFeedDao {
	@Autowired
	private SqlSessionTemplate sst;

	public List<MasterAnBoard> selectMpList() {
		return sst.selectList("anoFeedns.selectMpList");
	}

	public int insertFeed(AnoFeed anoFeed) {
		return sst.insert("anoFeedns.insertFeed", anoFeed);
	}

	public AnoFeed selectFeed(AnoFeed anoFeed) {

		return sst.selectOne("anoFeedns.selectFeed", anoFeed);
	}

	public int insertTag(HashTag hash) {

		return sst.insert("hashTagns.insertHash", hash);
	}

	@Override
	public ShowCondition selectselconbyNic(String nick) {
		return sst.selectOne("showConditionns.selectselconbyNic", nick);
	}

	@Override
	public List<AnoFeed> selectanobyNick(String tempnick) {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("nick", tempnick);
		return sst.selectList("anoFeedns.selectanobyNick", map);
	}

	@Override
	public List<AnoFeed> selectAllano() {
		// TODO Auto-generated method stub
		return sst.selectList("anoFeedns.selectAllano");
	}

	@Override
	public List<HashTag> selectHashTag(String tag) {
		// TODO Auto-generated method stub
		return sst.selectList("hashTagns.selectHashTag", tag);
	}

	@Override
	public AnoFeed selectanobynum(int anNum) {
		// TODO Auto-generated method stub
		return sst.selectOne("anoFeedns.selectanobynum", anNum);
	}

	@Override
	public List<HashTag> selecttagbynum(int anNum) {
		// TODO Auto-generated method stub
		return sst.selectList("hashTagns.selecttagbynum", anNum);
	}

	@Override
	public List<AnoFeed> selectanobyAll(String tempnick, String tag) {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("nick", tempnick);
		map.put("tag", tag);

		return sst.selectList("anoFeedns.selectanobyAll", map);
	}

	public List<LikeFeed> selectLikeList(String nick) {

		return sst.selectList("likeFeedns.selectLikeList", nick);
	}

	public int deleteanobynum(int anNum) {
		return sst.update("anoFeedns.deleteanobynum", anNum);
	}

	public int restoreanobynum(int anNum) {
		return sst.update("anoFeedns.restoreanobynum", anNum);
	}

	public int selectShowCondition(String nick) {

		return sst.selectOne("showConditionns.selectShowCondition", nick);
	}

	public int insertShowCondition(ShowCondition condition) {

		return sst.insert("showConditionns.insertShowCondition", condition);
	}

	public int updateShowCondition(ShowCondition condition) {

		return sst.update("showConditionns.updateShowCondition", condition);
	}

	@Override
	public List<AnoFeed> selectMyAno(String nick) {
		// TODO Auto-generated method stub
		return sst.selectList("anoFeedns.selectMyAno", nick);
	}

	public void insertLike(LikeFeed likeFeed) {
		sst.insert("likeFeedns.insertLike", likeFeed);
		sst.update("anoFeedns.updateLikeUp", likeFeed);
	}

	public int selectLikeCount(int anNum) {

		return sst.selectOne("anoFeedns.selectLikeCount", anNum);
	}

	public void deleteLike(LikeFeed likeFeed) {

		sst.delete("likeFeedns.deleteLike", likeFeed);
		sst.update("anoFeedns.updateLikeDown", likeFeed);
	}

	public void insertReply(Reply reply) {
		sst.insert("replyns.insertReply", reply);
		sst.update("anoFeedns.updateReplyCountUp", reply);
	}
	public int selectReplyCount(int anNum) {

		return sst.selectOne("anoFeedns.selectReplyCount", anNum);
	}
	public int selectLikeCheck(LikeFeed likeFeed) {

		return sst.selectOne("likeFeedns.selectLikeCheck", likeFeed);
	}
	public List<Reply> selectReplyListAjax(int anNum) {

		return sst.selectList("replyns.selectReplyListAjax", anNum);
	}
	public List<Reply> selectReplyListDetail(int anNum) {

		return sst.selectList("replyns.selectReplyListDetail", anNum);
	}
	public int selectAnoByRp(int rpNum) {

		return sst.selectOne("replyns.selectAnoByRp", rpNum);
	}
	public void deleteReply(Reply reply) {

		sst.update("replyns.deleteReply", reply);
		
		sst.update("anoFeedns.updateReplyCountDown", reply);
	}
	public Reply selectReplyByRp(int rpNum) {

		return sst.selectOne("replyns.selectReplyByRp", rpNum);
	}
	public void updateReply(Reply reply) {
		sst.update("replyns.updateReply", reply);
	}
	public void insertReReply(Reply reply) {
		int ref_level = sst.selectOne("replyns.selectLevel", reply);
		reply.setRef_level(ref_level);
		
		sst.insert("replyns.insertReReply", reply);
		sst.update("anoFeedns.updateReplyCountUp", reply);
	}
	public List<Reply> deleteByRef(int ref) {

		return sst.selectList("replyns.deleteByRef", ref);
	}
	public void deleteAllAno(String nick) {
		sst.delete("anoFeedns.deleteAllAno", nick);
	}
	public Object selectReplyByNick(String nick) {

		return sst.selectList("replyns.selectReplyByNick", nick);
	}
	public void deleteAllRp(String nick) {

		sst.delete("replyns.deleteAllRp", nick);
	}
	public void deleteLikeAll(String nick) {
		sst.delete("likeFeedns.deleteLikeAll", nick);
	}
	public void deleteShowCondition(String nick) {

		sst.delete("showConditionns.deleteShowCondition", nick);
	}
	public Object selectanobyNickTwo(String nick) {

		return sst.selectList("anoFeedns.selectanobyNickTwo", nick);
	}
	public int updateFeed(AnoFeed anoFeed) {

		return sst.update("anoFeedns.updateFeed", anoFeed);
	}
	public void deleteHashTag(int anNum) {
		sst.delete("hashTagns.deleteHashTag", anNum);
	}
	
	@Override
	public int report(Report report) {
		// TODO Auto-generated method stub
		return sst.insert("reportns.reports",report);
	}

	@Override
	public Report selectReport(Report report) {
		return sst.selectOne("reportns.selectReport", report);
		
	}

	@Override
	public void deletelikebynum(int anNum) {
		sst.delete("likeFeedns.deleteLikeFeed",anNum);
		
	}
}
