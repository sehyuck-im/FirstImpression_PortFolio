package com.finalproject.firstimpression.model;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Profile {
	private String nick;
	private String id;
	private int age;
	private String gender;
	private String intro;
	private String photo1;
	private String photo2;
	private String photo3;
	private String del;
	// upload
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	// tagList
	private List<Interest> interest; 
	// location
	private Location location;
	private String signInTime;
	private Double distance;
}
