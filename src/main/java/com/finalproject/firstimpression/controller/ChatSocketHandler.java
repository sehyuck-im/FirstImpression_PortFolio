package com.finalproject.firstimpression.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.finalproject.firstimpression.model.ChatHistory;
import com.finalproject.firstimpression.model.ChatRoom;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.model.SelLoc;
import com.finalproject.firstimpression.service.ChatService;
import com.finalproject.firstimpression.service.ProfileService;
import com.finalproject.firstimpression.service.SelLocService;
@Component
public class ChatSocketHandler extends TextWebSocketHandler{
	@Autowired
	private ChatService cs;
	@Autowired
	private SelLocService ss;
	@Autowired
	private ProfileService ps;
	private List<WebSocketSession> users;
	//list에 유저 로그인시 저장 객체
	private Map<String, Object> userMap;
	
	public ChatSocketHandler() {
		users=new ArrayList<WebSocketSession>();
		userMap= new HashMap<String,Object>();
	}
	public void afterConnectionEstablished(WebSocketSession session)throws Exception{
		System.out.println("연결 생성");
		users.add(session);
	}
	
	protected void handleTextMessage(WebSocketSession session,TextMessage message) throws Exception{
		
		
		JSONObject object=new JSONObject(message.getPayload());
		int cutchat=20;
		String type=object.getString("type");
		if(type != null && type.equals("register"))
		{
			String user = object.getString("userid");
			userMap.put(user, session);
		}
		else if(type.equals("chatRoomList"))
		{
			String user = object.getString("chatRoomNo")+","+object.getString("nick");
			userMap.put(user, session);
			String chatRoomNo=object.getString("chatRoomNo")+","+object.getString("nick");
			if (users.contains(userMap.get(chatRoomNo)))
			{
				WebSocketSession ws=(WebSocketSession)userMap.get(chatRoomNo);
				String chatRoomNo1 = object.getString("chatRoomNo");
				ChatHistory chatHistory1= new ChatHistory();
				chatHistory1.setSendUser(object.getString("nick"));
				chatHistory1.setChatRoomNo(chatRoomNo1);
				int unReadMessage=cs.unReadMessage(chatHistory1);
	
				String unReadCount=Integer.toString(unReadMessage);
				String lastMessage=cs.lastMessage(chatHistory1);

				if(ws != null)
				{
					ws.sendMessage(new TextMessage("<input type='hidden' id='readCount' value='"+chatRoomNo+"'>"+unReadCount));
					ws.sendMessage(new TextMessage("<input type='hidden' value='"+chatRoomNo+"'>"+lastMessage));
				}
			}
		}
		else if(type.equals("chatHeader"))
		{
			Profile profile=ps.selectProfileById(object.getString("nick"));
			String nick=profile.getNick();
			userMap.put(nick, session);
			
			if (users.contains(userMap.get(nick)))
			{
				WebSocketSession ws=(WebSocketSession)userMap.get(nick);
				List<ChatRoom> mychatRoomLists=cs.selectMychatRoom3(nick);
				int unReadMessage=0;
				for(ChatRoom mychatRoomList:mychatRoomLists)
				{
					ChatHistory chatHistory1= new ChatHistory();
					chatHistory1.setSendUser(nick);
					chatHistory1.setChatRoomNo(mychatRoomList.getChatRoomNo());
					int unread=cs.unReadMessage(chatHistory1);
					unReadMessage+=unread;
				}
				

				String unReadCount=Integer.toString(unReadMessage);
				String msg="<div style=\"margin-top:  -10px;\" class=\"btn btn-info btn-sm\">";
				msg+=unReadCount+"</div>&nbsp;Chat";

				if(unReadMessage>0)
				{
				if(ws != null)
				{
					ws.sendMessage(new TextMessage(msg));
				}
				}
			}
		}
		else if(type.equals("enter"))
		{
			Profile profile=ps.selectProfileByNick(object.getString("from"));
			String userImg=profile.getPhoto1();
			String from="<div class=\"media w-50  mb-3\"><a href=\"userProfile.do?nick="+object.getString("from")+"\"><img src=\"resources/profiles/"+userImg+"\" alt=\"user\" width=\"50\" height=\"50\" class=\"rounded-circle\"></a><p class=\"small text-muted\" style=\"color: black !important;\">"+object.getString("from")+"</p>";
			String chatRoomNo = object.getString("chatRoomNo");
			String enteruser=object.getString("userid");
			ChatRoom chatRoom=new ChatRoom();
			chatRoom.setEnterUser1(object.getString("from"));
			chatRoom.setChatRoomNo(chatRoomNo);
			int chatcheck=cs.selectChatcheck(chatRoom);
			String targetUser=cs.selectTargetUser(chatRoom);
			if(chatcheck<2)
			{
				cutchat=20;
			}
			else
			{
				cutchat=50;
			}
			ChatHistory chatHistory= new ChatHistory();
			chatHistory.setSendUser(object.getString("from"));
			chatHistory.setChatRoomNo(chatRoomNo);
			List<ChatHistory> list=cs.selectchatHistory(chatHistory);
			List<ChatHistory> list2=cs.selectnewchatHistory(chatHistory);
			int chatCount=cs.chatcount(chatHistory);
			WebSocketSession ws=(WebSocketSession) userMap.get(enteruser);
			
			for(ChatHistory chat : list)
			{
				String fromWho=chat.getSendUser();
				Profile sendUserProfile=ps.selectProfileByNick(fromWho);
				String sendUserImg=sendUserProfile.getPhoto1();
				String sendUser="<div class=\"media w-50  mb-3\"><a href=\"userProfile.do?nick="+fromWho+"\"><img src=\"resources/profiles/"+sendUserImg+"\" alt=\"user\" width=\"50\" height=\"50\" height=\"50\" class=\"rounded-circle\"></a><p class=\"small text-muted\" style=\"color: black !important;\">"+fromWho+"</p>";
				String msg = sendUser+chat.getMessage();
				ws.sendMessage(new TextMessage(msg));
			}
			if(chatCount<cutchat)
			{
				String msg = "현재 당신은 "+chatCount+"개의 메시지를 입력하셨습니다<br> 총 입력 가능 메세지 수는 "+cutchat+"개 입니다<br> 좋은 첫인상을 위해 신중해주세요<br>";
				ws.sendMessage(new TextMessage(msg));
			}
			if(chatCount==cutchat)
			{
				String msg = "사용 가능한 대화 기회를 전부 사용하셨습니다<br> 총 입력 가능 메세지 수는 "+cutchat+"개 입니다<br>";
				if(cutchat==20)
				{
				msg += "<form action=\"carryOnChating.do\">\n" + 
						"				<table>\n" + 
						"				<tr>\n" + 
						"				<th colspan=\"2\" align=\"center\">\n" + 
						"				서로에 대한 평가후에 다시 채팅을 이어가실 수 있습니다<br>\n" + 
						"				"+targetUser+"님과의 채팅을 이어가시겠습니까?\n" + 
						"				<input type=\"hidden\" name=\"enterUser1\" value='"+object.getString("from")+"'>\n" + 
						"				<input type=\"hidden\" name=\"chatRoomNo\" value='"+chatRoomNo+"'>\n" + 
						"				</th></tr><tr align=\"center\">\n" + 
						"				<th align=\"center\"><input type=\"submit\" value=\"좋아요\" class=\"btn btn-info btn-sm\"></th>\n" + 
						"				<th align=\"center\">\n" + 
						"				<a class=\"btn btn-info btn-sm\"\n" + 
						"					href=\"endChating.do?enteruser1="+object.getString("from")+"&chatRoomNo="+chatRoomNo+"\">채팅을 그만하겠습니다</a>\n" + 
						"				</th>\n" + 
						"				</tr>\n" + 
						"				</table>\n" + 
						"				</form>";
				}
				if(cutchat==50)
				{
					List<SelLoc> selLocs=ss.selectLocation(chatRoomNo);
					
					msg+="<form action=\"appointment.do\">\n" + 
							"<table>\n" + 
							"<tr>\n" + 
							"<th colspan=\"2\">서로 대화가 끝났다면 약속을 잡아보세요\n" + 
							"				<input type=\"hidden\" name=\"enterUser1\" value='"+object.getString("from")+"'>\n" + 
							"				<input type=\"hidden\" name=\"chatRoomNo\" value='"+chatRoomNo+"'>\n" + 
							"</th></tr>\n" + 
							"<tr>\n" + 
							"<th>\n" + 
							"<select name=\"location\" required=\"required\">\n" ;
							for(SelLoc selLoc : selLocs)
							{
							msg+=	"<option>"+selLoc.getPlace()+"</option>\n";
							}
					msg+=	"</select>\n" + 
							"</th>\n" + 
							"<th>\n" + 
							"<select name=\"appointmentTime\" required=\"required\">\n" + 
							"<option value=\"9~14\">9~14</option>\n" + 
							"<option value=\"14~18\">14~18</option>\n" + 
							"<option value=\"18~22\">18~22</option>\n" + 
							"</select>\n" + 
							"<input type=\"date\" name=\"appointmentdate\" required=\"required\"></th>\n" + 
							"</tr>\n" + 
							"<tr>\n" + 
							"<th>\n" + 
							"<input class=\"btn btn-info btn-sm\" type=\"submit\" value=\"약속 확인\"><th/><th><a class=\"btn btn-info btn-sm\" href=\"endChating.do?enteruser1="+object.getString("from")+"&chatRoomNo="+chatRoomNo+"\">채팅 떠나기</a>\n" + 
							"</th>\n" + 
							"</tr>\n" + 
							"</table>\n" + 
							"</form>";
				}
				ws.sendMessage(new TextMessage(msg));
			}
			if(!list2.isEmpty())
			{
				String msg="<br>----여기까지 읽으셨습니다----<br>";
				for(ChatHistory chat : list2)
				{
					String fromWho=chat.getSendUser();
					Profile sendUserProfile=ps.selectProfileByNick(fromWho);
					String sendUserImg=sendUserProfile.getPhoto1();
					String sendUser="<div class=\"media w-50  mb-3\"><a href=\"userProfile.do?nick="+fromWho+"\"><img src=\"resources/profiles/"+sendUserImg+"\" alt=\"user\" width=\"50\" height=\"50\" height=\"50\" class=\"rounded-circle\"></a><p class=\"small text-muted\" style=\"color: black !important;\">"+fromWho+"</p>";
					msg += sendUser+chat.getMessage()+"<br>";
					cs.updateReadCount(chat);
				}	
				ws.sendMessage(new TextMessage(msg));
			}
			
		}
		else if(type.equals("chat")){
			String target= object.getString("target");
			Profile profile=ps.selectProfileByNick(object.getString("from"));
			String userImg=profile.getPhoto1();
			String fromWho=object.getString("from");
			String from="<div class=\"media w-50  mb-3\"><a href=\"userProfile.do?nick="+object.getString("from")+"\"><img src=\"resources/profiles/"+userImg+"\" alt=\"user\" width=\"50\" height=\"50\" height=\"50\" class=\"rounded-circle\"></a><p class=\"small text-muted\" style=\"color: black !important;\">"+object.getString("from")+"</p>";
			String userid=object.getString("userid");
			String chatRoomNo=object.getString("chatRoomNo");
			String nick=object.getString("nick");
			String chatCounttarget=chatRoomNo+","+nick;
			int readCount=0;
			ChatRoom chatRoom=new ChatRoom();
			chatRoom.setEnterUser1(object.getString("from"));
			chatRoom.setChatRoomNo(chatRoomNo);
			int chatcheck=cs.selectChatcheck(chatRoom);
			String targetUser=cs.selectTargetUser(chatRoom);
			if(chatcheck<2)
			{
				cutchat=20;
			}
			else
			{
				cutchat=50;
			}
			if (users.contains(userMap.get(target)))
			{
				readCount=2;
				WebSocketSession ws2=(WebSocketSession) userMap.get(userid);
				WebSocketSession ws=(WebSocketSession) userMap.get(target);
				String content="<div class=\"media-body ml-3\"><div class=\"bg-light rounded py-2 px-3 mb-2\"><p class=\"text-small mb-0 text-muted\" style=\"color: black !important;\">"+object.getString("message")+"</p></div></div></div>";
				String msg = from+content;
				ChatHistory chatHistory=new ChatHistory();
				chatHistory.setChatRoomNo(chatRoomNo);
				chatHistory.setMessage(content);
				chatHistory.setSendUser(fromWho);
				chatHistory.setReadCount(readCount);
				int chatCount=cs.chatcount(chatHistory);
				if(chatCount<cutchat)
				{
					if(chatCount==(cutchat-6))
					{
						if(ws != null)
						{	
							ws.sendMessage(new TextMessage(msg));
						}
						if(ws2 != null)
						{
							cs.insertMessage(chatHistory);
							ws2.sendMessage(new TextMessage(msg+"<br>회원님의 현재 남은 채팅수는 5개 입니다<br>"));
						}
					}
					else {
						if(ws != null)
						{
							ws.sendMessage(new TextMessage(msg));
						}
						if(ws2 != null)
						{
							ws2.sendMessage(new TextMessage(msg));
							cs.insertMessage(chatHistory);
						}
					}
				}
				else
				{
					if(ws2 != null)
					{
						String msg1 = "사용 가능한 대화 기회를 전부 사용하셨습니다<br> 총 입력 가능 메세지 수는 "+cutchat+"개 입니다<br>";
						if(cutchat==20)
						{
						msg1 += "<form action=\"carryOnChating.do\">\n" + 
								"				<table>\n" + 
								"				<tr>\n" + 
								"				<th colspan=\"2\" align=\"center\">\n" + 
								"				서로에 대한 평가후에 다시 채팅을 이어가실 수 있습니다<br>\n" + 
								"				"+targetUser+"님과의 채팅을 이어가시겠습니까?\n" + 
								"				<input type=\"hidden\" name=\"enterUser1\" value=\""+object.getString("from")+"\">\n" + 
								"				<input type=\"hidden\" name=\"chatRoomNo\" value=\""+chatRoomNo+"\">\n" + 
								"				</th></tr><tr align=\"center\">\n" + 
								"				<th align=\"center\"><input type=\"submit\" value=\"좋아요\" class=\"btn btn-info btn-sm\"></th>\n" + 
								"				<th align=\"center\">\n" + 
								"				<a class=\"btn btn-info btn-sm\"\n" + 
								"					href=\"endChating.do?enteruser1="+object.getString("from")+"&chatRoomNo="+chatRoomNo+"\">채팅을 그만하겠습니다</a>\n" + 
								"				</th>\n" + 
								"				</tr>\n" + 
								"				</table>\n" + 
								"				</form>";
						}
						if(cutchat==50)
						{
							List<SelLoc> selLocs=ss.selectLocation(chatRoomNo);
							
							msg1+="<form action=\"appointment.do\">\n" + 
									"<table>\n" + 
									"<tr>\n" + 
									"<th colspan=\"2\">서로 대화가 끝났다면 약속을 잡아보세요\n" + 
									"				<input type=\"hidden\" name=\"enterUser1\" value='"+object.getString("from")+"'>\n" + 
									"				<input type=\"hidden\" name=\"chatRoomNo\" value='"+chatRoomNo+"'>\n" + 
									"</th></tr>\n" + 
									"<tr>\n" + 
									"<th>\n" + 
									"<select name=\"location\" required=\"required\">\n" ;
									for(SelLoc selLoc : selLocs)
									{
									msg1+=	"<option>"+selLoc.getPlace()+"</option>\n";
									}
							msg1+=	"</select>\n" + 
									"</th>\n" + 
									"<th>\n" + 
									"<select name=\"appointmentTime\" required=\"required\">\n" + 
									"<option value=\"9~14\">9~14</option>\n" + 
									"<option value=\"14~18\">14~18</option>\n" + 
									"<option value=\"18~22\">18~22</option>\n" + 
									"</select>\n" + 
									"<input type=\"date\" name=\"appointmentdate\" required=\"required\"></th>\n" + 
									"</tr>\n" + 
									"<tr>\n" + 
									"<th>\n" + 
									"<input class=\"btn btn-info btn-sm\" type=\"submit\" value=\"약속 확인\"></th><th><a class=\"btn btn-info btn-sm\" href=\"endChating.do?enteruser1="+object.getString("from")+"&chatRoomNo="+chatRoomNo+"\">채팅 떠나기</a>\n" + 
									"</th>\n" + 
									"</tr>\n" + 
									"</table>\n" + 
									"</form>";
						}
						ws2.sendMessage(new TextMessage(msg1));
					}
				}
			}
			else
			{
				readCount=1;
				WebSocketSession ws2=(WebSocketSession) userMap.get(userid);
				String content="<div class=\"media-body ml-3\"><div class=\"bg-light rounded py-2 px-3 mb-2\"><p class=\"text-small mb-0 text-muted\" style=\"color: black !important;\">"+object.getString("message")+"</p></div></div></div>";
				String msg = from+content;
				ChatHistory chatHistory=new ChatHistory();
				chatHistory.setChatRoomNo(chatRoomNo);
				chatHistory.setMessage(content);
				chatHistory.setSendUser(fromWho);
				chatHistory.setReadCount(readCount);
				int chatCount=cs.chatcount(chatHistory);
				if(chatCount<cutchat)
				{
					if(chatCount==(cutchat-6))
					{
						if(ws2 != null)
						{
							cs.insertMessage(chatHistory);
							if (users.contains(userMap.get(chatCounttarget)))
							{
									WebSocketSession ws=(WebSocketSession)userMap.get(chatCounttarget);
									String from1= object.getString("nick");
									String chatRoomNo1 = object.getString("chatRoomNo");
									ChatHistory chatHistory1= new ChatHistory();
									chatHistory1.setSendUser(from1);
									chatHistory1.setChatRoomNo(chatRoomNo1);
									int unReadMessage=cs.unReadMessage(chatHistory1);
									String unReadCount=Integer.toString(unReadMessage);
								if(ws != null)
								{
				
									ws.sendMessage(new TextMessage("<input type='hidden' id='readCount' value='"+chatCounttarget+"'>"+unReadCount));
									ws.sendMessage(new TextMessage("<input type='hidden' value='"+chatCounttarget+"'>"+content));
								}
							}
							if (users.contains(userMap.get(nick)))
							{
								WebSocketSession ws=(WebSocketSession)userMap.get(nick);
								List<ChatRoom> mychatRoomLists=cs.selectMychatRoom3(nick);
								int unReadMessage=0;
								for(ChatRoom mychatRoomList:mychatRoomLists)
								{
									ChatHistory chatHistory1= new ChatHistory();
									chatHistory1.setSendUser(nick);
									chatHistory1.setChatRoomNo(mychatRoomList.getChatRoomNo());
									int unread=cs.unReadMessage(chatHistory1);
									unReadMessage+=unread;
								}
								String unReadCount=Integer.toString(unReadMessage);
								String msg1="<div style=\"margin-top:  -10px;\" class=\"btn btn-info btn-sm\">";
								msg1+=unReadCount+"</div>&nbsp;Chat";
								if(unReadMessage>0)
								{
								if(ws != null)
								{
									ws.sendMessage(new TextMessage(msg1));
								}
								}
							}
							ws2.sendMessage(new TextMessage(msg+"<br>회원님의 현재 남은 채팅수는 5개 입니다<br>"));
						}
					}
					else {
						if(ws2 != null)
						{
							ws2.sendMessage(new TextMessage(msg));
							cs.insertMessage(chatHistory);
							if (users.contains(userMap.get(chatCounttarget)))
							{
									WebSocketSession ws=(WebSocketSession)userMap.get(chatCounttarget);
									String from1= object.getString("nick");
									String chatRoomNo1 = object.getString("chatRoomNo");
									ChatHistory chatHistory1= new ChatHistory();
									chatHistory1.setSendUser(from1);
									chatHistory1.setChatRoomNo(chatRoomNo1);
									int unReadMessage=cs.unReadMessage(chatHistory1);
									String unReadCount=Integer.toString(unReadMessage);
								if(ws != null)
								{
				
									ws.sendMessage(new TextMessage("<input type='hidden' id='readCount' value='"+chatCounttarget+"'>"+unReadCount));
									ws.sendMessage(new TextMessage("<input type='hidden' value='"+chatCounttarget+"'>"+content));
								}
							}
							if (users.contains(userMap.get(nick)))
							{
								WebSocketSession ws=(WebSocketSession)userMap.get(nick);
								List<ChatRoom> mychatRoomLists=cs.selectMychatRoom3(nick);
								int unReadMessage=0;
								for(ChatRoom mychatRoomList:mychatRoomLists)
								{
									ChatHistory chatHistory1= new ChatHistory();
									chatHistory1.setSendUser(nick);
									chatHistory1.setChatRoomNo(mychatRoomList.getChatRoomNo());
									int unread=cs.unReadMessage(chatHistory1);
									unReadMessage+=unread;
								}
								String unReadCount=Integer.toString(unReadMessage);
								String msg1="<div style=\"margin-top:  -10px;\" class=\"btn btn-info btn-sm\">";
								msg1+=unReadCount+"</div>&nbsp;Chat";
								if(unReadMessage>0)
								{
								if(ws != null)
								{
									ws.sendMessage(new TextMessage(msg1));
								}
								}
							}
						}
					}
				}
				else
				{
					if(ws2 != null)
					{
						String msg1 = "사용 가능한 대화 기회를 전부 사용하셨습니다<br> 총 입력 가능 메세지 수는 "+cutchat+"개 입니다<br>";
						if(cutchat==20)
						{
							msg1 += "<form action=\"carryOnChating.do\">\n" + 
									"				<table>\n" + 
									"				<tr>\n" + 
									"				<th colspan=\"2\" align=\"center\">\n" + 
									"				서로에 대한 평가후에 다시 채팅을 이어가실 수 있습니다<br>\n" + 
									"				"+targetUser+"님과의 채팅을 이어가시겠습니까?\n" + 
									"				<input type=\"hidden\" name=\"enterUser1\" value=\""+object.getString("from")+"\">\n" + 
									"				<input type=\"hidden\" name=\"chatRoomNo\" value=\""+chatRoomNo+"\">\n" + 
									"				</th></tr><tr align=\"center\">\n" + 
									"				<th align=\"center\"><input type=\"submit\" value=\"좋아요\" class=\"btn btn-info btn-sm\"></th>\n" + 
									"				<th align=\"center\">\n" + 
									"				<a class=\"btn btn-info btn-sm\"\n" + 
									"					href=\"endChating.do?enteruser1="+object.getString("from")+"&chatRoomNo="+chatRoomNo+"\">채팅을 그만하겠습니다</a>\n" + 
									"				</th>\n" + 
									"				</tr>\n" + 
									"				</table>\n" + 
									"				</form>";
							}
						if(cutchat==50)
						{
							List<SelLoc> selLocs=ss.selectLocation(chatRoomNo);
							
							msg1+="<form action=\"appointment.do\">\n" + 
									"<table>\n" + 
									"<tr>\n" + 
									"<th colspan=\"2\">서로 대화가 끝났다면 약속을 잡아보세요\n" + 
									"				<input type=\"hidden\" name=\"enterUser1\" value='"+object.getString("from")+"'>\n" + 
									"				<input type=\"hidden\" name=\"chatRoomNo\" value='"+chatRoomNo+"'>\n" + 
									"</th></tr>\n" + 
									"<tr>\n" + 
									"<th>\n" + 
									"<select name=\"location\" required=\"required\">\n" ;
									for(SelLoc selLoc : selLocs)
									{
									msg1+=	"<option>"+selLoc.getPlace()+"</option>\n";
									}
							msg1+=	"</select>\n" + 
									"</th>\n" + 
									"<th>\n" + 
									"<select name=\"appointmentTime\" required=\"required\">\n" + 
									"<option value=\"9~14\">9~14</option>\n" + 
									"<option value=\"14~18\">14~18</option>\n" + 
									"<option value=\"18~22\">18~22</option>\n" + 
									"</select>\n" + 
									"<input type=\"date\" name=\"appointmentdate\" required=\"required\"></th>\n" + 
									"</tr>\n" + 
									"<tr>\n" + 
									"<th>\n" + 
									"<input class=\"btn btn-info btn-sm\" type=\"submit\" value=\"약속 확인\"></th><th><a class=\"btn btn-info btn-sm\" href=\"endChating.do?enteruser1="+object.getString("from")+"&chatRoomNo="+chatRoomNo+"\">채팅 떠나기</a>\n" + 
									"</th>\n" + 
									"</tr>\n" + 
									"</table>\n" + 
									"</form>";
						}
						ws2.sendMessage(new TextMessage(msg1));
					}
				}
			}
			

		}
		
	}
	public void afterConnectionClosed(WebSocketSession session,CloseStatus status) throws Exception{
		System.out.println("연결 종료");
		users.remove(session);
	}

}
