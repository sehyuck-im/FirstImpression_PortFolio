package com.finalproject.firstimpression.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.finalproject.firstimpression.model.AnoFeed;
import com.finalproject.firstimpression.model.HashTag;
import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.MasterAnBoard;
import com.finalproject.firstimpression.model.MasterMemberInfo;
import com.finalproject.firstimpression.model.MatchingHistory;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.MemberLoc;
import com.finalproject.firstimpression.model.MyPreference;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.model.Reply;
import com.finalproject.firstimpression.model.Report;
import com.finalproject.firstimpression.model.SelLoc;
import com.finalproject.firstimpression.model.TagList;
import com.finalproject.firstimpression.service.AnoFeedService;
import com.finalproject.firstimpression.service.MatchingService;
import com.finalproject.firstimpression.service.MemberLocService;
import com.finalproject.firstimpression.service.MemberService;
import com.finalproject.firstimpression.service.ProfileService;
import com.finalproject.firstimpression.service.ReportService;
import com.finalproject.firstimpression.service.SelLocService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;



@Controller
public class SearchController {
	
	
	@Autowired
	private MemberService mms;	
	@Autowired
	private MemberLocService ms;
	@Autowired
	private MatchingService mc;
	@Autowired
	private ProfileService ps;
	@Autowired
	private SelLocService ss;
	@Autowired
	private MatchingService mcs;
	@Autowired
	private AnoFeedService as;
	@Autowired
	private ReportService rs;
	@Autowired
	private HttpSession session;
	
	
	
	@RequestMapping("search.do")
	public String search() {
		return "search";
	}
	
	@RequestMapping("location.do")
	public String location() {		
		
		return "location";
	}
	
	@RequestMapping("masterSiMain.do")
	public String masterSiMain(Model model) {
		
		List<String> dow = mc.selmaxdow();
		
		for(String doo: dow) {
			
			if(doo==null) {
				doo = "정보없음";
			}
			
		}
		
		model.addAttribute("dow", dow);
		
		
		
		
		
		Integer avgdow = mc.selavgdow();
		if(avgdow == null) {
			avgdow = 0;
		}
		model.addAttribute("avgdow", avgdow);
		
		Integer todayCnt = mc.seltodayCnt();
		if(todayCnt == null) {
			todayCnt = 0;
		}
		
		double todayAchRate3 =  ((double)todayCnt/(double)avgdow) * 100;
		double todayAchRate2 = Math.round(todayAchRate3);
		int todayAchRate = (int)todayAchRate2;
		model.addAttribute("todayAchRate", todayAchRate);

	
		
		double getTotal = mc.getTotal();
		double getTotalSl = mc.getTotalSl();
		double getTotalMm = mc.getTotalMm();
		
		model.addAttribute("getTotal", getTotal);
		model.addAttribute("getTotalSl", getTotalSl);
		model.addAttribute("getTotalMm", getTotalMm);		
		
		double matchingRate1 = (getTotalMm/getTotal)*100;
		int matchingRate = (int)matchingRate1;		
		//매칭 성공 그래프
		int firstMatching=mcs.firstMatchingCount();
		int secondMatching=mcs.secondMatchingCount();
		int matchmade=mcs.matchmadeCount();
		
		model.addAttribute("firstMatching",firstMatching);
		model.addAttribute("secondMatching",secondMatching);
		model.addAttribute("matchmade",matchmade);
		//매칭 성공 그래프
		
		//파이 차트 그래프
		int getMale=ps.getMale();
		int getFemale=ps.getFemale();
		int getBoth=ps.getBoth();
		
		model.addAttribute("getMale",getMale);
		model.addAttribute("getFemale",getFemale);
		model.addAttribute("getBoth",getBoth);
		
		model.addAttribute("matchingRate", matchingRate);
		
		return "/masterPage/masterSiMain";
	}
	
	
	@RequestMapping("anBoardTable.do")
	public String anBoardTable(Model model) {
		List<MasterAnBoard> masterAnBoard = as.selectMpList();
		model.addAttribute("list", masterAnBoard);
		
		for(MasterAnBoard masterAnBoard1: masterAnBoard)
		{
			String id=masterAnBoard1.getId();
			String name=masterAnBoard1.getName();
			int anNum=masterAnBoard1.getAnNum();
			String nick=masterAnBoard1.getNick();
			String anTitle=masterAnBoard1.getAnTitle();
			int likeCount=masterAnBoard1.getLikeCount();
			String anCheck=masterAnBoard1.getAnCheck();
			String anDel=masterAnBoard1.getAnDel();
			
			
			model.addAttribute("id", id);
			model.addAttribute("name", name);
			model.addAttribute("anNum",anNum);
			model.addAttribute("nick", nick);
			model.addAttribute("anTitle", anTitle);
			model.addAttribute("likeCount", likeCount);
			model.addAttribute("anCheck", anCheck);
			model.addAttribute("anDel", anDel);			
		}
		
		return "/masterPage/anBoardTable";
	}
	
