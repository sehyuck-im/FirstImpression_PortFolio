package com.finalproject.firstimpression.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalproject.firstimpression.model.AnoFeed;
import com.finalproject.firstimpression.model.HashTag;

import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.LikeFeed;
import com.finalproject.firstimpression.model.Location;

import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.MyPreference;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.model.Reply;
import com.finalproject.firstimpression.model.Report;
import com.finalproject.firstimpression.service.AnoFeedService;

import com.finalproject.firstimpression.model.ShowCondition;
import com.finalproject.firstimpression.model.TagList;
import com.finalproject.firstimpression.service.AnoFeedService;
import com.finalproject.firstimpression.service.MatchingService;

import com.finalproject.firstimpression.service.MemberService;
import com.finalproject.firstimpression.service.ProfileService;

@Controller
public class FeedController {
	@Autowired
	private MemberService ms;
	@Autowired
	private ProfileService ps;
	@Autowired
	private AnoFeedService as;
	@Autowired
	private HttpSession session;
	@Autowired
	private MatchingService mcs;

	@RequestMapping("feedMain.do")
	public String boardMain(Model model, Profile profile, Member member, AnoFeed anoFeed) {
		String id = (String) session.getAttribute("id");
		profile = ms.selectProfileById(id);
		member = ms.selectId(id);

		model.addAttribute("profile", profile);
		model.addAttribute("member", member);

		return "/anoFeed/feedMain";
	}

	@RequestMapping("feedWriteForm.do")
	public String boardWrite(Model model, Profile profile, AnoFeed anoFeed) {
		String id = (String) session.getAttribute("id");
		profile = ms.selectProfileById(id);
		List<String> tags = new ArrayList<String>();
		int tagCnt = ps.getTagCnt();
		for (int i = 1; i <= tagCnt; i++) {
			tags.add(ps.selectTag(i));
		}
		model.addAttribute("tags", tags);
		model.addAttribute("profile", profile);
		return "/anoFeed/feedWriteForm";
	}

	@RequestMapping("feedWrite.do")
	public String feedWrite(Model model, Profile profile, AnoFeed anoFeed, String tags) throws IOException {
		String id = (String) session.getAttribute("id");
		profile = ms.selectProfileById(id);
		int result = 0;
		String fileName = anoFeed.getFile().getOriginalFilename();

		if (!fileName.equals("")) {
			String real = session.getServletContext().getRealPath("/resources/feed");
			
			UUID uuid = UUID.randomUUID();
			String photo = "feed" + uuid + fileName.substring(fileName.lastIndexOf("."));
			FileOutputStream fos1 = new FileOutputStream(new File(real + "/" + photo));
			fos1.write(anoFeed.getFile().getBytes());
			anoFeed.setPhoto(photo);
			fos1.close();
		}

		anoFeed.setNick(profile.getNick());
		if (anoFeed.getAnCheck() == null || anoFeed.getAnCheck().equals("")) {
			anoFeed.setAnCheck("n");
		}

		result = as.insertFeed(anoFeed); // Feed 생성
		HashTag hash = new HashTag();
		AnoFeed anoFeed1 = as.selectFeed(anoFeed);
		if (tags != null) {
			String[] tagList = tags.split(",");
			for (int i = 0; i < tagList.length; i++) {
				String tag = tagList[i];
				hash.setTag(tag);
				hash.setAnNum(anoFeed1.getAnNum());
				as.insertTag(hash); // tag 생성
			}
		}

		model.addAttribute("result", result);

		return "/anoFeed/feedWrite";
	}

