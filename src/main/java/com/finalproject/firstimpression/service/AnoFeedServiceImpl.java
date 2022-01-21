package com.finalproject.firstimpression.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.firstimpression.dao.AnoFeedDao;
import com.finalproject.firstimpression.model.AnoFeed;
import com.finalproject.firstimpression.model.HashTag;
import com.finalproject.firstimpression.model.LikeFeed;
import com.finalproject.firstimpression.model.MasterAnBoard;
import com.finalproject.firstimpression.model.Reply;
import com.finalproject.firstimpression.model.Report;
import com.finalproject.firstimpression.model.ShowCondition;

@Service
public class AnoFeedServiceImpl implements AnoFeedService {
	@Autowired
	private AnoFeedDao ad;
	
	@Override
	public List<MasterAnBoard> selectMpList(){
		return ad.selectMpList();
	}
	public int insertFeed(AnoFeed anoFeed) {


		return ad.insertFeed(anoFeed);
	}
	public AnoFeed selectFeed(AnoFeed anoFeed) {

		return ad.selectFeed(anoFeed);
	}
	public int insertTag(HashTag hash) {

		return ad.insertTag(hash);
	}

	@Override
	public ShowCondition selectselconbyNic(String nick) {
		// TODO Auto-generated method stub
		return ad.selectselconbyNic(nick);
	}

	@Override
	public List<AnoFeed> selectanobyNick(String nick) {
		// TODO Auto-generated method stub
		return ad.selectanobyNick(nick);
	}

	@Override
	public List<AnoFeed> selectAllano() {
		// TODO Auto-generated method stub
		return ad.selectAllano();
	}



	@Override
	public List<HashTag> selectHashTag(String tag) {
		// TODO Auto-generated method stub
		return ad.selectHashTag(tag);
	}

	@Override
	public AnoFeed selectanobynum(int anNum) {
		// TODO Auto-generated method stub
		return ad.selectanobynum(anNum);
	}

	@Override
	public List<HashTag> selecttagbynum(int anNum) {
		// TODO Auto-generated method stub
		return ad.selecttagbynum(anNum);
	}

	@Override
	public List<AnoFeed> selectanobyAll(String tempnick, String tag) {
		// TODO Auto-generated method stub
		return ad.selectanobyAll(tempnick,tag);
	}
	public List<LikeFeed> selectLikeList(String nick) {

		return ad.selectLikeList(nick);
	}
	@Override
	public int deleteanobynum(int anNum) {
		return ad.deleteanobynum(anNum);
	}
	
	@Override
	public int restoreanobynum(int anNum) {
		return ad.restoreanobynum(anNum);
	}
	public int selectShowCondition(String nick) {

		return ad.selectShowCondition(nick);
	}
	public int insertShowCondition(ShowCondition condition) {

		return ad.insertShowCondition(condition);
	}
	public int updateShowCondition(ShowCondition condition) {

		return ad.updateShowCondition(condition);
	}
	@Override
	public List<AnoFeed> selectMyAno(String nick) {
		// TODO Auto-generated method stub
		return ad.selectMyAno(nick);
	}
	public void insertLike(LikeFeed likeFeed) {

		ad.insertLike(likeFeed);
	}
	public int selectLikeCount(int anNum) {

		return ad.selectLikeCount(anNum);
	}
	public void deleteLike(LikeFeed likeFeed) {
		
		ad.deleteLike(likeFeed);
	}
	public void insertReply(Reply reply) {
		ad.insertReply(reply);
	}
	public int selectReplyCount(int anNum) {

		return ad.selectReplyCount(anNum);
	}
	public int selectLikeCheck(LikeFeed likeFeed) {

		return ad.selectLikeCheck(likeFeed);
	}
	public List<Reply> selectReplyListAjax(int anNum) {

		return ad.selectReplyListAjax(anNum);
	}
	public List<Reply> selectReplyListDetail(int anNum) {
		
		return ad.selectReplyListDetail(anNum);
	}
	public int selectAnoByRp(int rpNum) {

		return ad.selectAnoByRp(rpNum);
	}
	public void deleteReply(Reply reply) {

		ad.deleteReply(reply);
	}
	public Reply selectReplyByRp(int rpNum) {

		return ad.selectReplyByRp(rpNum);
	}
	public void updateReply(Reply reply) {
		ad.updateReply(reply);
	}
	public void insertReReply(Reply reply) {
		
		ad.insertReReply(reply);
	}
	public List<Reply> deleteByRef(int ref) {

		return ad.deleteByRef(ref);
	}
	public void deleteAllAno(String nick) {

		ad.deleteAllAno(nick);
	}
	public Object selectReplyByNick(String nick) {

		return ad.selectReplyByNick(nick);
	}
	public void deleteAllRp(String nick) {

		ad.deleteAllRp(nick);
	}
	public void deleteLikeAll(String nick) {
		
		ad.deleteLikeAll(nick);
	}
	public void deleteShowCondition(String nick) {
		ad.deleteShowCondition(nick);
	}
	public Object selectanobyNickTwo(String nick) {

		return ad.selectanobyNickTwo(nick);
	}
	public int updateFeed(AnoFeed anoFeed) {

		return ad.updateFeed(anoFeed);
	}
	public void deleteHashTag(int anNum) {
		ad.deleteHashTag(anNum);
	}
	
	@Override
	public int report(Report report) {
		// TODO Auto-generated method stub
		return ad.report(report);
	}
	@Override
	public Report selectReport(Report report) {
		return ad.selectReport(report);
		
	}
	@Override
	public void deletelikebynum(int anNum) {
		// TODO Auto-generated method stub
		ad.deletelikebynum(anNum);
	}
}