	@RequestMapping("reportCheck.do")
	public String reportCheck(Model model, int repNum) {
		int result = rs.reportCheck(repNum);
		
		model.addAttribute("result", result);
		
		return "/masterPage/reportCheck";
	}
	
	
	@RequestMapping("anBoardView.do")
	public String anBoardView(Model model, int anNum) {
		
		AnoFeed anoFeed = as.selectanobynum(anNum);
		
		int anNum2 = anoFeed.getAnNum();
		String title = anoFeed.getAnTitle();
		String nick = anoFeed.getNick();
		String anCheck = anoFeed.getAnCheck();
		int likeCount = anoFeed.getLikeCount();
		List<HashTag> temphash=as.selecttagbynum(anNum);		
		String photo = anoFeed.getPhoto();
		String anContent = anoFeed.getAnContent();
		String anDel = anoFeed.getAnDel();
		
		model.addAttribute("anNum", anNum2);
		model.addAttribute("title", title);
		model.addAttribute("nick", nick);
		model.addAttribute("anCheck", anCheck);
		model.addAttribute("likeCount", likeCount);
		model.addAttribute("temphash", temphash);
		model.addAttribute("photo", photo);
		model.addAttribute("anContent", anContent);
		model.addAttribute("anDel", anDel);
		
		
		return "/masterPage/anBoardView";
	}
	
	@RequestMapping("anBoardDelete.do")
	public String anBoardDelete(Model model, int anNum) {
		int result = 0;
		result = as.deleteanobynum(anNum);
		as.deletelikebynum(anNum);
		model.addAttribute("result", result);		
		
		return "/masterPage/anBoardDelete";
	}
	
	@RequestMapping("anBoardRestore.do")
	public String anBoardRestore(Model model, int anNum) {
		int result = 0;
		result = as.restoreanobynum(anNum);
		
		model.addAttribute("result", result);		
		
		return "/masterPage/anBoardRestore";
	}
	
	@RequestMapping("memberDelete.do")
	public String memberDelete(Model model, String id) {
		int result = 0;
		result = mms.deleteMemberbyid(id);	
		Profile profile = ps.selectProfileById(id);
		ss.deleteLocation(profile.getNick());
		model.addAttribute("result", result);		
		
		return "/masterPage/memberDelete";
	}
	
	@RequestMapping("memberRestore.do")
	public String memberRestore(Model model, String id) {
		int result = 0;
		result = mms.restoreMemberbyid(id);		
		
		model.addAttribute("result", result);		
		
		return "/masterPage/memberRestore";
	}
	
	@RequestMapping("reportTable.do")
	public String reportTable(Model model) {
		List<Report> report = rs.selectReportM();
		model.addAttribute("list",report);
		
		return "/masterPage/reportTable";
	}
	