	@RequestMapping("siMain.do")
	public String siMain(Model model, Member member, Profile profile, String longitude, String latitude) {
		
		String id = (String) session.getAttribute("id");
		member = ms.selectId(id);
		profile = ms.selectProfileById(id);
		Location location2 = new Location();
		Location location3 = new Location();
		List<LikeFeed> likeList = new ArrayList<LikeFeed>();
		likeList = as.selectLikeList(profile.getNick());
		if (longitude == null) {
			location3 = ms.selectlocation(member.getNick());
			longitude = Float.toString(location3.getLongitude());
			latitude = Float.toString(location3.getLatitude());
		}
		if (longitude != null && !longitude.equals("undefined")) {
			float longgi = Float.parseFloat(longitude);
			float lati = Float.parseFloat(latitude);
			Location location = new Location();
			location.setLatitude(lati);
			location.setLongitude(longgi);
			location.setNick(profile.getNick());
			location2 = ms.selectlocation(profile.getNick());
			if (location2 == null) {
				ms.insertlocation(location);
			} else {
				ms.updatelocation(location);
			}
		}
		Location loc = ms.selectlocation(member.getNick());
		float lati = loc.getLatitude();
		float longi = loc.getLongitude();

		String nick = member.getNick();
		List<AnoFeed> anoFeeds = new ArrayList<AnoFeed>();
		ShowCondition showCondition = as.selectselconbyNic(nick);
		List<Location> locations = mcs.selloc(location2);
		List<AnoFeed> anoFeeds2 = as.selectAllano();
		
		
		if (showCondition == null) {

			for (AnoFeed anoFeed : anoFeeds2) {
				List<HashTag> temphash = as.selecttagbynum(anoFeed.getAnNum());
				anoFeed.setHashTag(temphash);
				for (LikeFeed likeFeed : likeList) {
					if (anoFeed.getAnNum() == likeFeed.getAnNum()) {
						anoFeed.setLikeChk("y");
					}
				}
				Profile profile1 = ms.selectProfileByNick(anoFeed.getNick());
				anoFeed.setProfile(profile1);
				List<Reply> replyList = new ArrayList<Reply>();
				List<Reply> replyList1 = as.selectReplyListAjax(anoFeed.getAnNum());
				for (Reply reply : replyList1) {
					Profile profile2 = ms.selectProfileByNick(reply.getNick());
					reply.setProfile(profile2);
					replyList.add(reply);
				}
				anoFeed.setReply(replyList);
			}
			anoFeeds = anoFeeds2;
			
		} else {
			
			if (showCondition.getDistCheck().equals("y")) {

				if (showCondition.getAnHash().equals("none")) {

					String tempnick = "(";
					for (Location location : locations) {
						tempnick += "'";
						tempnick += location.getNick() + "',";
					}
					tempnick += "'FirstImpression'";
					tempnick += ")";
					
					List<AnoFeed> anofeed = as.selectanobyNick(tempnick);
					for (AnoFeed tanoFeed : anofeed) {
						List<HashTag> temphash = as.selecttagbynum(tanoFeed.getAnNum());
						tanoFeed.setHashTag(temphash);
						Profile profile1 = ms.selectProfileByNick(tanoFeed.getNick());
						tanoFeed.setProfile(profile1);
						for (LikeFeed likeFeed : likeList) {
							if (tanoFeed.getAnNum() == likeFeed.getAnNum()) {
								tanoFeed.setLikeChk("y");
							}
						}
						List<Reply> replyList = new ArrayList<Reply>();
						List<Reply> replyList1 = as.selectReplyListAjax(tanoFeed.getAnNum());
						for (Reply reply : replyList1) {
							Profile profile2 = ms.selectProfileByNick(reply.getNick());
							reply.setProfile(profile2);
							replyList.add(reply);
						}
						tanoFeed.setReply(replyList);
					}
					anoFeeds = anofeed;
				} else {

					String tempnick = "(";
					for (Location location : locations) {
						tempnick += "'";
						tempnick += location.getNick() + "',";
					}
					tempnick += "'FirstImpression'";
					tempnick += ")";
					
					List<AnoFeed> anofeed = as.selectanobyAll(tempnick, showCondition.getAnHash());

					for (AnoFeed haTag : anofeed) {

						List<HashTag> temphash = as.selecttagbynum(haTag.getAnNum());
						haTag.setHashTag(temphash);
						Profile profile1 = ms.selectProfileByNick(haTag.getNick());
						haTag.setProfile(profile1);
						for (LikeFeed likeFeed : likeList) {
							if (haTag.getAnNum() == likeFeed.getAnNum()) {
								haTag.setLikeChk("y");
							}
						}
						List<Reply> replyList = new ArrayList<Reply>();
						List<Reply> replyList1 = as.selectReplyListAjax(haTag.getAnNum());
						for (Reply reply : replyList1) {
							Profile profile2 = ms.selectProfileByNick(reply.getNick());
							reply.setProfile(profile2);
							replyList.add(reply);
						}
						haTag.setReply(replyList);
					}
					anoFeeds = anofeed;

				}

			} else {
				if (showCondition.getAnHash().equals("none")) {
					for (AnoFeed anoFeed : anoFeeds2) {
						List<HashTag> temphash = as.selecttagbynum(anoFeed.getAnNum());
						anoFeed.setHashTag(temphash);
						for (LikeFeed likeFeed : likeList) {
							if (anoFeed.getAnNum() == likeFeed.getAnNum()) {
								anoFeed.setLikeChk("y");
							}
						}
						Profile profile1 = ms.selectProfileByNick(anoFeed.getNick());
						anoFeed.setProfile(profile1);
						List<Reply> replyList = new ArrayList<Reply>();
						List<Reply> replyList1 = as.selectReplyListAjax(anoFeed.getAnNum());
						for (Reply reply : replyList1) {
							Profile profile2 = ms.selectProfileByNick(reply.getNick());
							reply.setProfile(profile2);
							replyList.add(reply);
						}
						anoFeed.setReply(replyList);
					}
					anoFeeds = anoFeeds2;
				} else {
					List<HashTag> hashTag = as.selectHashTag(showCondition.getAnHash());
					for (HashTag haTag : hashTag) {
						AnoFeed anofeed3 = as.selectanobynum(haTag.getAnNum());
						List<HashTag> temphash = as.selecttagbynum(anofeed3.getAnNum());
						anofeed3.setHashTag(temphash);
						Profile profile1 = ms.selectProfileByNick(anofeed3.getNick());
						anofeed3.setProfile(profile1);
						for (LikeFeed likeFeed : likeList) {
							if (anofeed3.getAnNum() == likeFeed.getAnNum()) {
								anofeed3.setLikeChk("y");
							}
						}
						List<Reply> replyList = new ArrayList<Reply>();
						List<Reply> replyList1 = as.selectReplyListAjax(anofeed3.getAnNum());
						for (Reply reply : replyList1) {
							Profile profile2 = ms.selectProfileByNick(reply.getNick());
							reply.setProfile(profile2);
							replyList.add(reply);
						}
						anofeed3.setReply(replyList);
						anoFeeds.add(anofeed3);
						

					}
				}
			}

		}
		List<String> tags = new ArrayList<String>();
		int tagCnt = ps.getTagCnt();
		for (int i = 1; i <= tagCnt; i++) {
			tags.add(ps.selectTag(i));
		}
		//결과 10개만
		int cut=10;
		int i=1;
		List<AnoFeed> list= new ArrayList<AnoFeed>();
		for(AnoFeed temp: anoFeeds)
		{
			if(i<=cut)
			{
				list.add(temp);
				i++;
			}
		}
		i=1;
		
		
		ShowCondition showCondition2 = as.selectselconbyNic(nick);
		model.addAttribute("tags", tags);
		model.addAttribute("likeList", likeList);
		model.addAttribute("list", list);
		model.addAttribute("member", member);
		model.addAttribute("profile", profile);
		model.addAttribute("lati", lati);
		model.addAttribute("longi", longi);
		model.addAttribute("showCondition", showCondition2);
		
		return "/public/siMain";
	}

