package com.finalproject.firstimpression.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.firstimpression.dao.MemberLocDao;
import com.finalproject.firstimpression.model.MemberLoc;


@Service
public class MemberLocServiceImpl implements MemberLocService {
	@Autowired
	private MemberLocDao md;
	

	@Override
	public void insertMemberLoc(MemberLoc memberLoc) {
		// TODO Auto-generated method stub
		md.insertMemberLoc(memberLoc);
	}
	
	@Override
	public void updateMemberLoc(MemberLoc memberLoc) {
		// TODO Auto-generated method stub
		md.updateMemberLoc(memberLoc);
	}

}
