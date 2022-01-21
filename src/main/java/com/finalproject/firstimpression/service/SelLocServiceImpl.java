package com.finalproject.firstimpression.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.firstimpression.dao.SelLocDao;
import com.finalproject.firstimpression.model.SelLoc;


@Service
public class SelLocServiceImpl implements SelLocService {
	@Autowired
	private SelLocDao sd;
	

	@Override
	public void insertSelLoc(SelLoc selLoc) {
		// TODO Auto-generated method stub
		sd.insertSelLoc(selLoc);
	}


	@Override
	public List<SelLoc> selectLocation(String chatRoomNo) {
		// TODO Auto-generated method stub
		return sd.selectLocation(chatRoomNo);
	}

	public void deleteLocation(String nick) {
		sd.deleteLocation(nick);
	}
	
}
