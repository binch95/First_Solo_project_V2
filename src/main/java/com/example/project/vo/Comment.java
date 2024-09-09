package com.example.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment {

	private int id;
	private String regDate;
	private String updateDate;
	private int article_id;
	private int member_id;
	private String body;
	private String nickname;
}
