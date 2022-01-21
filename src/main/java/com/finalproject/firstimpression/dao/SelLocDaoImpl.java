package com.finalproject.firstimpression.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalproject.firstimpression.model.SelLoc;


@Repository
public class SelLocDaoImpl implements SelLocDao {
	@Autowired
	private SqlSessionTemplate sst;		
	

	@Override
	public void insertSelLoc(SelLoc selLoc) {
		// TODO Auto-generated method stub
		sst.insert("selLocns.insert", selLoc);
	}

	@Override
	public List<SelLoc> selectLocation(String chatRoomNo) {
		// TODO Auto-generated method stub
		return sst.selectList("selLocns.selectLocation",chatRoomNo);
	}	
	public void deleteLocation(String nick) {
		sst.delete("locationns.deleteLocation", nick);
	}
}