	@RequestMapping("searchModal.do")
	public String searchModal(Model model, String nick) {
		
		model.addAttribute("nick", nick);
		return "/anoFeed/searchModal";
	}

//
	@RequestMapping("searchCondition.do")
	public String searchCondition(Model model, ShowCondition condition) {
		int result = 0;
		int check = 0;
		String id = (String) session.getAttribute("id");
		
		Profile profile = ms.selectProfileById(id);
		
		String nick = profile.getNick();
		
		check = as.selectShowCondition(nick);
		
		condition.setNick(nick);

		if (check == 0) {
			result = as.insertShowCondition(condition);
		} else {
			result = as.updateShowCondition(condition);
		}
		model.addAttribute("result", result);
		return "/anoFeed/searchConditionResult";
	}

	@RequestMapping("myFeed.do")
	public String myFeed(Model model) {
		String id = (String) session.getAttribute("id");
		Member member = ms.selectId(id);
		Profile profile = ms.selectProfileById(id);
		List<AnoFeed> anoFeeds = as.selectMyAno(member.getNick());
		for (AnoFeed anofeed : anoFeeds) {
			List<HashTag> temphash = as.selecttagbynum(anofeed.getAnNum());
			anofeed.setHashTag(temphash);
			List<LikeFeed> likeList = new ArrayList<LikeFeed>();
			likeList = as.selectLikeList(profile.getNick());
			for (LikeFeed likeFeed : likeList) {
				if (anofeed.getAnNum() == likeFeed.getAnNum()) {
					anofeed.setLikeChk("y");
				}
			}
			Profile profile1 = ms.selectProfileByNick(anofeed.getNick());
			anofeed.setProfile(profile1);
			List<Reply> replyList = new ArrayList<Reply>();
			List<Reply> replyList1 = as.selectReplyListAjax(anofeed.getAnNum());
			for (Reply reply : replyList1) {
				Profile profile2 = ms.selectProfileByNick(reply.getNick());
				reply.setProfile(profile2);
				replyList.add(reply);
			}
			anofeed.setReply(replyList);
		}

		int cut=10;
		int i=1;
		List<AnoFeed> list= new ArrayList<AnoFeed>();
		for(AnoFeed temp: anoFeeds)
		{
			if(i<=cut)
			{
				list.add(temp);
				i++;
			}
		}
		i=1;
		
		model.addAttribute("list", list);
		model.addAttribute("profile", profile);
		return "/anoFeed/myFeed";
	}

