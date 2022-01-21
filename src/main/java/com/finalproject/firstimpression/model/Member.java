package com.finalproject.firstimpression.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Member {
	private String id;
    private String password;
    private String name;
    private String nick;
    private String phone;
    private String email;
    private Date birth;
    private String address;
    private Date regDate;
    private String del;
    private String state;
    
}
