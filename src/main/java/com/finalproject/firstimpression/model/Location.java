package com.finalproject.firstimpression.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Location {
	private String nick;
    private float latitude;
    private float longitude;
    private Date lastSignIn;
}