	@RequestMapping("likeFeed.do")
	public String likeFeed(Model model) {
		String id = (String) session.getAttribute("id");
		Member member = ms.selectId(id);
		Profile profile = ms.selectProfileById(id);
		List<LikeFeed> likeFeeds = as.selectLikeList(member.getNick());
		List<AnoFeed> anoFeeds = new ArrayList<AnoFeed>();
		for (LikeFeed likeFeed : likeFeeds) {
			AnoFeed anofeed = as.selectanobynum(likeFeed.getAnNum());
			List<HashTag> temphash = as.selecttagbynum(likeFeed.getAnNum());
			anofeed.setHashTag(temphash);
			Profile profile1 = ms.selectProfileByNick(anofeed.getNick());
			anofeed.setProfile(profile1);
			if (anofeed.getAnNum() == likeFeed.getAnNum()) {
				anofeed.setLikeChk("y");
			}
			List<Reply> replyList = new ArrayList<Reply>();
			List<Reply> replyList1 = as.selectReplyListAjax(anofeed.getAnNum());
			for (Reply reply : replyList1) {
				Profile profile2 = ms.selectProfileByNick(reply.getNick());
				reply.setProfile(profile2);
				replyList.add(reply);
			}
			anofeed.setReply(replyList);
			anoFeeds.add(anofeed);
		}
		
		int cut=10;
		int i=1;
		List<AnoFeed> list= new ArrayList<AnoFeed>();
		for(AnoFeed temp: anoFeeds)
		{
			if(i<=cut)
			{
				list.add(temp);
				i++;
			}
		}
		i=1;
		
		model.addAttribute("list", list);
		model.addAttribute("profile", profile);
		return "/anoFeed/likeFeed";
	}

	@ResponseBody
	@RequestMapping("addLike.do")
	public int addLike(@RequestParam int no) {
		LikeFeed likeFeed = new LikeFeed();
		String id = (String) session.getAttribute("id");
		Profile profile = ms.selectProfileById(id);
		int anNum = no;

		likeFeed.setAnNum(anNum);
		likeFeed.setNick(profile.getNick());
		int check = as.selectLikeCheck(likeFeed);

		
		int likeCount = 1;
		if (check != 1) {
			as.insertLike(likeFeed);
			likeCount = as.selectLikeCount(anNum);
		} else {
			likeCount = as.selectLikeCount(anNum);
		}

		return likeCount;
	}

	@ResponseBody
	@RequestMapping("removeLike.do")
	public int removeLike(@RequestParam int no) {
		LikeFeed likeFeed = new LikeFeed();
		String id = (String) session.getAttribute("id");
		Profile profile = ms.selectProfileById(id);
		int anNum = no;

		likeFeed.setAnNum(anNum);
		likeFeed.setNick(profile.getNick());
		int check = as.selectLikeCheck(likeFeed);
		int likeCount = as.selectLikeCount(anNum);
		if (check != 0) {
			as.deleteLike(likeFeed);
			likeCount = as.selectLikeCount(anNum);
		}

		return likeCount;
	}

	@ResponseBody
	@RequestMapping(value = "insertReply.do", method = { RequestMethod.POST })
	public List<Reply>insertReply(@RequestParam("no") int anNum, @RequestParam("rpCheck") String rpCheck,
			@RequestParam("replyContent") String replyContent) {
		String id = (String) session.getAttribute("id");
		Profile profile = ms.selectProfileById(id);
		String nick = profile.getNick();

		Reply reply = new Reply();
		reply.setAnNum(anNum);
		reply.setRpCheck(rpCheck);
		reply.setNick(nick);

		reply.setReplyContent(replyContent);

		as.insertReply(reply);
		List<Reply> replyList = new ArrayList<Reply>();
		List<Reply> replyList1 = as.selectReplyListAjax(anNum);
		for (Reply reply1 : replyList1) {
			String nick1 = reply1.getNick();
			Profile profile1 = ps.selectProfileByNick(nick1);
			reply1.setProfile(profile1);
			replyList.add(reply1);
		}
		
		return replyList;
	}

