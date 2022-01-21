package com.finalproject.firstimpression.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.Matching;
import com.finalproject.firstimpression.model.MatchingHistory;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.model.SelLoc;
import com.finalproject.firstimpression.model.MyPreference;
import com.finalproject.firstimpression.service.ChatService;
import com.finalproject.firstimpression.service.MatchingService;
import com.finalproject.firstimpression.service.MemberService;
import com.finalproject.firstimpression.service.ProfileService;
import com.finalproject.firstimpression.service.SelLocService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.finalproject.firstimpression.model.Appointment;
import com.finalproject.firstimpression.model.ChatHistory;
import com.finalproject.firstimpression.model.ChatRoom;

@Controller
public class MatchingController {
	@Autowired
	private ChatService cs;
	@Autowired
	private MatchingService mcs;
	@Autowired
	private MemberService ms;
	@Autowired
	private ProfileService ps;
	@Autowired
	private HttpSession session;
	@Autowired
	private SelLocService ss;
@RequestMapping("matching.do")
public String matching(Model model) {
	String id=(String)session.getAttribute("id");
	Profile profile1=ms.selectProfileById(id);
	Location location=ms.selectlocation(profile1.getNick());
	MatchingHistory matchingHistory=new MatchingHistory();
	MatchingHistory matchingHistory2=new MatchingHistory();
	Profile profile=new Profile();
	int matchingCount=0;
	int firstmatch=1;
	int secondmatch=1;
	int thirdmatch=1;
	int photocheck=0;
	
	if(profile1.getPhoto1()!=null)
	{
	while(true){
	List<Location> locations=mcs.startMatching(location);
	
	Collections.shuffle(locations);
	if(locations.size()!=0)
	{
		profile=ms.selectProfileByNick(locations.get(0).getNick());
	}else
	{ 	
		profile=null;
		break;
	}
	

	
	if(profile!=null)
	{
	if(profile.getPhoto1()==null)
	{
		photocheck=0;
	}
	else
	{
		photocheck=1;
	
	}
	String MachedNick=profile.getNick();
	String MachingNick=profile1.getNick();
	MyPreference myprPreference=ps.selectPreference(MachingNick);
	if(myprPreference.getGender()!=null)
	{
	firstmatch=0;
	secondmatch=0;
	thirdmatch=0;
	String machedGender=profile.getGender();
	int machedAge=profile.getAge();
	Interest interest=new Interest();
	if(myprPreference.getTag().equals("None"))
	{
		thirdmatch=1;
	}else
	{
		interest.setNick(MachedNick);
		interest.setTag(myprPreference.getTag());
		Interest interest2=mcs.selectInterest(interest);
		if(interest2!=null)
		{
			thirdmatch=1;
		}
	}
	if(myprPreference.getGender().equals("both"))
	{
		firstmatch=1;
	}else
	{
		if(machedGender.equals(myprPreference.getGender()))
		{
			firstmatch=1;
		}	
	}
		if(myprPreference.getMinAge()<= machedAge && machedAge <= myprPreference.getMaxAge())
		{
			secondmatch=1;
		}
		

	}
	//상대와의 거리
	
	Location location1=ms.selectlocation(profile1.getNick());
	Float latitude1=location1.getLatitude();
	Float longitude1=location1.getLongitude();
	String latitudeS1=Float.toString(latitude1);
	String longitudeS1=Float.toString(longitude1);
	Double latitudeD1=Double.parseDouble(latitudeS1);
	Double longitudeD1=Double.parseDouble(longitudeS1);
	
	Location location2=ms.selectlocation(profile.getNick());
	Float latitude=location2.getLatitude();
	Float longitude=location2.getLongitude();
	String latitudeS=Float.toString(latitude);
	String longitudeS=Float.toString(longitude);
	Double latitudeD=Double.parseDouble(latitudeS);
	Double longitudeD=Double.parseDouble(longitudeS);
	
	double distanceKiloMeter =
            distance(latitudeD1, longitudeD1, latitudeD, longitudeD, "kilometer");
	distanceKiloMeter=Math.round(distanceKiloMeter*1000)/1000.0;
	profile.setDistance(distanceKiloMeter);
	//상대와의 거리
	MatchingHistory matchingHistory1=new MatchingHistory();
	matchingHistory1.setNickWhoLiked(MachingNick);
	matchingHistory1.setTargetNick(MachedNick);
	matchingHistory=mcs.selectMatchingHistory(matchingHistory1);
	matchingHistory1.setNickWhoLiked(MachedNick);
	matchingHistory1.setTargetNick(MachingNick);
	matchingHistory2=mcs.selectMatchingHistory(matchingHistory1);
	matchingCount +=1;
	
	List<Interest> itList = new ArrayList<Interest>();
	String identity="";
	if(profile != null) {
	itList = ps.selectTempList(profile.getNick());
	if(profile.getGender().equals("male")) {
		identity = "남성";
	} else if (profile.getGender().equals("female")) {
		identity = "여성";
	} else if (profile.getGender().equals("both")) {
		identity = "양성";
	} else {
		identity = "";
	}
	}
	
	model.addAttribute("gender", identity);
	model.addAttribute("itList", itList);
	
	if((matchingHistory == null && matchingHistory2 == null)&&(firstmatch==1&&secondmatch==1&&thirdmatch==1&&photocheck==1)||matchingCount==100)
	{
		if(matchingCount==100)
		{
			profile=null;
		}
		break;
	}
	
	
	}
	}
	}
	else
	{
		if(profile.getPhoto1()==null)
		{
			profile=null;
		}
		if(profile1.getPhoto1()==null)			{
			profile=null;
		}
	}
	
	Member member = ms.selectId(id);
	List<Interest> interest=new ArrayList<Interest>();
	if(profile!=null)
	{
	interest = ps.selectTempList(profile.getNick());
	}
	// 추가한 부분
	Location location2=new Location();
	if(profile!=null)
	{
		location2 = ms.selectlocation(profile.getNick());
	}
	if(profile!=null)
	{
	profile.setLocation(location2);
	profile.setInterest(interest);
	}
	String lastTime = "";
	if(profile!=null)
	{
	int signTime = ms.calTime(location2);
	int signTimeHour = 0;
	int signTimeDay = 0;
	
	if(signTime >= 60) {
		signTimeHour = signTime / 60; 
		if(signTimeHour >= 24) {
			signTimeDay = signTimeHour / 24;
		}
	}
	if(signTimeDay > 0) {
		lastTime += signTimeDay+"일";
	} else {
		if(signTimeHour > 0) {
			lastTime += signTimeHour+"시간";
		}
		if(signTime < 60) {
			lastTime += signTime+"분";
		} else {
			lastTime += signTime%60+"분";
		}
	}
	
	profile.setSignInTime(lastTime);
	}
	model.addAttribute("member", member);
	model.addAttribute("profile", profile);
	
	
	return "/matching/matching";
}
@RequestMapping("addMatching.do")
public String addMatching(Model model,String nick) {
	
	String id=(String)session.getAttribute("id");
	Profile profile=ms.selectProfileById(id);
	Matching matching=new Matching();
	matching.setMatchingId(profile.getNick());
	matching.setTargetId(nick);
	int result=1;
	result=mcs.insertMatching(matching);
	if(result>0)
	{
		MatchingHistory matchingHistory=new MatchingHistory();
		matchingHistory.setNickWhoLiked(profile.getNick());
		matchingHistory.setTargetNick(nick);
		mcs.insertMatchingHistory(matchingHistory);
	}
	model.addAttribute("result",result);
	return "/chating/addMatching";
}
@RequestMapping("addChating.do")
public String addChating(Model model,String nick) {
	String id=(String)session.getAttribute("id");
	Profile profile=ms.selectProfileById(id);
	int result=1;
	String uuid=UUID.randomUUID().toString();
	ChatRoom chatRoom=new ChatRoom();
	chatRoom.setEnterUser1(profile.getNick());
	chatRoom.setEnterUser2(nick);
	Matching matching=new Matching();
	matching.setMatchingId(nick);
	matching.setTargetId(profile.getNick());
	ChatRoom chatRoom2=cs.select(chatRoom);
	ChatRoom chatRoom3= new ChatRoom();
	if(chatRoom2==null)
	{
		chatRoom3.setEnterUser1(chatRoom.getEnterUser2());
		chatRoom3.setEnterUser2(chatRoom.getEnterUser1());
		chatRoom3.setChatRoomNo(uuid);
		chatRoom.setChatRoomNo(uuid);
		cs.insert(chatRoom);
		cs.insert(chatRoom3);
		mcs.delete(matching);
		MatchingHistory matchingHistory=new MatchingHistory();
		matchingHistory.setNickWhoLiked(nick);
		matchingHistory.setTargetNick(profile.getNick());
		mcs.updateFirstLike(matchingHistory);
		model.addAttribute("result",result);
		return "/chating/addChating";

	}
	else
	{
		result=0;
		model.addAttribute("result",result);
		return "/chating/addChating";
	}

}
@RequestMapping("chatingList.do")
public String chatingList(Model model) {
	String id=(String)session.getAttribute("id");
	Profile profile=ms.selectProfileById(id);
	List<ChatRoom> chatRooms=cs.selectMychatRoom(profile.getNick());
	List<ChatRoom> chatRooms2=cs.selectMychatRoom2(profile.getNick());
	model.addAttribute("profile",profile);
	model.addAttribute("chatRooms",chatRooms);
	model.addAttribute("chatRooms2",chatRooms2);
	return "/chating/chatingList";
}
@RequestMapping("likeList.do")
public String likeList(Model modle)
{
	

	String id=(String)session.getAttribute("id");
	Profile profile1=ms.selectProfileById(id);
	String myNick=profile1.getNick();
	Location location1=ms.selectlocation(myNick);
	Float latitude1=location1.getLatitude();
	Float longitude1=location1.getLongitude();
	String latitudeS1=Float.toString(latitude1);
	String longitudeS1=Float.toString(longitude1);
	Double latitudeD1=Double.parseDouble(latitudeS1);
	Double longitudeD1=Double.parseDouble(longitudeS1);
	List<Profile> profiles=new ArrayList<Profile>();
	List<Matching> matchings=mcs.selectMatchingList(myNick);
	for(Matching matching : matchings)
	{
		Profile profile=ps.selectProfileByNick(matching.getMatchingId());
		Location location=ms.selectlocation(profile.getNick());
		Float latitude=location.getLatitude();
		Float longitude=location.getLongitude();
		String latitudeS=Float.toString(latitude);
		String longitudeS=Float.toString(longitude);
		Double latitudeD=Double.parseDouble(latitudeS);
		Double longitudeD=Double.parseDouble(longitudeS);
		
		double distanceKiloMeter =
	            distance(latitudeD1, longitudeD1, latitudeD, longitudeD, "kilometer");
		distanceKiloMeter=Math.round(distanceKiloMeter*1000)/1000.0;
		profile.setDistance(distanceKiloMeter);
		// 추가한 부분
		List<Interest> interest = ps.selectTempList(profile.getNick());
		Location location2 = ms.selectlocation(profile.getNick());
		profile.setLocation(location2);
		
		profile.setInterest(interest);
		String lastTime = "";
		int signTime = ms.calTime(location2);
		int signTimeHour = 0;
		int signTimeDay = 0;
		
		if(signTime >= 60) {
			signTimeHour = signTime / 60; 
			if(signTimeHour >= 24) {
				signTimeDay = signTimeHour / 24;
			}
		}
		if(signTimeDay > 0) {
			lastTime += signTimeDay+"일";
		} else {
			if(signTimeHour > 0) {
				lastTime += signTimeHour+"시간";
			}
			if(signTime < 60) {
				lastTime += signTime+"분";
			} else {
				lastTime += signTime%60+"분";
			}
		}
		
		profile.setSignInTime(lastTime);
		profiles.add(profile);
	}
	modle.addAttribute("profiles",profiles);
	return "/matching/likeList";
}
private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
    
