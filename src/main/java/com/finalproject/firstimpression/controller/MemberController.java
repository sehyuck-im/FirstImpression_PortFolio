package com.finalproject.firstimpression.controller;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalproject.firstimpression.model.Appointment;
import com.finalproject.firstimpression.model.ChatRoom;
import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.MyPreference;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.service.AnoFeedService;
import com.finalproject.firstimpression.service.MatchingService;
import com.finalproject.firstimpression.service.MemberService;
import com.finalproject.firstimpression.service.ProfileService;
import com.finalproject.firstimpression.service.SelLocService;

@Controller
public class MemberController {
	@Autowired
	private MemberService ms;
	@Autowired
	private ProfileService ps;
	@Autowired
	private MatchingService mcs;
	@Autowired
	private AnoFeedService as;
	@Autowired
	private SelLocService ss;

	@Autowired
	private BCryptPasswordEncoder bpPass;
	@Autowired
	private HttpSession session;
	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping("main.do")
	public String main() {

		return "main";
	}

	@RequestMapping("signUpForm.do")
	public String signInForm(Model model, String name, String email, String phone) {
		Member member = new Member();
		member.setName(name);
		member.setEmail(email);
		member.setPhone(phone);
		model.addAttribute("member", member);

		return "/member/signUpForm";
	}

	@RequestMapping("naverSignUp.do")
	public String naverSignUp(Model model, Member member, String postCode, String roadAddress, String detailAddress) {
		int result = 0;
		int result2 = 0;
		Member member2 = ms.selectId(member.getId());
		Member member3 = ms.selectNick(member.getNick());
		if (member2 == null) {
			String password = bpPass.encode(member.getPassword());
			String address = postCode + " " + roadAddress + " " + detailAddress;
			String nick = member.getNick();
			member.setPassword(password);
			member.setAddress(address);
			result = ms.insertNaver(member);

			// profile에 age 입력
			int age = ms.getAge(member.getId());
			Profile profile = new Profile();
			profile.setAge(age);
			profile.setNick(nick);
			profile.setId(member.getId());

			int result1 = ms.insertProfileNaver(profile);
			

			MyPreference preference = new MyPreference();
			preference.setNick(nick);
			int result3 = ms.insertPreference(preference);
			

			if (result1 == 1 && result == 1 && result3 == 1) {
				result2 = 1;
			} else if (result1 == 0 || result == 0 || result3 == 0) {
				result2 = 0; //
				ms.deleteProfileAndPre(nick); // 회원가입 실패했으니 프로필이랑 취향 db 삭제
			}
		} else if (member3 != null) {
			result2 = -2; // 이미 존재하는 닉네임
		} else {
			result2 = -1; // 이미 존재하는 아이디
		}
		model.addAttribute("result", result2);

		return "/member/signUp";
	}

	@RequestMapping("signUp.do")
	public String signUpForm(Model model, Member member, String postCode, String roadAddress, String detailAddress) {
		int result = 0;
		int result2 = 0;
		Member member2 = ms.selectId(member.getId());
		Member member3 = ms.selectNick(member.getNick());
		if (member2 == null) {
			String password = bpPass.encode(member.getPassword());
			String address = postCode + " " + roadAddress + " " + detailAddress;
			member.setPassword(password);
			member.setAddress(address);
			result = ms.insert(member);
			String nick = member.getNick();
			// profile에 age 입력
			int age = ms.getAge(member.getId());
			Profile profile = new Profile();
			profile.setAge(age);
			profile.setNick(nick);
			profile.setId(member.getId());
			int result1 = ms.insertProfile(profile);

			
			MyPreference preference = new MyPreference();
			preference.setNick(nick);
			int result3 = ms.insertPreference(preference);
			
			if (result1 == 1 && result == 1 && result3 == 1) {
				result2 = 1;
			} else if (result1 == 0 || result == 0 || result3 == 0) {
				result2 = 0; //
				ms.deleteProfileAndPre(nick); // 회원가입 실패했으니 프로필이랑 취향 db 삭제
			}
		} else if (member3 != null) {
			result2 = -2; // 중복된 닉네임
		} else {
			result2 = -1; // 중복된 아이디
		}
		model.addAttribute("result", result2);
		return "/member/signUp";
	}

