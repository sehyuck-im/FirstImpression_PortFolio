package com.finalproject.firstimpression.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.MasterMemberInfo;
import com.finalproject.firstimpression.model.MatchingHistory;
import com.finalproject.firstimpression.model.Profile;
import com.finalproject.firstimpression.model.ProfilePhoto;
import com.finalproject.firstimpression.model.MyPreference;

public interface MemberService {

	Member selectId(String id);

	int insert(Member member);

	Member selectNick(String nick);

	int updateProfile(Member member);

	int insertProfile(Profile profile);

	Profile selectProfileById(String id);

	int getAge(String id);

	Location selectlocation(String nick);

	void insertlocation(Location location);

	void updatelocation(Location location);

	Profile selectProfileByNick(String nick);

	int insertNaver(Member member);

	int insertProfileNaver(Profile profile);

	int insertPreference(MyPreference preference);

	void deleteProfileAndPre(String nick);
	
	List<MasterMemberInfo> selectMasterMemberInfo();

	int calTime(Location location);

	int deleteMemberbyid(String id);
	
	int restoreMemberbyid(String id);

	int updateMember(Member member);

	int checkEmail(String email);

	String findID(Member member);

	int checkPass(Member checkPass);

	void setNewPass(Member checkPass);

	void deleteMember(String id);

	Integer countId(Member member);


}
