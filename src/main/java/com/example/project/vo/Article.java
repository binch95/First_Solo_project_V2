package com.example.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {

	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private int boardId;
	private String title;
	private String body;
	private int hitCount;
	private int price;
	private int bid;
	private int bidder_count;
	private int goodReactionPoint;
	private String remaining_time;
	private String is_sold;
	private String extra__writer;
	

	private boolean userCanModify;
	private boolean userCanDelete;
	
}
