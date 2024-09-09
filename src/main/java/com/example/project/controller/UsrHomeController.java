package com.example.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.project.service.ArticleService;
import com.example.project.vo.Article;
import com.example.project.vo.Rq;

import org.springframework.ui.Model;
import java.util.List;

@Controller
public class UsrHomeController {
	@Autowired
	private Rq rq;

	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		List<Article> articles = articleService.getHitMainArticles();
        
        model.addAttribute("articles", articles);
		return "/usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {

		return "redirect:/usr/home/main";
	}

}
