package com.example.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class orders {

	private int id;
	private String orders_Date;
	private int article_id;
	private int buyer_id;
	private int seller_id;
	private int order_price;	

}