package com.finalproject.firstimpression.model;

import java.sql.Date;

import lombok.Data;

@Data
public class MasterMemberInfo {
	
	private String id;
    private String password;
    private String name;
    private String nick;
    private String email;
    private Date regDate;
    private int age;
	private String gender;
	private String del;

}
