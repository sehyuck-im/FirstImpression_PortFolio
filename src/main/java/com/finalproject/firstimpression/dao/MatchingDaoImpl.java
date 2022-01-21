package com.finalproject.firstimpression.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalproject.firstimpression.model.Appointment;
import com.finalproject.firstimpression.model.ChatRoom;
import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.Matching;
import com.finalproject.firstimpression.model.MatchingHistory;

@Repository
public class MatchingDaoImpl implements MatchingDao {
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Location> startMatching(Location location) {
		// TODO Auto-generated method stub
		return sst.selectList("locationns.startMatching",location);
	}

	@Override
	public int insertMatching(Matching matching) {
		// TODO Auto-generated method stub
		return sst.insert("matchingns.insertMatching",matching);
	}

	@Override
	public List<Matching> selectMatchingList(String myNick) {
		// TODO Auto-generated method stub
		return sst.selectList("matchingns.selectMatchingList",myNick);
	}

	@Override
	public void delete(Matching matching) {
		sst.delete("matchingns.delete",matching);
		
	}

	@Override
	public void insertMatchingHistory(MatchingHistory matchingHistory) {
		sst.insert("matchingHistoryns.insert",matchingHistory);
		
	}

	@Override
	public void updateFirstLike(MatchingHistory matchingHistory) {
		sst.update("matchingHistoryns.updateFirstLike",matchingHistory);
		
	}

	@Override
	public MatchingHistory selectMatchingHistory(MatchingHistory matchingHistory) {
		// TODO Auto-generated method stub
		return sst.selectOne("matchingHistoryns.selectMatchingHistory",matchingHistory);
	}

	@Override
	public void updateSecondLike(MatchingHistory matchingHistory2) {
		sst.update("matchingHistoryns.updateSecondLike",matchingHistory2);
		
	}

	@Override
	public Interest selectInterest(Interest interest) {
		// TODO Auto-generated method stub
		return sst.selectOne("profilens.selectInterest",interest);
	}
	
	@Override
	public int getTotal() {
		return sst.selectOne("matchingHistoryns.getTotal");
	}
	@Override
	public int getTotalSl() {
		return sst.selectOne("matchingHistoryns.getTotalSl");
	}
	@Override
	public int getTotalMm() {
		return sst.selectOne("matchingHistoryns.getTotalMm");
	}

	@Override
	public int firstMatchingCount() {
		// TODO Auto-generated method stub
		return sst.selectOne("matchingHistoryns.firstMatchingCount");
	}

	@Override
	public int secondMatchingCount() {
		// TODO Auto-generated method stub
		return sst.selectOne("matchingHistoryns.secondMatchingCount");
	}

	@Override
	public int matchmadeCount() {
		// TODO Auto-generated method stub
		return sst.selectOne("matchingHistoryns.matchmadeCount");
	}

	@Override
	public List<MatchingHistory> selctList() {
		// TODO Auto-generated method stub
		return sst.selectList("matchingHistoryns.selctList");
	}
	
	@Override
	public List<String> selmaxdow() {
		return sst.selectList("matchingHistoryns.selmaxdow");
	}
	
	@Override
	public Integer selavgdow() {
		return sst.selectOne("matchingHistoryns.selavgdow");
	}
	
	@Override
	public Integer seltodayCnt() {
		return sst.selectOne("matchingHistoryns.seltodayCnt");
	}

	@Override
	public List<Location> selloc(Location location) {
		// TODO Auto-generated method stub
		return sst.selectList("locationns.selloc",location);
	}

	@Override
	public List<MatchingHistory> myHistory(String nick) {
		// TODO Auto-generated method stub
		return sst.selectList("matchingHistoryns.myHistory",nick);
	}

	@Override
	public List<ChatRoom> selectmydelChat(String nick) {
		// TODO Auto-generated method stub
		return sst.selectList("chatRoomns.selectmydelChat",nick);
	}

	@Override
	public Appointment selectAp(String chatRoomNo) {
		// TODO Auto-generated method stub
		return sst.selectOne("appointmentns.selectAp",chatRoomNo);
	}

	@Override
	public Appointment selectoldAp(String chatRoomNo) {
		// TODO Auto-generated method stub
		return sst.selectOne("appointmentns.selectoldAp",chatRoomNo);
	}

	@Override
	public int deleteAp(int apNum) {
		// TODO Auto-generated method stub
		return sst.update("appointmentns.deleteAp",apNum);
	}

	@Override
	public Appointment selectApoOne(Appointment appointment) {
		// TODO Auto-generated method stub
		return sst.selectOne("appointmentns.selectApoOne",appointment);
	}

	@Override
	public ChatRoom chklikenick(ChatRoom chatRoom) {
		// TODO Auto-generated method stub
		return sst.selectOne("chatRoomns.chklikenick",chatRoom);
	}

}
