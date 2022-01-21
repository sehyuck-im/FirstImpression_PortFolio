package com.finalproject.firstimpression.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.model.TagList;
import com.finalproject.firstimpression.model.MyPreference;
import com.finalproject.firstimpression.service.MemberService;
import com.finalproject.firstimpression.service.ProfileService;

@Controller
public class ProfileController {
	@Autowired
	private ProfileService ps;
	@Autowired
	private MemberService ms;
	@Autowired
	private HttpSession session;

	@RequestMapping("updateProfileForm.do")
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

		return "/profile/updateProfileForm";
	}

	@RequestMapping("updateProfile.do")
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

		return "/profile/updateProfile";
	}

	@RequestMapping("updatePreferenceForm.do")
	public String updatePreference(Model model, Member member, Profile profile, MyPreference preference) {
		String id = (String) session.getAttribute("id");
		profile = ps.selectProfileById(id);
		preference = ps.selectPreference(profile.getNick());
		List<String> tags = new ArrayList<String>();
		String myTag = preference.getTag();
		
		int tagCnt = ps.getTagCnt();
		for (int i = 1; i <= tagCnt; i++) {
			tags.add(ps.selectTag(i));
			tags.remove(myTag);
		}
		
		model.addAttribute("myTag", myTag);
		model.addAttribute("tags", tags);
		model.addAttribute("profile", profile);
		model.addAttribute("preference", preference);

		return "/profile/updatePreferenceForm";
	}

	@RequestMapping("updatePreference.do")
	public String updatePreference(Model model, Profile profile, MyPreference preference) {
		int result = 0;
		MyPreference preference2 = new MyPreference();
		preference2 = ps.selectPreference(preference.getNick());
		if (preference2 != null) {
			result = ps.updatePreference(preference);
		} else {
			result = -1; // 없는 nick
		}
		model.addAttribute("result", result);

		return "/profile/updatePreference";
	}
	@RequestMapping("myCard.do")
	public String myCard(Model model, Member member, Profile profile, String longitude, String latitude) {
		String id = (String) session.getAttribute("id");
		MyPreference preference = new MyPreference();
		member = ms.selectId(id);
		preference = ps.selectPreference(member.getNick());
		profile = ms.selectProfileById(id);
		if (longitude != null && !longitude.equals("undefined")) {
			float longgi = Float.parseFloat(longitude);
			float lati = Float.parseFloat(latitude);
			Location location = new Location();
			location.setLatitude(lati);
			location.setLongitude(longgi);
			location.setNick(profile.getNick());
			Location location2 = ms.selectlocation(profile.getNick());
			if (location2 == null) {
				ms.insertlocation(location);
			} else {
				ms.updatelocation(location);
			}
		}
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
		model.addAttribute("preference", preference);
		//추가
		
		Location loc = ms.selectlocation(member.getNick());
		float lati = loc.getLatitude();
		float longi = loc.getLongitude();
		
		model.addAttribute("lati", lati);
		model.addAttribute("longi", longi);
		
		
		return "/profile/myCard";
	}

}