package com.finalproject.firstimpression.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.firstimpression.dao.MatchingDao;
import com.finalproject.firstimpression.model.Appointment;
import com.finalproject.firstimpression.model.ChatRoom;
import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.Matching;
import com.finalproject.firstimpression.model.MatchingHistory;
@Service
public class MatchingServiceImpl implements MatchingService {
	@Autowired
	private MatchingDao mcd;

	@Override
	public List<Location> startMatching(Location location) {
		// TODO Auto-generated method stub
		return mcd.startMatching(location);
	}

	@Override
	public int insertMatching(Matching matching) {
		// TODO Auto-generated method stub
		return mcd.insertMatching(matching);
	}

	@Override
	public List<Matching> selectMatchingList(String myNick) {
		// TODO Auto-generated method stub
		return mcd.selectMatchingList(myNick);
	}

	@Override
	public void delete(Matching matching) {
		mcd.delete(matching);
		
	}

	@Override
	public void insertMatchingHistory(MatchingHistory matchingHistory) {
		mcd.insertMatchingHistory(matchingHistory);
		
	}

	@Override
	public void updateFirstLike(MatchingHistory matchingHistory) {
		mcd.updateFirstLike(matchingHistory);
		
	}

	@Override
	public MatchingHistory selectMatchingHistory(MatchingHistory matchingHistory) {
		// TODO Auto-generated method stub
		return mcd.selectMatchingHistory(matchingHistory);
	}

	@Override
	public void updateSecondLike(MatchingHistory matchingHistory2) {
		mcd.updateSecondLike(matchingHistory2);
		
	}

	@Override
	public Interest selectInterest(Interest interest) {
		// TODO Auto-generated method stub
		return mcd.selectInterest(interest);
	}
	
	@Override
	public int getTotal() {
		return mcd.getTotal();
	}
	
	@Override
	public int getTotalSl() {
		return mcd.getTotalSl();
	}
	
	@Override
	public int getTotalMm() {
		return mcd.getTotalMm();
	}

	@Override
	public int firstMatchingCount() {
		// TODO Auto-generated method stub
		return mcd.firstMatchingCount();
	}

	@Override
	public int secondMatchingCount() {
		// TODO Auto-generated method stub
		return mcd.secondMatchingCount();
	}

	@Override
	public int matchmadeCount() {
		// TODO Auto-generated method stub
		return mcd.matchmadeCount();
	}

	@Override
	public List<MatchingHistory> selctList() {
		// TODO Auto-generated method stub
		return mcd.selctList();
	}
	
	@Override
	public List<String> selmaxdow() {
		return mcd.selmaxdow();
	}
	
	@Override
	public Integer selavgdow() {
		return mcd.selavgdow();
	}
	
	@Override
	public Integer seltodayCnt() {
		return mcd.seltodayCnt();
	}

	@Override
	public List<Location> selloc(Location location) {
		// TODO Auto-generated method stub
		return mcd.selloc(location);
	}

	@Override
	public List<MatchingHistory> myHistory(String nick) {
		// TODO Auto-generated method stub
		return mcd.myHistory(nick);
	}

	@Override
	public List<ChatRoom> selectmydelChat(String nick) {
		// TODO Auto-generated method stub
		return mcd.selectmydelChat(nick);
	}

	@Override
	public Appointment selectAp(String chatRoomNo) {
		// TODO Auto-generated method stub
		return mcd.selectAp(chatRoomNo);
	}

	@Override
	public Appointment selectoldAp(String chatRoomNo) {
		// TODO Auto-generated method stub
		return mcd.selectoldAp(chatRoomNo);
	}

	@Override
	public int deleteAp(int apNum) {
		// TODO Auto-generated method stub
		return mcd.deleteAp(apNum);
	}

	@Override
	public Appointment selectApoOne(Appointment appointment) {
		// TODO Auto-generated method stub
		return mcd.selectApoOne(appointment);
	}

	@Override
	public ChatRoom chklikenick(ChatRoom chatRoom) {
		// TODO Auto-generated method stub
		return mcd.chklikenick(chatRoom);
	}




}
