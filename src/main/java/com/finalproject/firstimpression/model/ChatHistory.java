package com.finalproject.firstimpression.model;


import lombok.Data;

@Data
public class ChatHistory {
	private int sendOrder;
	private String chatRoomNo;
	private String sendUser;
	private String message;
	private int readCount;
}