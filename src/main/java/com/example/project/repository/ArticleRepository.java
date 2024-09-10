package com.example.project.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.project.vo.Article;


@Mapper
public interface ArticleRepository {

	@Select("""
			SELECT *
			FROM article
			WHERE id = #{id}
				""")
	public Article getArticleById(int id);

	
	@Select("""
			<script>
				SELECT COUNT(*), A.*
				FROM article AS A
				INNER JOIN `member` AS M
				ON A.memberId = M.id
				WHERE 1
				<if test="boardId != 0">
					AND A.boardId = #{boardId}
				</if>
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchKeywordTypeCode == 'title'">
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'body'">
							AND A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<otherwise>
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
							OR A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</otherwise>
					</choose>
				</if>
				ORDER BY A.id DESC;
			</script>
			""")
	public int getArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword);
	
	@Select("""
			SELECT A.* , M.name AS name
			FROM article AS A
			INNER JOIN `member` AS M
			ON A.memberId = M.id
			ORDER BY A.id DESC
			""")
	public List<Article> getArticles();

	
	@Select("""
			SELECT *
			FROM article
			ORDER BY hitCount
			limit 10
			""")
	public List<Article> getHitMainArticles();
	
	@Select("""
			<script>
				SELECT A.*
				FROM article AS A
				INNER JOIN `member` AS M
				ON A.memberId = M.id
				WHERE 1
				<if test="boardId != 0">
					AND boardId = #{boardId}
				</if>
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchKeywordTypeCode == 'title'">
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'body'">
							AND A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<otherwise>
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
							OR A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</otherwise>
					</choose>
				</if>
				GROUP BY A.id
				ORDER BY A.id DESC
				<if test="limitFrom >= 0">
					LIMIT #{limitFrom}, #{limitTake}
				</if>
				</script>
			""")
	public List<Article> getForPrintArticles(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode,
			String searchKeyword);


	
	@Select("""
			SELECT * from article
			WHERE id = #{id}
			""")
	public Article getForPrintArticle(int id);


	@Update("""
			UPDATE article
			SET hitCount = hitCount + 1
			WHERE id = #{id}
			""")
	public int increaseHitCount(int id);


	@Select("""
			SELECT hitCount
			FROM article
			WHERE id = #{id}
				""")
	public int getArticleHitCount(int id);


	@Delete("""
			DELETE FROM article
			WHERE id = #{id}
			""")
	public void deleteArticle(int id);


	@Select("""
			SELECT MAX(id) + 1
			FROM article
			""")
	public int getCurrentArticleId();

	@Insert("""
			INSERT INTO article
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			boardId = #{boardId},
			title = #{title},
			`body` = #{body}
			""")
	public void writeArticle(int memberId, String title, String body, String boardId);


	@Select("SELECT LAST_INSERT_ID();")
	public int getLastInsertId();

	@Update("""
			UPDATE article
			SET updateDate = NOW(),
			title = #{title},
			`body` = #{body}
			WHERE id = #{id}
			""")
	public void modifyArticle(int id, String title, String body);


}