	@ResponseBody
	@RequestMapping(value = "insertReReply.do", method = { RequestMethod.POST })
	public int insertReReply(@RequestParam("ref") int ref, @RequestParam("rpCheck") String rpCheck,
			@RequestParam("replyContent") String replyContent) {
		String id = (String) session.getAttribute("id");
		Profile profile = ms.selectProfileById(id);
		String nick = profile.getNick();
		Reply reply = new Reply();
		int anNum = as.selectAnoByRp(ref);

		reply.setAnNum(anNum);
		reply.setRpCheck(rpCheck);
		reply.setNick(nick);
		reply.setReplyContent(replyContent);
		reply.setRef_step(1);
		reply.setRef(ref);
		
		as.insertReReply(reply);

		int replyCount = as.selectReplyCount(anNum);

		return replyCount;
	}

	@ResponseBody
	@RequestMapping(value = "updateReply.do", method = { RequestMethod.POST })
	public int updateReply(@RequestParam("rpNum") int rpNum, @RequestParam("rpCheck") String rpCheck,
			@RequestParam("replyContent") String replyContent) {
		Reply reply = as.selectReplyByRp(rpNum);
		reply.setRpCheck(rpCheck);
		reply.setReplyContent(replyContent);

		as.updateReply(reply);
		int anNum = as.selectAnoByRp(rpNum);
		int replyCount = as.selectReplyCount(anNum);

		return replyCount;
	}

	@ResponseBody
	@RequestMapping(value = "deleteReply.do", method = { RequestMethod.GET })
	public int deleteReply(@RequestParam("rpNum") int rpNum) {
		int anNum = as.selectAnoByRp(rpNum);
		Reply reply = as.selectReplyByRp(rpNum);
		as.deleteReply(reply);
		List<Reply> replyRefs = as.deleteByRef(reply.getRef());
		for(Reply replys : replyRefs) {
			as.deleteReply(replys);
		}
		int replyCount = as.selectReplyCount(anNum);

		return replyCount;
	}

	@ResponseBody
	@RequestMapping(value = "replyListAjax.do")
	public List<Reply> replyListAjax(@RequestParam("anNum") int anNum) {
		List<Reply> replyList = new ArrayList<Reply>();
		List<Reply> replyList1 = as.selectReplyListAjax(anNum);
		for (Reply reply : replyList1) {
			String nick = reply.getNick();
			Profile profile = ps.selectProfileByNick(nick);
			reply.setProfile(profile);
			replyList.add(reply);
		}

		
		return replyList;
	}

	@RequestMapping("feedDetail.do")
	public String feedDetail(int anNum, Model model, AnoFeed anoFeed, Profile profile, LikeFeed likeFeed) {
		String id = (String) session.getAttribute("id");
		profile = ms.selectProfileById(id);
		anoFeed = as.selectanobynum(anNum);
		Profile profileWriter = ps.selectProfileByNick(anoFeed.getNick());
		anoFeed.setProfile(profileWriter);
		List<Reply> replyList = new ArrayList<Reply>();
		List<Reply> replyList1 = as.selectReplyListDetail(anNum);
		for(Reply reply : replyList1) {
			String nick = reply.getNick();
			Profile profile1 = ps.selectProfileByNick(nick);
			reply.setProfile(profile1);
			replyList.add(reply);
		}
		likeFeed.setAnNum(anNum);
		likeFeed.setNick(profile.getNick());
		int likeCheck = as.selectLikeCheck(likeFeed);
		if (likeCheck == 1) {
			anoFeed.setLikeChk("y");
		} else {
			anoFeed.setLikeChk("n");
		}
		List<HashTag> tagList = as.selecttagbynum(anNum);
		int replyCount = as.selectReplyCount(anNum);
		anoFeed.setReplyCount(replyCount);
		anoFeed.setHashTag(tagList);
		anoFeed.setReply(replyList);

		model.addAttribute("anoFeed", anoFeed);
		model.addAttribute("profile", profile);

		return "/anoFeed/feedDetail";
	}
	@RequestMapping("anoFeedUpdateForm.do")
	public String anoFeedUpdateForm(Model model, AnoFeed anoFeed, int anNum) {
		String id = (String) session.getAttribute("id");
		Profile profile = ms.selectProfileById(id);
		List<TagList> tags = ps.selectTags();
		List<String> tags2 = new ArrayList<String>();
		anoFeed = as.selectanobynum(anNum);
		for (TagList tag : tags) {
			tags2.add(tag.getTag());
		}
		List<HashTag> hashList2 = as.selecttagbynum(anNum);
		for (HashTag hash : hashList2) {
			tags2.remove(hash.getTag());
		}
		 
		model.addAttribute("hashList", hashList2);
		model.addAttribute("tags", tags2);
		model.addAttribute("anoFeed", anoFeed);
		model.addAttribute("profile", profile);
		
		return "/anoFeed/anoFeedUpdateForm";
	}
	@RequestMapping("feedUpdate.do")
	public String feedUpdate(Model model, AnoFeed anoFeed, String tags, String prePhoto) throws IOException {
		String id = (String) session.getAttribute("id");
		Profile profile = ms.selectProfileById(id);
		String fileName = anoFeed.getFile().getOriginalFilename();
		
		int result = 0;
		if (!fileName.equals("")) {
			String real = session.getServletContext().getRealPath("/resources/feed");
			
			UUID uuid = UUID.randomUUID();
			String photo = "feed" + uuid + fileName.substring(fileName.lastIndexOf("."));
			FileOutputStream fos1 = new FileOutputStream(new File(real + "/" + photo));
			fos1.write(anoFeed.getFile().getBytes());
			anoFeed.setPhoto(photo);
			fos1.close();
		} else {
			anoFeed.setPhoto(prePhoto);
		}
		if (anoFeed.getAnCheck() == null || anoFeed.getAnCheck().equals("")) {
			anoFeed.setAnCheck("n");
		} 
		
		result = as.updateFeed(anoFeed); // Feed 업데이트
		HashTag hash = new HashTag();
		if (tags != null) {
			String[] tagList = tags.split(",");
			as.deleteHashTag(anoFeed.getAnNum()); // tag 삭제
			for (int i = 0; i < tagList.length; i++) {
				String tag = tagList[i];
				hash.setTag(tag);
				hash.setAnNum(anoFeed.getAnNum());
				as.insertTag(hash); // tag 생성
			}
		}
		model.addAttribute("result", result);
		
		return "/anoFeed/anoFeedUpdate";
	}
	
