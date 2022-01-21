package com.finalproject.firstimpression.model;

import org.springframework.web.multipart.MultipartFile;
import java.util.List;

import lombok.Data;
import oracle.sql.DATE;

@Data
public class AnoFeed {
	private int anNum;
	private String anTitle;
	private String anContent;
	private String nick;
	private String photo;
	private DATE anDate;
	private String anDel;
	private String anCheck;
	private int likeCount;
	private int replyCount;
//	파일 업로드
	private MultipartFile file;
	//출력용
	private List<HashTag> hashTag;
	private List<Reply> reply;
	//좋아요
	private String likeChk;
	//작성자 프로필 불러오기용
	private Profile profile;
}
