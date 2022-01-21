package com.finalproject.firstimpression.service;


import java.util.List;

import com.finalproject.firstimpression.model.SelLoc;

public interface SelLocService {
	
	void insertSelLoc(SelLoc selLoc);

	List<SelLoc> selectLocation(String chatRoomNo);
	
	void deleteLocation(String nick);
}