	@RequestMapping("anoFeedDelete.do")
	public String anoFeedDelete(Model model, int anNum) {
		int result = 0;
		result = as.deleteanobynum(anNum);
		as.deletelikebynum(anNum);
		
		model.addAttribute("result", result);		
		
		return "/anoFeed/anoFeedDelete";
	}
	@RequestMapping("reportfeed.do")
	public String reportfeed(Model model,int anNum) {
		String id = (String) session.getAttribute("id");
		Profile profile = ms.selectProfileById(id);
		AnoFeed anoFeed=as.selectanobynum(anNum);
		Report report=new Report();
		report.setAnNum(anNum);
		report.setNick(profile.getNick());
		report.setReason(2);
		report.setTargetNick(anoFeed.getNick());
		Profile profile1 = ms.selectProfileByNick(anoFeed.getNick());
		report.setTargetId(profile1.getId());
		int result=0;
		Report report2= as.selectReport(report);
		if(report2 ==null)
		{
			result=as.report(report);
		}
		else
		{
			result=2;
		}
		model.addAttribute("result",result);
		return "/public/report";
	}
	@RequestMapping("reportuser.do")
	public String reportuser(Model model,String nick) {
		String id = (String) session.getAttribute("id");
		Profile profile = ms.selectProfileById(id);

		Report report=new Report();
		report.setAnNum(0);
		report.setNick(profile.getNick());
		report.setReason(1);
		report.setTargetNick(nick);
		Profile profile1 = ms.selectProfileByNick(nick);
		report.setTargetId(profile1.getId());
		int result=0;
		Report report2= as.selectReport(report);
		if(report2 ==null)
		{
			result=as.report(report);
		}
		else
		{
			result=2;
		}
				
		
		model.addAttribute("result",result);
		return "/public/report";
	}
	