    double theta = lon1 - lon2;
    double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
     
    dist = Math.acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
     
    if (unit == "kilometer") {
        dist = dist * 1.609344;
    } else if(unit == "meter"){
        dist = dist * 1609.344;
    }

    return (dist);
}
 

// This function converts decimal degrees to radians
private static double deg2rad(double deg) {
    return (deg * Math.PI / 180.0);
}
 
// This function converts radians to decimal degrees
private static double rad2deg(double rad) {
    return (rad * 180 / Math.PI);
}
@RequestMapping("chat.do")
public String chat(Model model,String enterUser1,String enterUser2)
{
	ChatRoom chatRoom= new ChatRoom(); 
	chatRoom.setEnterUser1(enterUser1);
	chatRoom.setEnterUser2(enterUser2);
	String uuid=UUID.randomUUID().toString();
	ChatRoom chatRoom2=cs.select(chatRoom);
	if(chatRoom2==null)
	{
		ChatRoom chatRoom3= new ChatRoom();
		chatRoom3.setEnterUser1(chatRoom.getEnterUser2());
		chatRoom3.setEnterUser2(chatRoom.getEnterUser1());
		chatRoom2=cs.select(chatRoom3);
		if(chatRoom2==null)
		{
			chatRoom.setChatRoomNo(uuid);
			model.addAttribute("chatRoom",chatRoom);
			return "/chating/chat";
		}
		else {
			chatRoom.setChatRoomNo(chatRoom2.getChatRoomNo());
			model.addAttribute("chatRoom",chatRoom);
			return "/chating/chat";
		}	
	}
	else {
		model.addAttribute("chatRoom",chatRoom2);
		return "/chating/chat";
	}
}
@RequestMapping("carryOnChating.do")
public String carryOnChating(Model model,String enterUser1,String chatRoomNo)
{
	int result=1;
	ChatRoom chatRoom=new ChatRoom();
	chatRoom.setEnterUser1(enterUser1);
	chatRoom.setChatRoomNo(chatRoomNo);
	ChatRoom chatRoom1=cs.selectChatbyChatRoom(chatRoom);
	String target=chatRoom1.getEnterUser2();
	int carryOnCheck=chatRoom1.getCarryOnCheck();
	MatchingHistory matchingHistory=new MatchingHistory();
	matchingHistory.setNickWhoLiked(enterUser1);
	matchingHistory.setTargetNick(target);
	MatchingHistory matchingHistory2=mcs.selectMatchingHistory(matchingHistory);
	if(matchingHistory2==null)
	{
		matchingHistory.setNickWhoLiked(target);
		matchingHistory.setTargetNick(enterUser1);
		matchingHistory2=mcs.selectMatchingHistory(matchingHistory);
	}
	if(carryOnCheck==0)
	{
		matchingHistory2.setSecondLike(1);
		mcs.updateSecondLike(matchingHistory2);
		chatRoom.setCarryOnCheck(1);
		chatRoom.setCarryOnNick(enterUser1);
		result=1;
		cs.updateCarryOnCheck(chatRoom);
		ChatHistory chatHistory=new ChatHistory();
		String msg3=enterUser1+"님이 당신과의 채팅을 좋아요 했습니다";
		String content="<div class=\"media-body ml-3\"><div class=\"bg-light rounded py-2 px-3 mb-2\"><p class=\"text-small mb-0 text-muted\" style=\"color: black !important;\">"+msg3+"</p></div></div></div>";
		chatHistory.setChatRoomNo(chatRoomNo);
		chatHistory.setMessage(content);
		chatHistory.setSendUser("FirstImpression");
		chatHistory.setReadCount(1);
		cs.insertMessage(chatHistory);
		chatRoom.setEnterUser1(target);
		cs.updateCarryOnCheck(chatRoom);
	}
	else if(carryOnCheck==1)
	{
		ChatRoom tempchatChatRoom= mcs.chklikenick(chatRoom);
		if(tempchatChatRoom.getCarryOnNick().equals(enterUser1))
		{
			result=1;
			chatRoom.setCarryOnCheck(1);
			chatRoom.setCarryOnNick(enterUser1);
			cs.updateCarryOnCheck(chatRoom);
		}
		else {
		matchingHistory2.setSecondLike(2);
		mcs.updateSecondLike(matchingHistory2);
		chatRoom.setCarryOnCheck(2);
		chatRoom.setCarryOnNick(enterUser1);
		result=2;
		cs.updateCarryOnCheck(chatRoom);
		ChatHistory chatHistory=new ChatHistory();
		//현재 위치 기반 추천장소 서비스
		StringBuffer sb;
		 String clientId = "k8221vnqwi";
		 String clientSecret = "iFFo9WUYBYVd0nRNfBocQuIlUVmrV9rzJzsutkYL";
		Location location=ms.selectlocation(enterUser1);
		Float latitude=location.getLatitude();
		Float longitude=location.getLongitude();
		String latitudeS=Float.toString(latitude);
		String longitudeS=Float.toString(longitude);
		Double latitudeD=Double.parseDouble(latitudeS);
		Double longitudeD=Double.parseDouble(longitudeS);
		String address="";
		 try { 	
				String apiURL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords="+longitudeD+","+latitudeD+"&sourcecrs=epsg:4326&orders=addr&output=json";

				URL url = new URL(apiURL); 
				HttpURLConnection con = (HttpURLConnection) url.openConnection();

				con.setRequestMethod("GET"); 
				con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId); 
				con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret); 
				int responseCode = con.getResponseCode(); 
				BufferedReader br; 
				if (responseCode == 200) { 
					br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8")); 
					} else { 
						br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8")); 
						} 
				sb = new StringBuffer(); 
				String line; 
				
				while ((line = br.readLine()) != null) { 				
				sb.append(line).append("\n");
								
						}				
				br.close();
				con.disconnect();
				
				String result2 = sb.toString();				

				
				JsonParser parser = new JsonParser();			
				JsonObject items = (JsonObject)parser.parse(result2);
				JsonArray arr = (JsonArray)items.get("results");
				JsonObject item1 = (JsonObject)arr.get(0);	
				JsonObject region = (JsonObject)item1.get("region");
				JsonObject area1 = (JsonObject)region.get("area1");
				String sii = (String)area1.get("name").toString();
				JsonObject area2 = (JsonObject)region.get("area2");
				String guu = (String)area2.get("name").toString();
				JsonObject area3 = (JsonObject)region.get("area3");
				String dong = (String)area3.get("name").toString();
				
				sii = sii.replaceAll("\\\"","");
				guu = guu.replaceAll("\\\"","");
				dong = dong.replaceAll("\\\"","");				
				
				address = sii+" "+guu+" "+dong;
				
				model.addAttribute("address", address);
				
				
			} catch (Exception e) { 
				System.out.println(e);
			}
		clientId = "krzSNp7JMQQTanZtRTNO";
		clientSecret = "kedSXVvLYM";
		 try { 	
				//String Loc = "서울 종로구 평창동";
							
				String category1 = "레스토랑";
				String category2 = "카페";
				String category3 = "맥주";
				
				List<String> category = Arrays.asList(category1,category2,category3);
				
				
				for(int i=0;i<category.size();i++) {
					String searchWord = address+" "+category.get(i);
					
					String finalText = URLEncoder.encode(searchWord, "UTF-8"); 
					String apiURL = "https://openapi.naver.com/v1/search/local.json?query="+finalText+"&display=3"; 
					URL url = new URL(apiURL); 
					HttpURLConnection con = (HttpURLConnection) url.openConnection();

					con.setRequestMethod("GET"); 
					con.setRequestProperty("X-Naver-Client-Id", clientId); 
					con.setRequestProperty("X-Naver-Client-Secret", clientSecret); 
					int responseCode = con.getResponseCode(); 
					BufferedReader br;
					
					if (responseCode == 200) { 
						br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8")); 
						} else { 
							br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8")); 
							}
					sb = new StringBuffer(); 
					
					String line; 
					
					while ((line = br.readLine()) != null) { 				
					sb.append(line).append("\n");
					
							}			
					br.close(); 			
					con.disconnect();
					String result2 = sb.toString();
					
					JsonParser parser = new JsonParser();			
					JsonObject items = (JsonObject)parser.parse(result2);
					JsonArray arr = (JsonArray)items.get("items");
					
					JsonObject item1 = (JsonObject)arr.get(0);
					String title1 = (String)item1.get("title").toString();
					String addr1 = (String)item1.get("address").toString();
					
					JsonObject item2 = (JsonObject)arr.get(1);
					String title2 = (String)item2.get("title").toString();
					String addr2 = (String)item2.get("address").toString();
					
					JsonObject item3 = (JsonObject)arr.get(2);
					String title3 = (String)item3.get("title").toString();
					String addr3 = (String)item3.get("address").toString();
								
					
					Map<String,String> map = new HashMap<String, String>();
					map.put(title1, addr1);
					map.put(title2, addr2);
					map.put(title3, addr3);				
					
					Random random = new Random();
					List<String> keys = new ArrayList<String>(map.keySet());
					String rTitle = keys.get(random.nextInt(keys.size()));
					String rAddress = map.get(rTitle);
					
					String str = String.valueOf(i);
					
					model.addAttribute("rTitle"+str, rTitle);
					model.addAttribute("rAddress"+str, rAddress);
					
					SelLoc selLoc = new SelLoc(); 
					selLoc.setCondition(category.get(i));
					selLoc.setChatRoomNo(chatRoomNo);
					selLoc.setPlace(rTitle); 
					selLoc.setPlaceAddr(rAddress);				 
					ss.insertSelLoc(selLoc);
					
				
				}
				
				
			} catch (Exception e) { 
				System.out.println(e);
			}
		
		
		
		
		
		
		List<SelLoc> selLocs=ss.selectLocation(chatRoomNo);
		String msg2="";
		msg2="현재 위치 기반으로 추천된 첫만남 장소입니다<br>";
		for(SelLoc selLoc1: selLocs)
		{
			String title=selLoc1.getPlace();
			String address1=selLoc1.getPlaceAddr();
			
			msg2 +="업체명:"+title+"<br>주소:"+address1+"<br>";
		}
		String content="<div class=\"media-body ml-3\"><div class=\"bg-light rounded py-2 px-3 mb-2\"><p class=\"text-small mb-0 text-muted\" style=\"color: black !important;\">"+msg2+"</p></div></div></div>";

		//현재 위치 기반 추천장소 서비스
		chatHistory.setChatRoomNo(chatRoomNo);
		chatHistory.setMessage(content);
		chatHistory.setSendUser("FirstImpression");
		chatHistory.setReadCount(1);
		cs.insertMessage(chatHistory);
		chatRoom.setEnterUser1(target);
		cs.updateCarryOnCheck(chatRoom);
	}
	}
	model.addAttribute("result",result);
	return "/chating/carryOnChating";
}
@RequestMapping("endChating.do")
public String endChating(Model model,String enteruser1,String chatRoomNo)
{
	int result=1;
	ChatRoom chatRoom=new ChatRoom();
	chatRoom.setEnterUser1(enteruser1);
	chatRoom.setChatRoomNo(chatRoomNo);
	cs.deleteChatingRoom(chatRoom);
	ChatHistory chatHistory=new ChatHistory();
	chatHistory.setChatRoomNo(chatRoomNo);
	chatHistory.setMessage(enteruser1+"님이 당신과의 채팅을 종료 했습니다. 다른 좋은 상대방과의 대화를 이어가 보세요");
	chatHistory.setSendUser("FirstImpression");
	chatHistory.setReadCount(1);
	cs.insertMessage(chatHistory);
	model.addAttribute("result",result);
	return "/chating/endChating";
}
@RequestMapping("appointment.do")
public String appointment(Model model,String enterUser1,String chatRoomNo,String location,String appointmentTime ,Date appointmentdate)
{
	int result=0;
	Appointment appointment=new Appointment();
	appointment.setAppnick(enterUser1);
	appointment.setAppointmentdate(appointmentdate);
	appointment.setAppointmentTime(appointmentTime);
	appointment.setChatRoomNo(chatRoomNo);
	appointment.setLocation(location);
	
	ChatRoom chatRoom=new ChatRoom();
	chatRoom.setEnterUser1(enterUser1);
	chatRoom.setChatRoomNo(chatRoomNo);
	ChatRoom chatRoom1=cs.selectChatbyChatRoom(chatRoom);
	String target=chatRoom1.getEnterUser2();
	MatchingHistory matchingHistory=new MatchingHistory();
	matchingHistory.setNickWhoLiked(enterUser1);
	matchingHistory.setTargetNick(target);
	MatchingHistory matchingHistory2=mcs.selectMatchingHistory(matchingHistory);
	if(matchingHistory2==null)
	{
		matchingHistory.setNickWhoLiked(target);
		matchingHistory.setTargetNick(enterUser1);
		matchingHistory2=mcs.selectMatchingHistory(matchingHistory);
	}
	if(matchingHistory2.getMeetMade()==0)
	{
		matchingHistory2.setMeetMade(1);
		ChatHistory chatHistory=new ChatHistory();
		String msg3=enterUser1+"님이 당신과 약속을 등록 했습니다<br>장소:"+location+"<br>날자:"+appointmentdate+"<br>시간:"+appointmentTime;
		String content="<div class=\"media-body ml-3\"><div class=\"bg-light rounded py-2 px-3 mb-2\"><p class=\"text-small mb-0 text-muted\" style=\"color: black !important;\">"+msg3+"</p></div></div></div>";
		chatHistory.setChatRoomNo(chatRoomNo);
		chatHistory.setMessage(content);
		chatHistory.setSendUser("FirstImpression");
		chatHistory.setReadCount(1);
		cs.insertMessage(chatHistory);
		result=cs.updateMeetMade(matchingHistory2);
		result=cs.insertAppointmentCheck(appointment);
	}
	else {
		Appointment appointment2=mcs.selectApoOne(appointment);
		if(appointment2!=null)
		{
			matchingHistory2.setMeetMade(1);
			ChatHistory chatHistory=new ChatHistory();
			String msg3=enterUser1+"님이 당신과 약속을 수정 했습니다<br>장소:"+location+"<br>날자:"+appointmentdate+"<br>시간:"+appointmentTime;
			String content="<div class=\"media-body ml-3\"><div class=\"bg-light rounded py-2 px-3 mb-2\"><p class=\"text-small mb-0 text-muted\" style=\"color: black !important;\">"+msg3+"</p></div></div></div>";
			chatHistory.setChatRoomNo(chatRoomNo);
			chatHistory.setMessage(content);
			chatHistory.setSendUser("FirstImpression");
			chatHistory.setReadCount(1);
			cs.insertMessage(chatHistory);
			result=cs.updateMeetMade(matchingHistory2);
			result=cs.updateAppointment(appointment);
		}
		else {
			matchingHistory2.setMeetMade(2);
			result=cs.updateMeetMade(matchingHistory2);
			result=cs.updateAppointment(appointment);
			ChatRoom chatRoom2=new ChatRoom();
			chatRoom2.setEnterUser1(enterUser1);
			chatRoom2.setChatRoomNo(chatRoomNo);
			cs.deleteChatingRoom(chatRoom2);
			chatRoom2.setEnterUser1(target);
			chatRoom2.setChatRoomNo(chatRoomNo);
			cs.deleteChatingRoom(chatRoom2);
		}
		
	}
	
	
	model.addAttribute("result",result);
	return "/chating/appointment";
}
@RequestMapping("userProfile.do")
public String userProfile(Model model,String nick ) {
	String id = (String) session.getAttribute("id");
	Member member = ms.selectId(id);
	Profile profile=ms.selectProfileByNick(nick);
	String identity = "";
	if (profile.getGender() != null) {
		if (profile.getGender().equals("male")) {
			identity = "남성";
		} else if (profile.getGender().equals("female")) {
			identity = "여성";
		}
	} else {
		identity = "";
	}
	List<Interest> itList = new ArrayList<Interest>();
	itList = ps.selectTempList(profile.getNick());
	model.addAttribute("itList", itList);
	model.addAttribute("member", member);
	model.addAttribute("profile", profile);
	model.addAttribute("gender", identity);
	return "/profile/userProfile";
}
}
