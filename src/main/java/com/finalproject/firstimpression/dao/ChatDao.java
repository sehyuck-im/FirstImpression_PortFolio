package com.finalproject.firstimpression.dao;

import java.util.List;

import com.finalproject.firstimpression.model.Appointment;
import com.finalproject.firstimpression.model.ChatHistory;
import com.finalproject.firstimpression.model.ChatRoom;
import com.finalproject.firstimpression.model.MatchingHistory;

public interface ChatDao {

	ChatRoom select(ChatRoom chatRoom);

	Object insert(ChatRoom chatRoom);

	void insertMessage(ChatHistory chatHistory);

	List<ChatHistory> selectchatHistory(ChatHistory chatHistory);

	int chatcount(ChatHistory chatHistory);

	List<ChatHistory> selectnewchatHistory(ChatHistory chatHistory);

	void updateReadCount(ChatHistory chat);

	List<ChatRoom> selectMychatRoom(String nick);

	List<ChatRoom> selectMychatRoom2(String nick);

	int unReadMessage(ChatHistory chatHistory);

	int selectChatcheck(ChatRoom chatRoom);

	String selectTargetUser(ChatRoom chatRoom);

	ChatRoom selectChatbyChatRoom(ChatRoom chatRoom);

	void updateCarryOnCheck(ChatRoom chatRoom);

	void deleteChatingRoom(ChatRoom chatRoom);

	String lastMessage(ChatHistory chatHistory1);


	int insertAppointmentCheck(Appointment appointment);

	int updateAppointment(Appointment appointment);

	int updateMeetMade(MatchingHistory matchingHistory2);

	int myUnreadMessageCount(ChatHistory chatHistory1);

	List<ChatRoom> selectMychatRoom3(String nick);

}