	@ResponseBody
	@RequestMapping(value = "appendList.do", method = { RequestMethod.POST })
	public List<AnoFeed> appendList(@RequestParam("startNum") int startNum) {
		
		
		String id = (String) session.getAttribute("id");
		Member member = ms.selectId(id);
		Profile profile = ms.selectProfileById(id);
		Location location2 = new Location();		

		List<LikeFeed> likeList = new ArrayList<LikeFeed>();
		likeList = as.selectLikeList(profile.getNick());
		location2 = ms.selectlocation(profile.getNick());
		String nick = member.getNick();
		List<AnoFeed> anoFeeds = new ArrayList<AnoFeed>();
		ShowCondition showCondition = as.selectselconbyNic(nick);
		List<Location> locations = mcs.selloc(location2);
		List<AnoFeed> anoFeeds2 = as.selectAllano();
		
		
		if (showCondition == null) {

			for (AnoFeed anoFeed : anoFeeds2) {
				List<HashTag> temphash = as.selecttagbynum(anoFeed.getAnNum());
				anoFeed.setHashTag(temphash);
				for (LikeFeed likeFeed : likeList) {
					if (anoFeed.getAnNum() == likeFeed.getAnNum()) {
						anoFeed.setLikeChk("y");
					}
				}
				Profile profile1 = ms.selectProfileByNick(anoFeed.getNick());
				anoFeed.setProfile(profile1);
				List<Reply> replyList = new ArrayList<Reply>();
				List<Reply> replyList1 = as.selectReplyListAjax(anoFeed.getAnNum());
				for (Reply reply : replyList1) {
					Profile profile2 = ms.selectProfileByNick(reply.getNick());
					reply.setProfile(profile2);
					replyList.add(reply);
				}
				anoFeed.setReply(replyList);
			}
			anoFeeds = anoFeeds2;
			
		} else {
			
			if (showCondition.getDistCheck().equals("y")) {

				if (showCondition.getAnHash().equals("none")) {

					String tempnick = "(";
					for (Location location : locations) {
						tempnick += "'";
						tempnick += location.getNick() + "',";
					}
					tempnick += "'FirstImpression'";
					tempnick += ")";
					
					List<AnoFeed> anofeed = as.selectanobyNick(tempnick);
					for (AnoFeed tanoFeed : anofeed) {
						List<HashTag> temphash = as.selecttagbynum(tanoFeed.getAnNum());
						tanoFeed.setHashTag(temphash);
						Profile profile1 = ms.selectProfileByNick(tanoFeed.getNick());
						tanoFeed.setProfile(profile1);
						for (LikeFeed likeFeed : likeList) {
							if (tanoFeed.getAnNum() == likeFeed.getAnNum()) {
								tanoFeed.setLikeChk("y");
							}
						}
						List<Reply> replyList = new ArrayList<Reply>();
						List<Reply> replyList1 = as.selectReplyListAjax(tanoFeed.getAnNum());
						for (Reply reply : replyList1) {
							Profile profile2 = ms.selectProfileByNick(reply.getNick());
							reply.setProfile(profile2);
							replyList.add(reply);
						}
						tanoFeed.setReply(replyList);
					}
					anoFeeds = anofeed;
				} else {

					String tempnick = "(";
					for (Location location : locations) {
						tempnick += "'";
						tempnick += location.getNick() + "',";
					}
					tempnick += "'FirstImpression'";
					tempnick += ")";
					
					List<AnoFeed> anofeed = as.selectanobyAll(tempnick, showCondition.getAnHash());

					for (AnoFeed haTag : anofeed) {

						List<HashTag> temphash = as.selecttagbynum(haTag.getAnNum());
						haTag.setHashTag(temphash);
						Profile profile1 = ms.selectProfileByNick(haTag.getNick());
						haTag.setProfile(profile1);
						for (LikeFeed likeFeed : likeList) {
							if (haTag.getAnNum() == likeFeed.getAnNum()) {
								haTag.setLikeChk("y");
							}
						}
						List<Reply> replyList = new ArrayList<Reply>();
						List<Reply> replyList1 = as.selectReplyListAjax(haTag.getAnNum());
						for (Reply reply : replyList1) {
							Profile profile2 = ms.selectProfileByNick(reply.getNick());
							reply.setProfile(profile2);
							replyList.add(reply);
						}
						haTag.setReply(replyList);
					}
					anoFeeds = anofeed;

				}

			} else {
				if (showCondition.getAnHash().equals("none")) {
					for (AnoFeed anoFeed : anoFeeds2) {
						List<HashTag> temphash = as.selecttagbynum(anoFeed.getAnNum());
						anoFeed.setHashTag(temphash);
						for (LikeFeed likeFeed : likeList) {
							if (anoFeed.getAnNum() == likeFeed.getAnNum()) {
								anoFeed.setLikeChk("y");
							}
						}
						Profile profile1 = ms.selectProfileByNick(anoFeed.getNick());
						anoFeed.setProfile(profile1);
						List<Reply> replyList = new ArrayList<Reply>();
						List<Reply> replyList1 = as.selectReplyListAjax(anoFeed.getAnNum());
						for (Reply reply : replyList1) {
							Profile profile2 = ms.selectProfileByNick(reply.getNick());
							reply.setProfile(profile2);
							replyList.add(reply);
						}
						anoFeed.setReply(replyList);
					}
					anoFeeds = anoFeeds2;
				} else {
					List<HashTag> hashTag = as.selectHashTag(showCondition.getAnHash());
					for (HashTag haTag : hashTag) {
						AnoFeed anofeed3 = as.selectanobynum(haTag.getAnNum());
						List<HashTag> temphash = as.selecttagbynum(anofeed3.getAnNum());
						anofeed3.setHashTag(temphash);
						Profile profile1 = ms.selectProfileByNick(anofeed3.getNick());
						anofeed3.setProfile(profile1);
						for (LikeFeed likeFeed : likeList) {
							if (anofeed3.getAnNum() == likeFeed.getAnNum()) {
								anofeed3.setLikeChk("y");
							}
						}
						List<Reply> replyList = new ArrayList<Reply>();
						List<Reply> replyList1 = as.selectReplyListAjax(anofeed3.getAnNum());
						for (Reply reply : replyList1) {
							Profile profile2 = ms.selectProfileByNick(reply.getNick());
							reply.setProfile(profile2);
							replyList.add(reply);
						}
						anofeed3.setReply(replyList);
						anoFeeds.add(anofeed3);
						

					}
				}
			}

		}
		List<String> tags = new ArrayList<String>();
		int tagCnt = ps.getTagCnt();
		for (int i = 1; i <= tagCnt; i++) {
			tags.add(ps.selectTag(i));
		}
		//결과 10개만
		int i=1;
		List<AnoFeed> list= new ArrayList<AnoFeed>();
		for(AnoFeed temp: anoFeeds)
		{
			if(startNum<=i&&i<=(startNum+9))
			{ 
				
				list.add(temp);
			}
			i++;
		}
		i=1;
		
		
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "appendlikeFeed.do", method = { RequestMethod.POST })
	public List<AnoFeed> appendlikeFeed(@RequestParam("startNum") int startNum) {
		String id = (String) session.getAttribute("id");
		Member member = ms.selectId(id);
		Profile profile = ms.selectProfileById(id);
		List<LikeFeed> likeFeeds = as.selectLikeList(member.getNick());
		List<AnoFeed> anoFeeds = new ArrayList<AnoFeed>();
		for (LikeFeed likeFeed : likeFeeds) {
			AnoFeed anofeed = as.selectanobynum(likeFeed.getAnNum());
			List<HashTag> temphash = as.selecttagbynum(likeFeed.getAnNum());
			anofeed.setHashTag(temphash);
			Profile profile1 = ms.selectProfileByNick(anofeed.getNick());
			anofeed.setProfile(profile1);
			if (anofeed.getAnNum() == likeFeed.getAnNum()) {
				anofeed.setLikeChk("y");
			}
			List<Reply> replyList = new ArrayList<Reply>();
			List<Reply> replyList1 = as.selectReplyListAjax(anofeed.getAnNum());
			for (Reply reply : replyList1) {
				Profile profile2 = ms.selectProfileByNick(reply.getNick());
				reply.setProfile(profile2);
				replyList.add(reply);
			}
			anofeed.setReply(replyList);
			anoFeeds.add(anofeed);
		}
		int i=1;
		List<AnoFeed> list= new ArrayList<AnoFeed>();
		for(AnoFeed temp: anoFeeds)
		{
			if(startNum<=i&&i<=(startNum+9))
			{
				list.add(temp);
			}
			i++;
		}
		i=1;

		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "appendmyFeed.do", method = { RequestMethod.POST })
	public List<AnoFeed> appendmyFeed(@RequestParam("startNum") int startNum) {
		String id = (String) session.getAttribute("id");
		Member member = ms.selectId(id);
		Profile profile = ms.selectProfileById(id);
		List<AnoFeed> anoFeeds = as.selectMyAno(member.getNick());
		for (AnoFeed anofeed : anoFeeds) {
			List<HashTag> temphash = as.selecttagbynum(anofeed.getAnNum());
			anofeed.setHashTag(temphash);
			List<LikeFeed> likeList = new ArrayList<LikeFeed>();
			likeList = as.selectLikeList(profile.getNick());
			for (LikeFeed likeFeed : likeList) {
				if (anofeed.getAnNum() == likeFeed.getAnNum()) {
					anofeed.setLikeChk("y");
				}
			}
			Profile profile1 = ms.selectProfileByNick(anofeed.getNick());
			anofeed.setProfile(profile1);
			List<Reply> replyList = new ArrayList<Reply>();
			List<Reply> replyList1 = as.selectReplyListAjax(anofeed.getAnNum());
			for (Reply reply : replyList1) {
				Profile profile2 = ms.selectProfileByNick(reply.getNick());
				reply.setProfile(profile2);
				replyList.add(reply);
			}
			anofeed.setReply(replyList);
		}

	
		int i=1;
		List<AnoFeed> list= new ArrayList<AnoFeed>();
		for(AnoFeed temp: anoFeeds)
		{
			if(startNum<=i&&i<=(startNum+9))
			{
				list.add(temp);
			}
			i++;
		}
		i=1;
		
	
	
		return list;
	}
	
}