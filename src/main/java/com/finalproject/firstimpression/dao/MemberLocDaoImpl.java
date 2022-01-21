package com.finalproject.firstimpression.dao;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalproject.firstimpression.model.MemberLoc;


@Repository
public class MemberLocDaoImpl implements MemberLocDao {
	@Autowired
	private SqlSessionTemplate sst;		
	

	@Override
	public void insertMemberLoc(MemberLoc memberLoc) {
		// TODO Auto-generated method stub
		sst.insert("memberLocns.insert", memberLoc);
	}
	
	@Override
	public void updateMemberLoc(MemberLoc memberLoc) {
		// TODO Auto-generated method stub
		sst.update("memberLocns.update", memberLoc);
	}
	
}
