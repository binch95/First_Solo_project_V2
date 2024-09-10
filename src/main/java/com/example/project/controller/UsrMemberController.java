package com.example.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project.Util.Ut;
import com.example.project.service.MemberService;
import com.example.project.vo.Member;
import com.example.project.vo.ResultData;
import com.example.project.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class UsrMemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	private Rq rq;
		
	@RequestMapping("/usr/member/loginOrsign")
	public String showLogin(HttpServletRequest req) {
		return "/usr/member/login&sign";
	}
	

	@RequestMapping("/usr/member/doSign")
	@ResponseBody
	public String doSign(HttpServletRequest req, String loginId, String loginPw, String name,  String cellphoneNum, String email) {

		if (Ut.isEmptyOrNull(loginId)) {
			return Ut.jsHistoryBack("F-1", "loginId 입력 x");
		}
		if (Ut.isEmptyOrNull(loginPw)) {
			return Ut.jsHistoryBack("F-2", "loginPw 입력 x");
		}
		if (Ut.isEmptyOrNull(name)) {
			return Ut.jsHistoryBack("F-3", "name 입력 x");
		}
		if (Ut.isEmptyOrNull(cellphoneNum)) {
			return Ut.jsHistoryBack("F-5", "cellphoneNum 입력 x");
		}
		if (Ut.isEmptyOrNull(email)) {
			return Ut.jsHistoryBack("F-6", "email 입력 x");
		}

		ResultData signRd = memberService.sign(loginId, loginPw, name,  email,cellphoneNum);

		if (signRd.isFail()) {
			return Ut.jsHistoryBack(signRd.getResultCode(), signRd.getMsg());
		}

		Member member = memberService.getMemberById((int) signRd.getData1());

		return Ut.jsReplace(signRd.getResultCode(), signRd.getMsg(), "../member/loginOrsign");
	}
	
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, String loginId, String loginPw, String afterLoginUri) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isEmptyOrNull(loginId)) {
			return Ut.jsHistoryBack("F-1", "loginId 입력 x");
		}
		if (Ut.isEmptyOrNull(loginPw)) {
			return Ut.jsHistoryBack("F-2", "loginPw 입력 x");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			return Ut.jsHistoryBack("F-3", Ut.f("%s는(은) 존재 x", loginId));
		}

		if (member.getLoginPw().equals(Ut.sha256(loginPw)) == false) {
			return Ut.jsHistoryBack("F-4", Ut.f("비밀번호가 일치하지 않습니다!!!!!"));
		}
		
		rq.login(member);
		
		if (afterLoginUri.length() > 0) {
			return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getName()), afterLoginUri);
		}

		return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getName()), "/");
	}
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {

		rq.logout();

		return Ut.jsReplace("S-1", Ut.f("로그아웃 성공"), "/");
	}

}
