package com.finalproject.firstimpression.dao;


import java.util.List;

import com.finalproject.firstimpression.model.SelLoc;


public interface SelLocDao {
	
	void insertSelLoc(SelLoc selLoc);

	List<SelLoc> selectLocation(String chatRoomNo);

	void deleteLocation(String nick);

	

}
