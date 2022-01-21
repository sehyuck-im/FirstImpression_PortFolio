package com.finalproject.firstimpression.model;

import java.sql.Date;

import lombok.Data;

@Data
public class MatchingHistory {
	private int mchNum;
	private String nickWhoLiked;
	private String targetNick;
	private int firstLike;
	private int secondLike;
	private int meetMade;
	private Date matchingdate;
}
