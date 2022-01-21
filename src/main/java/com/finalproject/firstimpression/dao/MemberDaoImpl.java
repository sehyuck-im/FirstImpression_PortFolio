package com.finalproject.firstimpression.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.MasterMemberInfo;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.MyPreference;
import com.finalproject.firstimpression.model.Profile;

@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	public Member selectId(String id) {

		return sst.selectOne("memberns.selectId", id);
	}
	public Member selectNick(String nick) {

		return sst.selectOne("memberns.selectNick", nick);
	}
	public int insert(Member member) {

		return sst.insert("memberns.insert", member);
	}
	public int insertProfile(Profile profile) {

		return sst.insert("memberns.insertProfile", profile);
	}
	public int insertProfileNaver(Profile profile) {

		return sst.insert("memberns.insertProfileNaver", profile);
	}
	public int insertNaver(Member member) {

		return sst.insert("memberns.insertNaver", member);
	}
	public int updateProfile(Member member) {

		return sst.update("memberns.updateProfile",member);
	}
	public Profile selectProfileById(String id) {

		return sst.selectOne("memberns.selectProfileById", id);
	}
	public int getAge(String id) {

		return sst.selectOne("memberns.getAge", id);
	}
	public Location selectlocation(String nick) {
		return sst.selectOne("locationns.selectlocation",nick);
	}
	public void insertlocation(Location location) {
		sst.insert("locationns.insertlocation",location);
	}
	public void updatelocation(Location location) {
		sst.update("locationns.updatelocation",location);
		
	}
	public Profile selectProfileByNick(String nick) {
		return sst.selectOne("memberns.selectProfileByNick",nick);
	}
	public int insertPreference(MyPreference preference) {

		return sst.insert("memberns.insertPreference", preference);
	}
	public void deleteProfileAndPre(String nick) {

		sst.delete("memberns.deleteProfile", nick);
		sst.delete("memberns.deletePreference", nick);
	}
	
	public List<MasterMemberInfo> selectMasterMemberInfo() {

		return sst.selectList("memberns.selectMasterMemberInfo");
	}
	public int calTime(Location location) {

		return sst.selectOne("locationns.calTime", location);
	}
	public int deleteMemberbyid(String id) {
		return sst.update("memberns.deleteMemberbyid",id);
	}
	public int restoreMemberbyid(String id) {
		return sst.update("memberns.restoreMemberbyid",id);
	}
	public int updateMember(Member member) {

		return sst.update("memberns.updateMember", member);
	}
	public int checkEmail(String email) {

		return sst.selectOne("memberns.checkEmail", email);
	}
	public String findID(Member member) {

		return sst.selectOne("memberns.findID", member);
	}
	public int checkPass(Member checkPass) {

		return sst.selectOne("memberns.checkPass", checkPass);
	}
	public void setNewPass(Member checkPass) {
		sst.update("memberns.setNewPass", checkPass);
	}
	public void deleteMember(String id) {
		sst.delete("memberns.deleteMember", id);
	}
	@Override
	public Integer countId(Member member) {

		return sst.selectOne("memberns.countId", member);
	}
}