	@RequestMapping(value = "idChk.do", produces = "text/html;charset=utf-8")
	@ResponseBody // jsp로 가지말고 바로 바디에 전달
	public String idChk(String id, Model model, Member member) {
		member = ms.selectId(id);
		int id_len = id.length();
		if (id_len >= 4 && id_len <= 15) {
			if (member != null) {
				return "fail1"; // 중복 존재
			} else {
				return "success"; // 중복 없음
			}
		} else {
			return "fail2";
		}
	}

	@RequestMapping(value = "nChk.do", produces = "text/html;charset=utf-8")
	@ResponseBody // jsp로 가지말고 바로 바디에 전달
	public String nChk(String nick, Member member) {
		member = ms.selectNick(nick);
		int nick_len = nick.length();
		if (nick_len >= 2 && nick_len <= 15) {
			if (member != null) {
				return "fail1"; // 중복 존재
			} else {
				return "success"; // 중복 없음
			}
		} else {
			return "fail2";
		}
	}

	@RequestMapping(value = "mailChk2.do", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String mailChk2(String email, Member member) {
		int count = ms.checkEmail(email);
		if (count > 0) {
			return "fail";
		} else if (isValidEmail(email) == false) {
			return "fail2";
		}
		return "success";
	}

	@RequestMapping(value = "passChk.do", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String passChk(String password, String password2) {
		if (password.equals(password2)) {
			return "success"; // 일치
		}
		return "fail"; // 불일치
	}

	@RequestMapping(value = "/mailChk.do", method = RequestMethod.GET)
	@ResponseBody
	public String mailChk(@RequestParam("email") String email) throws Exception {
		int certi = (int) ((Math.random() * (999999 - 100000 + 1)) + 10000);

		String from = "FirstImpressionMain@gmail.com";// 보내는 이 메일주소
		String to = email;
		String title = "Please Verify your eamil🔥  ";
		String content = "[인증번호] " + certi + " 입니다. <br/> 인증번호 확인란에 기입해주십시오.";
		String num = "";
		System.out.println("from : " + from);
		System.out.println("to : " + to);
		System.out.println("title : " + title);
		System.out.println("content : " + content);

		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");

			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);

			mailSender.send(mail);
			num = Integer.toString(certi);

			System.out.println("이메일 전송 끝");

		} catch (Exception e) {
			num = "error";
		}
		return num;
	}

	@RequestMapping("signInForm.do")
	public String signInForm() {

		return "/member/signInForm";
	}

	@RequestMapping("signIn.do")
	public String signIn(Model model, Member member) {
		int result = 0;
		Member member2 = ms.selectId(member.getId());

		if (member2 == null || member2.getDel().equals("y")) {
			result = -1; // 없는 id
		} else {
			if (bpPass.matches(member.getPassword(), member2.getPassword())) {
				if (member2.getDel().equals("n")) {
					result = 1; // id pass 일치
					session.setAttribute("id", member.getId());
				} else if (member2.getDel().equals("y")) {
					result = -1; // 삭제된 아이디
				} else if (member2.getDel().equals("s")) {
					result = -3; // 정지된 아이디
				}

			} else if (!bpPass.matches(member.getPassword(), member2.getPassword())
					&& member.getId().equals(member2.getId())) {
				result = -2; // 아이디는 일치, 암호 불일치
			}
		}

		if (member.getId().equals("FirstImpression") && result == 1) {
			result = 4;
		}
		model.addAttribute("result", result);
		return "/member/signIn";
	}

	@RequestMapping("memberUpdateForm.do")
	public String memberUpdateForm(Model model, Member member) {
		String id = (String) session.getAttribute("id");
		member = ms.selectId(id);
		model.addAttribute("member", member);
		return "/member/memberUpdateForm";
	}

