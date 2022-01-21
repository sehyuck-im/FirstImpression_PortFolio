package com.finalproject.firstimpression.dao;

import java.util.List;

import com.finalproject.firstimpression.model.Location;
import com.finalproject.firstimpression.model.MasterMemberInfo;
import com.finalproject.firstimpression.model.Member;
import com.finalproject.firstimpression.model.MyPreference;
import com.finalproject.firstimpression.model.Profile;

public interface MemberDao {

	Member selectId(String id);

	Member selectNick(String nick);
	
	int insert(Member member);

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
