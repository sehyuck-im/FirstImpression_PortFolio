package com.finalproject.firstimpression.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.firstimpression.dao.ChatDao;
import com.finalproject.firstimpression.model.Appointment;
import com.finalproject.firstimpression.model.ChatHistory;
import com.finalproject.firstimpression.model.ChatRoom;
import com.finalproject.firstimpression.model.MatchingHistory;

@Service
public class ChatServiceImpl implements ChatService {
@Autowired
private ChatDao cd;

@Override
public ChatRoom select(ChatRoom chatRoom) {
	// TODO Auto-generated method stub
	return cd.select(chatRoom);
}

@Override
public void insert(ChatRoom chatRoom) {
	 cd.insert(chatRoom);
	
}
@Override
public void insertMessage(ChatHistory chatHistory) {
	cd.insertMessage(chatHistory);
	
}

@Override
public List<ChatHistory> selectchatHistory(ChatHistory chatHistory) {
	// TODO Auto-generated method stub
	return cd.selectchatHistory(chatHistory);
}


@Override
public int chatcount(ChatHistory chatHistory) {
	// TODO Auto-generated method stub
	return cd.chatcount(chatHistory);
}

@Override
public List<ChatHistory> selectnewchatHistory(ChatHistory chatHistory) {
	// TODO Auto-generated method stub
	return cd.selectnewchatHistory(chatHistory);
}

@Override
public void updateReadCount(ChatHistory chat) {
	cd.updateReadCount(chat);
	
}

@Override
public List<ChatRoom> selectMychatRoom(String nick) {
	// TODO Auto-generated method stub
	return cd.selectMychatRoom(nick);
}

@Override
public List<ChatRoom> selectMychatRoom2(String nick) {
	// TODO Auto-generated method stub
	return cd.selectMychatRoom2(nick);
}

@Override
public int unReadMessage(ChatHistory chatHistory) {
	// TODO Auto-generated method stub
	return cd.unReadMessage(chatHistory);
}

@Override
public int selectChatcheck(ChatRoom chatRoom) {
	// TODO Auto-generated method stub
	return cd.selectChatcheck(chatRoom);
}

@Override
public String selectTargetUser(ChatRoom chatRoom) {
	// TODO Auto-generated method stub
	return cd.selectTargetUser(chatRoom);
}

@Override
public ChatRoom selectChatbyChatRoom(ChatRoom chatRoom) {
	// TODO Auto-generated method stub
	return cd.selectChatbyChatRoom(chatRoom);
}

@Override
public void updateCarryOnCheck(ChatRoom chatRoom) {
	cd.updateCarryOnCheck(chatRoom);
	
}

@Override
public void deleteChatingRoom(ChatRoom chatRoom) {
	cd.deleteChatingRoom(chatRoom);
	
}

@Override
public String lastMessage(ChatHistory chatHistory1) {
	// TODO Auto-generated method stub
	return cd.lastMessage(chatHistory1);
}


@Override
public int insertAppointmentCheck(Appointment appointment) {
	// TODO Auto-generated method stub
	return cd.insertAppointmentCheck(appointment);
}

@Override
public int updateAppointment(Appointment appointment) {
	// TODO Auto-generated method stub
	return cd.updateAppointment(appointment);
}

@Override
public int updateMeetMade(MatchingHistory matchingHistory2) {
	// TODO Auto-generated method stub
	return cd.updateMeetMade(matchingHistory2);
}

@Override
public int myUnreadMessageCount(ChatHistory chatHistory1) {
	// TODO Auto-generated method stub
	return cd.myUnreadMessageCount(chatHistory1);
}

@Override
public List<ChatRoom> selectMychatRoom3(String nick) {
	// TODO Auto-generated method stub
	return cd.selectMychatRoom3(nick);
}




}
