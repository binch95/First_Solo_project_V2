package com.example.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.repository.ReactionPointRepository;
import com.example.project.vo.ResultData;

@Service
public class ReactionPointService {

	@Autowired
	private ArticleService articleService;

	@Autowired
	private ReactionPointRepository reactionPointRepository;

	
	
	public ResultData usersReaction(int loginedMemberId, int relId) {
		if (loginedMemberId == 0) {
			return ResultData.from("F-L", "로그인 하고 써야해");
		}

		int sumReactionPointByMemberId = reactionPointRepository.getSumReactionPoint(loginedMemberId, relId);

		if (sumReactionPointByMemberId != 0) {
			return ResultData.from("F-1", "추천 불가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
		}

		return ResultData.from("S-1", "추천 가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
	}



	public boolean isAlreadyAddGoodRp(int memberId, int relId) {
		int getPointTypeCodeByMemberId = reactionPointRepository.getSumReactionPoint(memberId, relId);

		if (getPointTypeCodeByMemberId > 0) {
			return true;
		}

		return false;
	}
	
	
	
	
}