	@RequestMapping("memberUpdate.do")
	public String memberUpdate(Model model, String postCode, String roadAddress, String detailAddress,
			HttpServletRequest request) {
		int result = 0;

		String id = (String) session.getAttribute("id");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		String email = request.getParameter("email");

		Member member = new Member();
		member.setId(id);
		String address;
		if (!postCode.equals("") && !roadAddress.equals("") && !detailAddress.equals("")) {
			address = postCode + " " + roadAddress + " " + detailAddress;
			member.setAddress(address);
		}
		if (!name.equals("")) {
			member.setName(name);
		}
		if (!phone.equals("")) {
			member.setPhone(phone);
		}
		if (!password.equals("")) {
			password = bpPass.encode(password);
			member.setPassword(password);
		}
		if (!email.equals("")) {
			member.setEmail(email);
		}
		result = ms.updateMember(member);
		model.addAttribute("result", result);

		return "/member/memberUpdate";
	}

	@RequestMapping("signOut.do")
	public String signOut() {
		session.invalidate();

		return "/public/signOut";
	}

	@RequestMapping("finderForm.do")
	public String finderForm() {

		return "/member/finderForm";
	}

	@ResponseBody
	@RequestMapping(value = "idFinder.do" , produces = "text/html;charset=utf-8")
	public String idFinder(@RequestParam("name") String name, @RequestParam("email") String email) {
		String msg = "";
		Integer result = 0;
		Member member = new Member();
		member.setName(name);
		member.setEmail(email);
		result = ms.countId(member);
		if (result == 1) {
			msg = ms.findID(member);
		} else {
			msg = "입력하신 정보와 일치하는 회원이 없습니다.";
		}
		
		return msg;
	}

	@ResponseBody
	@RequestMapping("passFinder.do")
	public String passFinder(@RequestParam("id") String id, @RequestParam("email") String email) {
		String msg = "";
		String npassword = "";
		Member checkPass = new Member();
		checkPass.setId(id);
		checkPass.setEmail(email);
		
		int result = ms.checkPass(checkPass);
		if (result == 1) {
			npassword = getRamdomPassword(10); // 10자리 무작위 비밀번호 생성

			String from = "FirstImpressionMain@gmail.com";// 보내는 이 메일주소
			String to = email;
			String title = "Your PassWord Has Been Changed🔥  ";
			String content = "<div> 새로운 비밀번호가 생성 되었습니다. </div> <div> 새로운 비밀번호는 " + npassword + " 입니다. <br/>";
			System.out.println("from : " + from);
			System.out.println("to : " + to);
			System.out.println("title : " + title);
			System.out.println("content : " + content);
			try {
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");

				mailHelper.setFrom(from);
				mailHelper.setTo(to);
				mailHelper.setSubject(title);
				mailHelper.setText(content, true);

				mailSender.send(mail);
				System.out.println("비밀 번호 이메일 전송 끝");

				msg = "1";

			} catch (Exception e) {
				System.out.println("비밀번호 재생성 이메일 에러 : " + e.getMessage());
			}

			npassword = bpPass.encode(npassword); // 생성된 비밀번호 암호화
			checkPass.setPassword(npassword);
			ms.setNewPass(checkPass);

		} else {
			msg = "2";
		}

		return msg;
	}

	@RequestMapping("contactEmail.do")
	public String contactEmail(HttpServletRequest request, Model model) {
		int result = 0;
		String name = request.getParameter("cntName");
		String email = request.getParameter("cntEmail");
		String phone = request.getParameter("cntPhone");
		String msg = request.getParameter("cntMsg");
		
		if (!name.equals("") && !email.equals("") && !msg.equals("") || name != null && email != null && msg != null) {
			String from = email;// 보내는 이 메일주소
			String to = "FirstImpressionMain@gmail.com";
			String title = name + "님이 문의하신 내용입니다.";
			String content = name + "님이 문의 하신 내용 <br> email 주소 : " + email + "<br> 연락처 : " + phone + "<br> 문의 내용  <br> "
					+ msg;
			System.out.println("from : " + from);
			System.out.println("to : " + to);
			System.out.println("title : " + title);
			System.out.println("content : " + content);
			try {
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");

				mailHelper.setFrom(from);
				mailHelper.setTo(to);
				mailHelper.setSubject(title);
				mailHelper.setText(content, true);

				mailSender.send(mail);

				System.out.println("문의 이메일 전송 끝");
				result = 1;
			} catch (Exception e) {
				System.out.println("이메일 문의 에러 : " + e.getMessage());
			}
		}
		model.addAttribute("result", result);

		return "contactEmail";
	}

