package com.finalproject.firstimpression.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalproject.firstimpression.model.Appointment;
import com.finalproject.firstimpression.model.ChatHistory;
import com.finalproject.firstimpression.model.ChatRoom;
import com.finalproject.firstimpression.model.MatchingHistory;

@Repository
public class ChatDaoImpl implements ChatDao {
@Autowired
private SqlSessionTemplate sst;

@Override
public ChatRoom select(ChatRoom chatRoom) {
	// TODO Auto-generated method stub
	return sst.selectOne("chatRoomns.select",chatRoom);
}

@Override
public Object insert(ChatRoom chatRoom) {
	// TODO Auto-generated method stub
	return sst.insert("chatRoomns.insert",chatRoom);
}

@Override
public void insertMessage(ChatHistory chatHistory) {
	// TODO Auto-generated method stub
	sst.insert("chatHistoryns.insertMessage",chatHistory);
}

@Override
public List<ChatHistory> selectchatHistory(ChatHistory chatHistory) {
	// TODO Auto-generated method stub
	return sst.selectList("chatHistoryns.selectchatHistory",chatHistory);
}

@Override
public int chatcount(ChatHistory chatHistory) {
	// TODO Auto-generated method stub
	return sst.selectOne("chatHistoryns.chatcount",chatHistory);
}

@Override
public List<ChatHistory> selectnewchatHistory(ChatHistory chatHistory) {
	// TODO Auto-generated method stub
	return sst.selectList("chatHistoryns.selectnewchatHistory",chatHistory);
}

@Override
public void updateReadCount(ChatHistory chat) {
	sst.update("chatHistoryns.updateReadCount",chat);
	
}

@Override
public List<ChatRoom> selectMychatRoom(String nick) {
	// TODO Auto-generated method stub
	return sst.selectList("chatRoomns.selectMychatRoom",nick);
}

@Override
public List<ChatRoom> selectMychatRoom2(String nick) {
	// TODO Auto-generated method stub
	return sst.selectList("chatRoomns.selectMychatRoom2",nick);
}

@Override
public int unReadMessage(ChatHistory chatHistory) {
	// TODO Auto-generated method stub
	return sst.selectOne("chatHistoryns.unReadMessage",chatHistory);
}

@Override
public int selectChatcheck(ChatRoom chatRoom) {
	// TODO Auto-generated method stub
	return sst.selectOne("chatRoomns.selectChatcheck",chatRoom);
}

@Override
public String selectTargetUser(ChatRoom chatRoom) {
	// TODO Auto-generated method stub
	return sst.selectOne("chatRoomns.selectTargetUser",chatRoom);
}

@Override
public ChatRoom selectChatbyChatRoom(ChatRoom chatRoom) {
	// TODO Auto-generated method stub
	return sst.selectOne("chatRoomns.selectChatbyChatRoom",chatRoom);
}

@Override
public void updateCarryOnCheck(ChatRoom chatRoom) {
	sst.update("chatRoomns.updateCarryOnCheck",chatRoom);
	
}

@Override
public void deleteChatingRoom(ChatRoom chatRoom) {
	sst.update("chatRoomns.deleteChatingRoom",chatRoom);
	
}

@Override
public String lastMessage(ChatHistory chatHistory1) {
	// TODO Auto-generated method stub
	return sst.selectOne("chatHistoryns.lastMessage",chatHistory1);
}


@Override
public int insertAppointmentCheck(Appointment appointment) {
	// TODO Auto-generated method stub
	return sst.insert("appointmentns.insert",appointment);
}

@Override
public int updateAppointment(Appointment appointment) {
	// TODO Auto-generated method stub
	return sst.update("appointmentns.update",appointment);
}

@Override
public int updateMeetMade(MatchingHistory matchingHistory2) {
	// TODO Auto-generated method stub
	return sst.update("matchingHistoryns.updateMeetMade",matchingHistory2);
}

@Override
public int myUnreadMessageCount(ChatHistory chatHistory1) {
	// TODO Auto-generated method stub
	return sst.selectOne("chatHistoryns.myUnreadMessageCount",chatHistory1);
}

@Override
public List<ChatRoom> selectMychatRoom3(String nick) {
	// TODO Auto-generated method stub
	return sst.selectList("chatRoomns.selectMychatRoom3",nick);
}

}
