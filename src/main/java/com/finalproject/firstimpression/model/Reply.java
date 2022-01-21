package com.finalproject.firstimpression.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Reply {
	private int rpNum;
    private int anNum;
    private String replyContent;
    private String nick;
    private Date replyDate;
    private String replyDel;
    private String rpCheck;
    private int ref;
    private int ref_level;
    private int ref_step;
    // 프로필 사진용
    private Profile profile;
}