	@RequestMapping("peopleTable.do")
	public String peopleTable(Model model) {
		List<MasterMemberInfo> masterMemberInfo = mms.selectMasterMemberInfo();
		model.addAttribute("list", masterMemberInfo);
		
		for(MasterMemberInfo masterMemberInfo1: masterMemberInfo)
		{
			String id=masterMemberInfo1.getId();
			String name=masterMemberInfo1.getName();
			String nick=masterMemberInfo1.getNick();
			String email=masterMemberInfo1.getEmail();
			Date regDate=masterMemberInfo1.getRegDate();
			int age=masterMemberInfo1.getAge();
			String gender=masterMemberInfo1.getGender();
			String del=masterMemberInfo1.getDel();
			
			
			model.addAttribute("id", id);
			model.addAttribute("name", name);
			model.addAttribute("nick", nick);
			model.addAttribute("email", email);
			model.addAttribute("regDate", regDate);
			model.addAttribute("age", age);
			model.addAttribute("gender", gender);
			model.addAttribute("del", del);
		}
		return "/masterPage/peopleTable";
	}
	@RequestMapping("matchingTable.do")
	public String matchingTable(Model model) {
		
		List<MatchingHistory> list= mcs.selctList();
		model.addAttribute("list",list);
		return "/masterPage/matchingTable";
	}
	
	@RequestMapping("masterUpdateProfileForm.do")
	public String updateProfile(Model model, Member member, Profile profile) {
		String id = (String) session.getAttribute("id");
		profile = ps.selectProfileById(id);
		List<TagList> tags = ps.selectTags();
		List<String> tags2 = new ArrayList<String>();
		int tagCnt = ps.getTagCnt();
		for (int i = 1; i <= tagCnt; i++) {
			tags2.add(ps.selectTag(i));
		}
		List<Interest> itList = new ArrayList<Interest>();
		itList = ps.selectTempList(profile.getNick());
		for (Interest itList2 : itList) {
			tags2.remove(itList2.getTag());
			
		}
		
		String genderK = "";
		if (profile.getGender().equals("none")) {
			genderK = "공개안함";
		} else if (profile.getGender().equals("male")) {
			genderK = "남성";
		} else {
			genderK = "여성";
		}
		model.addAttribute("genderK", genderK);
		model.addAttribute("itList", itList);
		model.addAttribute("tags", tags);
		model.addAttribute("tags2", tags2);
		model.addAttribute("profile", profile);

		return "/masterPage/masterUpdateProfileForm";
	}
	
	@RequestMapping("masterUpdateProfile.do")
	public String updateProfile(Profile profile, Model model, String tags, String prePhoto1, String prePhoto2,
			String prePhoto3) throws IOException {
		int result = 0;
		String nick = profile.getNick();
		String gender = profile.getGender();
		String intro = profile.getIntro();
		Interest interest = new Interest();
		String real = session.getServletContext().getRealPath("/resources/profiles");
		String fileName4 = profile.getFile1().getOriginalFilename();
		String fileName5 = profile.getFile2().getOriginalFilename();
		String fileName6 = profile.getFile3().getOriginalFilename();
		
		if (!fileName4.equals("") || fileName4 != "") {
			UUID uuid1 = UUID.randomUUID();
			String fileName1 = uuid1 + fileName4.substring(fileName4.lastIndexOf("."));
			FileOutputStream fos1 = new FileOutputStream(new File(real + "/" + fileName1));
			fos1.write(profile.getFile1().getBytes());
			profile.setPhoto1(fileName1);
			fos1.close();
		} else {
			profile.setPhoto1(prePhoto1);
		}
		if (!fileName5.equals("") || fileName5 != "") {
			UUID uuid2 = UUID.randomUUID();
			String fileName2 = uuid2 + fileName5.substring(fileName5.lastIndexOf("."));
			FileOutputStream fos2 = new FileOutputStream(new File(real + "/" + fileName2));
			fos2.write(profile.getFile2().getBytes());
			profile.setPhoto2(fileName2);
			fos2.close();
		} else {
			profile.setPhoto2(prePhoto2);
		}
		if (!fileName6.equals("") || fileName6 != "") {
			UUID uuid3 = UUID.randomUUID();
			String fileName3 = uuid3 + fileName6.substring(fileName6.lastIndexOf("."));
			FileOutputStream fos3 = new FileOutputStream(new File(real + "/" + fileName3));
			fos3.write(profile.getFile3().getBytes());
			profile.setPhoto3(fileName3);
			fos3.close();
		} else {
			profile.setPhoto3(prePhoto3);
		}

		if (profile != null) {

			profile.setGender(gender);
			profile.setIntro(intro);
			if (tags != null) {
				String[] tagList = tags.split(",");
				int tagCnt = ps.selectTagCnt(nick);
				if (tagCnt > 0) {
					List<Interest> tempList = new ArrayList<Interest>();
					tempList = ps.selectTempList(nick);
					ps.saveTempList(tempList); // tempList에 백업
					ps.deleteInterest(nick); // 전에 있던 interest 삭제
				}

				for (int i = 0; i < tagList.length; i++) {
					String tag = tagList[i];
					interest.setNick(profile.getNick());
					interest.setTag(tag);
					ps.insertInterest(interest);
				}
			} else {
				result = -1; // 없는 아이디는 업데이트 못하지
			}
			result = ps.updateProfile(profile);
			if (result == 0 || result == -1) {
				List<Interest> backUp = new ArrayList<Interest>();
				backUp = ps.rollbackInterest(nick); // backUp 데이터 받아오기
				ps.insertBackUp(backUp); // backup 데이터 넣기
			}
			ps.deleteTempInterest(nick);
		}
		model.addAttribute("result", result);

		return "/masterPage/masterUpdateProfile";
	}
	
