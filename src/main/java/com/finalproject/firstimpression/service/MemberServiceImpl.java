package com.finalproject.firstimpression.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.firstimpression.dao.MemberDao;
import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.MasterMemberInfo;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.MyPreference;
import com.finalproject.firstimpression.model.Profile;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao md;

	public Member selectId(String id) {

		return md.selectId(id);
	}

	public Member selectNick(String nick) {

		return md.selectNick(nick);
	}

	public int insert(Member member) {

		return md.insert(member);
	}

	public int insertNaver(Member member) {

		return md.insertNaver(member);
	}

	public int insertProfile(Profile profile) {

		return md.insertProfile(profile);
	}
	public int insertProfileNaver(Profile profile) {

		return md.insertProfileNaver(profile);
	}

	public int updateProfile(Member member) {

		return md.updateProfile(member);
	}
	
	public Profile selectProfileById(String id) {
		return md.selectProfileById(id);
	}
	
	public int getAge(String id) {

		return md.getAge(id);
	}

	public Location selectlocation(String nick) {
		return md.selectlocation(nick);
	}

	public void insertlocation(Location location) {
		md.insertlocation(location);
		
	}

	public void updatelocation(Location location) {
		md.updatelocation(location);
		
	}

	public Profile selectProfileByNick(String nick) {
		return md.selectProfileByNick(nick);
	}
	public int insertPreference(MyPreference preference) {

		return md.insertPreference(preference);
	}
	public void deleteProfileAndPre(String nick) {

		md.deleteProfileAndPre(nick);
	}
	
	public List<MasterMemberInfo> selectMasterMemberInfo() {

		return md.selectMasterMemberInfo();
	}
	public int calTime(Location location) {
		return md.calTime(location);
	}
	public int deleteMemberbyid(String id) {
		return md.deleteMemberbyid(id);
	}
	public int restoreMemberbyid(String id) {
		return md.restoreMemberbyid(id);
	}
	public int updateMember(Member member) {

		return md.updateMember(member);
	}
	public int checkEmail(String email) {

		return md.checkEmail(email);
	}
	public String findID(Member member) {

		return md.findID(member);
	}
	public int checkPass(Member checkPass) {

		return md.checkPass(checkPass);
	}
	public void setNewPass(Member checkPass) {
		md.setNewPass(checkPass);
	}
	public void deleteMember(String id) {
		md.deleteMember(id);
	}
	public Integer countId(Member member) {

		return md.countId(member);
	}
}
