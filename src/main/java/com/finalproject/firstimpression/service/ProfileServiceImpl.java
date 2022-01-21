package com.finalproject.firstimpression.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.firstimpression.dao.ProfileDao;
import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.model.TagList;
import com.finalproject.firstimpression.model.MyPreference;

@Service
public class ProfileServiceImpl implements ProfileService {
	@Autowired
	private ProfileDao pd;

	public Profile selectProfileById(String id) {

		return pd.selectProfileById(id);
	}
	public Profile selectProfileByNick(String nick) {

		return pd.selectProfileByNick(nick);
	}
	public int getTagCnt() {

		return pd.getTagCnt();
	}
	public String selectTag(int i) {

		return pd.selectTag(i);
	}
	public void updateInterest(Interest interest) {
		
		pd.updateInterest(interest);
	}
	public int updateProfile(Profile profile) {

		return pd.updateProfile(profile);
	}
	public void insertInterest(Interest interest) {
		
		pd.insertInterest(interest);
	}
	public int selectTagCnt(String nick) {

		return pd.selectTagCnt(nick);
	}
	public List<Interest> selectTempList(String nick) {

		return pd.selectTempList(nick);
	}
	public void saveTempList(List<Interest> tempList) {

		pd.saveTempList(tempList);
	}
	public void deleteInterest(String nick) {
		
		pd.deleteInterest(nick);
	}
	public List<Interest> rollbackInterest(String nick) {
		
		return pd.rollbackInterest(nick);
	}
	public void insertBackUp(List<Interest> backUp) {
		
		pd.insertBackUp(backUp);
	}
	public void deleteTempInterest(String nick) {
		
		pd.deleteTempInterest(nick);
	}
	public MyPreference selectPreference(String nick) {

		return pd.selectPreference(nick);
	}
	public int updatePreference(MyPreference preference) {
		
		return pd.updatePreference( preference);
	}
	public List<TagList> selectTags() {

		return pd.selectTags();
	}
	
	public List<Profile> selectProfile() {

		return pd.selectProfile();
	}
	
	public int getMale() {
		return pd.getMale();
	}
	public int getFemale() {
		return pd.getFemale();
	}
	public int getBoth() {
		return pd.getBoth();
	}
	public String selectPhoto(String nick) {

		return pd.selectPhoto(nick);
	}
	
}