	@RequestMapping("memberView.do")
	public String siMain(Model model, Member member, Profile profile, String id) {
		String mid = id;
		MyPreference preference = new MyPreference();
		member = mms.selectId(mid);
		preference = ps.selectPreference(member.getNick());
		profile = mms.selectProfileById(mid);		
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
		
		model.addAttribute("id", mid);
		model.addAttribute("itList", itList);
		model.addAttribute("member", member);
		model.addAttribute("profile", profile);
		model.addAttribute("gender", identity);
		model.addAttribute("preference", preference);
		
		
		return "/masterPage/memberView";
	}
	
	
	
	
	@RequestMapping("locationResult.do")
	public String locationResult(Model model, String latitude, String longitude) {
				
		 String id = (String) session.getAttribute("id"); 
		 MemberLoc memberLoc = new MemberLoc(); 
		 memberLoc.setId(id); 
		 memberLoc.setLatitude(latitude);		 
		 memberLoc.setLongitude(longitude);
		 
		 //ms.insertMemberLoc(memberLoc);
		 ms.updateMemberLoc(memberLoc);
		 
		 model.addAttribute("memberLoc", memberLoc);
		
		 
		 StringBuffer sb; 
		 String clientId = "k8221vnqwi";
		 String clientSecret = "iFFo9WUYBYVd0nRNfBocQuIlUVmrV9rzJzsutkYL";
		 double latitudeD = Double.parseDouble(latitude);
		 double longitudeD = Double.parseDouble(longitude);
		 
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
				
				String result = sb.toString();				
				model.addAttribute("result", result);
				
				JsonParser parser = new JsonParser();			
				JsonObject items = (JsonObject)parser.parse(result);
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
				
				String address = sii+" "+guu+" "+dong;
				
				model.addAttribute("address", address);
				
				
			} catch (Exception e) { 
				System.out.println(e);
			}
 
		 
		return "locationResult";
	}
	
	
	@RequestMapping("locationResult2.do")
	public String locationResult2(Model model, String address) {		
		
		StringBuffer sb;
		String clientId = "krzSNp7JMQQTanZtRTNO";
		String clientSecret = "kedSXVvLYM";
		
		
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
				String result = sb.toString();
				
				JsonParser parser = new JsonParser();			
				JsonObject items = (JsonObject)parser.parse(result);
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
				selLoc.setChatRoomNo("1");
				selLoc.setPlace(rTitle); 
				selLoc.setPlaceAddr(rAddress);				 
				ss.insertSelLoc(selLoc);
				
			
			}
			
			
		} catch (Exception e) { 
			System.out.println(e);
		}
		
		
		
		
		
				
		return "locationResult2";
	}
	
}
