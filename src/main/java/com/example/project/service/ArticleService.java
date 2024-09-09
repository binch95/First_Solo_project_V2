package com.example.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.Util.Ut;
import com.example.project.repository.ArticleRepository;
import com.example.project.vo.Article;
import com.example.project.vo.ResultData;

@Service
public class ArticleService {

	@Autowired
	private ArticleRepository articleRepository;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	public Article getArticleById(int id) {

		return articleRepository.getArticleById(id);
	}

	public List<Article> getForPrintArticles(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode,
			String searchKeyword) {

//		SELECT * FROM article WHERE boardId = 1 ORDER BY DESC LIMIT 0, 10; 1page
//		SELECT * FROM article WHERE boardId = 1 ORDER BY DESC LIMIT 10, 10; 2page

		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return articleRepository.getForPrintArticles(boardId, limitFrom, limitTake, searchKeywordTypeCode,
				searchKeyword);
	}
	
	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		return articleRepository.getArticleCount(boardId, searchKeywordTypeCode, searchKeyword);
	}

	public List<Article> getArticles() {
		return articleRepository.getArticles();
	}
	
	
	public List<Article> getHitMainArticles() {
		return articleRepository.getHitMainArticles();
	}



	private void controlForPrintData(int loginedMemberId, Article article) {
		if (article == null) {
			return;
		}
		ResultData userCanModifyRd = userCanModify(loginedMemberId, article);
		article.setUserCanModify(userCanModifyRd.isSuccess());

		ResultData userCanDeleteRd = userCanDelete(loginedMemberId, article);
		article.setUserCanDelete(userCanModifyRd.isSuccess());
	}

	public ResultData userCanDelete(int loginedMemberId, Article article) {
		if (article.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 게시글에 대한 삭제 권한이 없습니다", article.getId()));
		}
		return ResultData.from("S-1", Ut.f("%d번 게시글을 삭제했습니다", article.getId()));
	}

	public ResultData userCanModify(int loginedMemberId, Article article) {
		if (article.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 게시글에 대한 수정 권한이 없습니다", article.getId()));
		}
		return ResultData.from("S-1", Ut.f("%d번 게시글을 수정했습니다", article.getId()), "수정된 게시글", article);
	}


}
