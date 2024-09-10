package com.example.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.example.project.Util.Ut;
import com.example.project.service.ArticleService;
import com.example.project.service.BoardService;
import com.example.project.service.GenFileService;
import com.example.project.service.ReactionPointService;
import com.example.project.vo.Article;
import com.example.project.vo.Board;
import com.example.project.vo.ResultData;
import com.example.project.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
public class UsrArticleController {
	@Autowired
	private Rq rq;

	@Autowired
	private ArticleService articleService;
	
	@Autowired
	private ReactionPointService reactionPointService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private GenFileService genFileService;
	
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
	
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), id);

		if (usersReactionRd.isSuccess()) {
			model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
		}


		model.addAttribute("article", article);

		model.addAttribute("isAlreadyAddGoodRp",
				reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id));

		return "usr/article/detail";
	}
	
	@RequestMapping("/usr/article/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData doIncreaseHitCount(int id) {

		ResultData increaseHitCountRd = articleService.increaseHitCount(id);

		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		ResultData rd = ResultData.newData(increaseHitCountRd, "hitCount", articleService.getArticleHitCount(id));

		rd.setData2("조회수가 증가된 게시글의 id", id);

		return rd;
	}
	
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
		}

		ResultData userCanDeleteRd = articleService.userCanDelete(rq.getLoginedMemberId(), article);

		if (userCanDeleteRd.isFail()) {
			return Ut.jsHistoryBack(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg());
		}

		if (userCanDeleteRd.isSuccess()) {
			articleService.deleteArticle(id);
		}

		return Ut.jsReplace(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg(), "../article/list");
	}
	
	@RequestMapping("/usr/article/write")
	public String showWrite(Model model) {

		int currentId = articleService.getCurrentArticleId();

		model.addAttribute("currentId", currentId);

		return "usr/article/write";
	}
	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, String boardId, String title, String body, String replaceUri,
			MultipartRequest multipartRequest) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isEmptyOrNull(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력해주세요");
		}
		if (Ut.isEmptyOrNull(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
		}
		if (Ut.isEmptyOrNull(boardId)) {
			return Ut.jsHistoryBack("F-3", "게시판을 선택해주세요");
		}

		System.err.println(boardId);

		ResultData writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body, boardId);

		int id = (int) writeArticleRd.getData1();

		Article article = articleService.getArticleById(id);

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, id);
			}
		}

		return Ut.jsReplace(writeArticleRd.getResultCode(), writeArticleRd.getMsg(), "../article/detail?id=" + id);

	}
	
	@RequestMapping("/usr/article/modify")
	public String showModify(HttpServletRequest req, Model model, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
		}

		model.addAttribute("article", article);

		return "/usr/article/modify";
	}
	
	// 로그인 체크 -> 유무 체크 -> 권한 체크 -> 수정
		@RequestMapping("/usr/article/doModify")
		@ResponseBody
		public String doModify(HttpServletRequest req, int id, String title, String body) {

			Rq rq = (Rq) req.getAttribute("rq");

			Article article = articleService.getArticleById(id);

			if (article == null) {
				return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
			}

			ResultData userCanModifyRd = articleService.userCanModify(rq.getLoginedMemberId(), article);

			if (userCanModifyRd.isFail()) {
				return Ut.jsHistoryBack(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg());
			}

			if (userCanModifyRd.isSuccess()) {
				articleService.modifyArticle(id, title, body);
			}

			article = articleService.getArticleById(id);

			return Ut.jsReplace(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg(), "../article/detail?id=" + id);
		}

}
