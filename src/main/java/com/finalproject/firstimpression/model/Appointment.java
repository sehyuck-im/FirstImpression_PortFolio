package com.finalproject.firstimpression.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Appointment {
	private int apNum;
	private String chatRoomNo;
	private String location;
	private String appointmentTime;
	private Date appointmentdate;
	private String appodel;
	private String appnick;
	//약속잡은사람 프로파일용
	private Profile profile;
}
