package com.example.project.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ReactionPointRepository {

	@Select("""
			SELECT IFNULL(SUM(RP.point),0)
			FROM reactionPoint AS RP
			WHERE RP.relId = #{relId}
			AND RP.memberId = #{memberId}
			""")
	public int getSumReactionPoint(int memberId, int relId);
	

}
