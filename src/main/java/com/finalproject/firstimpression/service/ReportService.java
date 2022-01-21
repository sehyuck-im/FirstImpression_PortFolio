package com.finalproject.firstimpression.service;

import java.util.List;

import com.finalproject.firstimpression.model.Report;

public interface ReportService {

	List<Report> selectReportM();

	int reportCheck(int repNum);

}
