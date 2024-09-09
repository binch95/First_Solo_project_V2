package com.example.project.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class bids {

	private int id;
	private int user_id;
	private int article_id;
	private int bid_amount;
	private String bid_Date;
}
