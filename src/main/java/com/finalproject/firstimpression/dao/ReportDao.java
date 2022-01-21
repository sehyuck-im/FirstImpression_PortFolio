package com.finalproject.firstimpression.dao;

import java.util.List;

import com.finalproject.firstimpression.model.Report;

public interface ReportDao {
	List<Report> selectReportM();

	int reportCheck(int repNum);

}
