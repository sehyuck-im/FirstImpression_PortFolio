package com.finalproject.firstimpression.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalproject.firstimpression.model.Report;

@Repository
public class ReportDaoImpl implements ReportDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	@Override
	public List<Report> selectReportM(){
		return sst.selectList("reportns.selectReportM");
	}

	@Override
	public int reportCheck(int repNum) {
		// TODO Auto-generated method stub
		return sst.update("reportns.reportCheck",repNum);
	}

}