	@RequestMapping("updatePosition.do")
	public String updatePosition(Model model) {
		String id = (String) session.getAttribute("id");
		Member member = ms.selectId(id);

		Profile profile = ms.selectProfileById(id);
		Location loc = ms.selectlocation(member.getNick());
		float lati = loc.getLatitude();
		float longi = loc.getLongitude();
		model.addAttribute("member", member);
		model.addAttribute("profile", profile);
		model.addAttribute("lati", lati);
		model.addAttribute("longi", longi);

		return "/member/updatePosition";
	}

	@RequestMapping("positionUpdate.do")
	public String positionUpdate(Model model) {

		return "/member/positionUpdate";
	}

	@RequestMapping("myAppointment.do")
	public String myAppointment(Model model) {
		String id = (String) session.getAttribute("id");
		Member member = ms.selectId(id);
		Profile profile = ms.selectProfileById(id);
		List<Appointment> list = new ArrayList<Appointment>();
		List<Appointment> list2 = new ArrayList<Appointment>();
		List<ChatRoom> chatRoom = mcs.selectmydelChat(profile.getNick());
		for (ChatRoom chat : chatRoom) {
			Appointment appointment = mcs.selectAp(chat.getChatRoomNo());
			Appointment appointment2 = mcs.selectoldAp(chat.getChatRoomNo());
			if (appointment != null) {
				Profile profile1 = ms.selectProfileByNick(chat.getEnterUser2());
				appointment.setProfile(profile1);
				list.add(appointment);
			}
			if (appointment2 != null) {
				Profile profile1 = ms.selectProfileByNick(chat.getEnterUser2());
				appointment2.setProfile(profile1);
				list2.add(appointment2);
			}
		}

		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		model.addAttribute("member", member);
		model.addAttribute("profile", profile);
		return "/member/myAppointment";
	}

	@RequestMapping("deleteAppointment.do")
	public String deleteAppointment(Model model, int apNum) {
		int result = mcs.deleteAp(apNum);
		model.addAttribute("result", result);
		return "/member/deleteAppointment";
	}

	@RequestMapping("deleteMember.do")
	public String deleteMember(Model model, HttpServletRequest request) {
		int result = 0;
		String id = (String) session.getAttribute("id");
		Member member = ms.selectId(id);
		String nick = member.getNick();
		String pass = request.getParameter("lvPass");
		if (bpPass.matches(pass, member.getPassword())) { // 비밀번호가 맞을 때
			result = ms.deleteMemberbyid(id);
			if (result == 1) {
				System.out.println("멤버삭제");
				if (ss.selectLocation(nick) != null) {
					ss.deleteLocation(nick);
					System.out.println("위치삭제");
				}
			} 
		} else {
			result = -1; // 비밀번호가 틀릴때
		}
		model.addAttribute("result", result);

		return "/member/deleteMember";
	}

	public static boolean isValidEmail(String email) {
		boolean err = false;
		String regex = "^[_a-zA-Z0-9-]+(.[_a-zA-Z0-9-]+)*@(?:\\w+\\.)+\\w+$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(email);
		if (m.matches()) {
			err = true;
		}
		return err;
	}

	public String getRamdomPassword(int size) {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a',
				'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
				'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&' };
		StringBuffer sb = new StringBuffer();
		SecureRandom sr = new SecureRandom();

		int idx = 0;
		int len = charSet.length;
		for (int i = 0; i < size; i++) {
			//
			idx = (int) (len * Math.random());
			idx = sr.nextInt(len);
			// 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다.
			sb.append(charSet[idx]);
		}
		return sb.toString();
	}
}