package com.example.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.project.service.ArticleService;
import com.example.project.service.BoardService;
import com.example.project.vo.Article;
import com.example.project.vo.Board;
import com.example.project.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import java.io.IOException;
import java.util.List;

@Controller
public class UsrArticleController {
	@Autowired
	private Rq rq;

	@Autowired
	private ArticleService articleService;
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/usr/article/list")
	public String showList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "0") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) throws IOException {

		Rq rq = (Rq) req.getAttribute("rq");
		
			Board board = boardService.getBoardById(boardId);

		
		int articlesCount = articleService.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);

		// 한페이지에 글 10개
		// 글 20개 -> 2page
		// 글 25개 -> 3page
		int itemsInAPage = 20;

		int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

		List<Article> articles = articleService.getForPrintArticles(boardId, itemsInAPage, page, searchKeywordTypeCode,
				searchKeyword);

		if (board == null && searchKeyword == "") {
			return rq.historyBackOnView("없는 게시판임");
		}
		
		
		model.addAttribute("articles", articles);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("board", board);
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("boardId", boardId);

		return "usr/article/list";
	}

}
