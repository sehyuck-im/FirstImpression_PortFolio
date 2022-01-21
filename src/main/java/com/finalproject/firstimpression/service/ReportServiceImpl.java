package com.finalproject.firstimpression.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.firstimpression.dao.ReportDao;
import com.finalproject.firstimpression.model.Report;


@Service
public class ReportServiceImpl implements ReportService {
	
	@Autowired
	private ReportDao rd;
	
	public List<Report> selectReportM(){
		return rd.selectReportM();
	}

	@Override
	public int reportCheck(int repNum) {
		// TODO Auto-generated method stub
		return rd.reportCheck(repNum);
	}
	

}
