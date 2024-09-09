package com.example.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class transactions {

	private int id;
	private String transactions_Date;
	private int article_id;
	private int buyer_id;
	private int seller_id;
	private int order_id;
	private int transaction_amount;
	private String transaction_status; //거래완료?, 거래취소? 등

}
//transactions