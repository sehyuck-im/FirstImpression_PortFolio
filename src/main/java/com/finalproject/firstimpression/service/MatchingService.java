package com.finalproject.firstimpression.service;

import java.util.List;

import com.finalproject.firstimpression.model.Appointment;
import com.finalproject.firstimpression.model.ChatRoom;
import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.Matching;
import com.finalproject.firstimpression.model.MatchingHistory;

public interface MatchingService {

	List<Location> startMatching(Location location);

	int insertMatching(Matching matching);

	List<Matching> selectMatchingList(String myNick);

	void delete(Matching matching);

	void insertMatchingHistory(MatchingHistory matchingHistory);

	void updateFirstLike(MatchingHistory matchingHistory);

	MatchingHistory selectMatchingHistory(MatchingHistory matchingHistory);

	void updateSecondLike(MatchingHistory matchingHistory2);

	Interest selectInterest(Interest interest);
	
	int getTotal();
	int getTotalSl();
	int getTotalMm();

	int firstMatchingCount();

	int secondMatchingCount();

	int matchmadeCount();

	List<MatchingHistory> selctList();

	List<String> selmaxdow();

	Integer selavgdow();

	Integer seltodayCnt();

	List<Location> selloc(Location location2);

	List<MatchingHistory> myHistory(String nick);

	List<ChatRoom> selectmydelChat(String nick);

	Appointment selectAp(String chatRoomNo);

	Appointment selectoldAp(String chatRoomNo);

	int deleteAp(int apNum);

	Appointment selectApoOne(Appointment appointment);

	ChatRoom chklikenick(ChatRoom chatRoom);



}
