package com.finalproject.firstimpression.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.model.TagList;
import com.finalproject.firstimpression.model.MyPreference;

@Repository
public class ProfileDaoImpl implements ProfileDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	public Profile selectProfileById(String id) {

		return sst.selectOne("profilens.selectProfileById", id);
	}
	public int getTagCnt() {

		return sst.selectOne("profilens.getTagCnt");
	}
	public String selectTag(int i) {

		return sst.selectOne("profilens.selectTag", i);
	}
	public void updateInterest(Interest interest) {

		sst.update("profilens.updateInterest", interest);
	}
	public int updateProfile(Profile profile) {

		return sst.update("profilens.updateProfile", profile);
	}
	public void insertInterest(Interest interest) {
		
		sst.insert("profilens.insertInterest", interest);
	}
	public Profile selectProfileByNick(String nick) {

		return sst.selectOne("profilens.selectProfileByNick", nick);
	}
	public int selectTagCnt(String nick) {

		return sst.selectOne("profilens.selectTagCnt", nick);
	}
	public List<Interest> selectTempList(String nick) {

		return sst.selectList("profilens.selectTempList", nick);
	}
	public void saveTempList(List<Interest> tempList) {

		sst.insert("profilens.saveTempList", tempList);
	}
	public void deleteInterest(String nick) {

		sst.delete("profilens.deleteInterest", nick);
	}
	public List<Interest> rollbackInterest(String nick) {

		return sst.selectList("profilens.rollbackInterest", nick);
	}
	public void insertBackUp(List<Interest> backUp) {

		sst.insert("profilens.insertBackUp", backUp);
			
	}
	public void deleteTempInterest(String nick) {

		sst.delete("profilens.deleteTemp", nick);
	}
	public MyPreference selectPreference(String nick) {

		return sst.selectOne("profilens.selectPreference", nick);
	}
	public int updatePreference(MyPreference preference) {

		return sst.update("profilens.updatePreference", preference);
	}
	public List<TagList> selectTags() {

		return sst.selectList("profilens.selectTags");
	}
	public List<Profile> selectProfile() {

		return sst.selectList("profilens.selectProfile");
	}
	
	public int getMale() {
		return sst.selectOne("profilens.getMale");
	}
	public int getFemale() {
		return sst.selectOne("profilens.getFemale");
	}
	public int getBoth() {
		return sst.selectOne("profilens.getBoth");
	}
	public String selectPhoto(String nick) {

		return sst.selectOne("profilens.selectPhoto", nick);
	}
	
}
