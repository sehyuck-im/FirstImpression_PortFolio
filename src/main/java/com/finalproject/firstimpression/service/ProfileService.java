package com.finalproject.firstimpression.service;

import java.util.List;

import com.finalproject.firstimpression.model.Interest;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.model.TagList;
import com.finalproject.firstimpression.model.MyPreference;

public interface ProfileService {

	Profile selectProfileById(String id);

	int getTagCnt();

	String selectTag(int i);

	void updateInterest(Interest interest);

	int updateProfile(Profile profile);

	void insertInterest(Interest interest);

	Profile selectProfileByNick(String nick);

	int selectTagCnt(String nick);

	List<Interest> selectTempList(String nick);

	void saveTempList(List<Interest> tempList);

	void deleteInterest(String nick);

	List<Interest> rollbackInterest(String nick);

	void insertBackUp(List<Interest> backUp);

	void deleteTempInterest(String nick);

	MyPreference selectPreference(String nick);

	List<TagList> selectTags();
	
	List<Profile> selectProfile();

	int updatePreference(MyPreference preference);
	
	int getMale();
	int getFemale();
	int getBoth();

	String selectPhoto(String nick);

}
