<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="pageTitle" value="LOGIN"></c:set>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<%@ include file="../common/head.jspf"%>
<script>
	const time_to_show_login = 400;
	const time_to_hidden_login = 200;

	function change_to_login() {
		document.querySelector('.cont_forms').className = "cont_forms cont_forms_active_login";
		document.querySelector('.cont_form_login').style.display = "block";
		document.querySelector('.cont_form_sign_up').style.opacity = "0";

		setTimeout(function() {
			document.querySelector('.cont_form_login').style.opacity = "1";
		}, time_to_show_login);

		setTimeout(
				function() {
					document.querySelector('.cont_form_sign_up').style.display = "none";

				}, time_to_hidden_login);

	}

	const time_to_show_sign_up = 100;
	const time_to_hidden_sign_up = 400;

	function change_to_sign_up(at) {
		document.querySelector('.cont_forms').className = "cont_forms cont_forms_active_sign_up";
		document.querySelector('.cont_form_sign_up').style.display = "block";
		document.querySelector('.cont_form_login').style.opacity = "0";

		setTimeout(function() {
			document.querySelector('.cont_form_sign_up').style.opacity = "1";
		}, time_to_show_sign_up);

		setTimeout(function() {
			document.querySelector('.cont_form_login').style.display = "none";
		}, time_to_hidden_sign_up);

	}

	const time_to_hidden_all = 500;

	function hidden_login_and_sign_up() {

		document.querySelector('.cont_forms').className = "cont_forms";
		document.querySelector('.cont_form_sign_up').style.opacity = "0";
		document.querySelector('.cont_form_login').style.opacity = "0";

		setTimeout(
				function() {
					document.querySelector('.cont_form_sign_up').style.display = "none";
					document.querySelector('.cont_form_login').style.display = "none";
				}, time_to_hidden_all);

	}
</script>
<style>
* {
	margin: 0px auto;
	padding: 0px;
	text-align: center;
	font-family: "Open Sans", sans-serif;
}

.nav-toggle-btn::after {
	content: "열기";
}

.nav-toggle-btn-open::after {
	content: "닫기";
}




.cotn_principal {
	position: absolute;
	width: 100%;
	display: flex;
	height: 100%;
	/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#cfd8dc+0,607d8b+100,b0bec5+100 */
	background-image:
		url(" https://images.unsplash.com/photo-1657216328529-3852a5f372cb?q=80&w=2030&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
	background-size: 200% 200%;
}

.cont_centrar {
	display: flex;
	align-self: center;
	width: 100%;
}

.cont_login {
	position: relative;
	width: 640px;
}

.cont_back_info {
	position: relative;
	float: left;
	width: 640px;
	height: 280px;
	overflow: hidden;
	background-color: #fff;
	box-shadow: 1px 10px 30px -10px rgba(0, 0, 0, 0.5);
}

.cont_forms {
	position: absolute;
	overflow: hidden;
	top: 0px;
	left: 0px;
	width: 320px;
	height: 280px;
	background-color: #eee;
	-webkit-transition: all 0.5s;
	-moz-transition: all 0.5s;
	-ms-transition: all 0.5s;
	-o-transition: all 0.5s;
	transition: all 0.5s;
}

.cont_forms_active_login {
	box-shadow: 1px 10px 30px -10px rgba(0, 0, 0, 0.5);
	height: 420px;
	top: -60px;
	left: 0px;
	-webkit-transition: all 0.5s;
	-moz-transition: all 0.5s;
	-ms-transition: all 0.5s;
	-o-transition: all 0.5s;
	transition: all 0.5s;
}

.cont_forms_active_sign_up {
	box-shadow: 1px 10px 30px -10px rgba(0, 0, 0, 0.5);
	height: 550px;
	top: -60px;
	left: 320px;
	-webkit-transition: all 0.5s;
	-moz-transition: all 0.5s;
	-ms-transition: all 0.5s;
	-o-transition: all 0.5s;
	transition: all 0.5s;
}

.cont_img_back_grey {
	position: absolute;
	width: 950px;
	top: -80px;
	left: -116px;
}

.cont_img_back_grey>img {
	width: 100%;
	-webkit-filter: grayscale(100%);
	filter: grayscale(100%);
	opacity: 0.2;
	animation-name: animar_fondo;
	animation-duration: 20s;
	animation-timing-function: linear;
	animation-iteration-count: infinite;
	animation-direction: alternate;
}

.cont_img_back_ {
	position: absolute;
	width: 950px;
	top: -80px;
	left: -116px;
}

.cont_img_back_>img {
	width: 100%;
	opacity: 0.3;
	animation-name: animar_fondo;
	animation-duration: 20s;
	animation-timing-function: linear;
	animation-iteration-count: infinite;
	animation-direction: alternate;
}

.cont_forms_active_login>.cont_img_back_ {
	top: -20px;
	-webkit-transition: all 0.5s;
	-moz-transition: all 0.5s;
	-ms-transition: all 0.5s;
	-o-transition: all 0.5s;
	transition: all 0.5s;
}

.cont_forms_active_sign_up>.cont_img_back_ {
	top: -20px;
	left: -435px;
	-webkit-transition: all 0.5s;
	-moz-transition: all 0.5s;
	-ms-transition: all 0.5s;
	-o-transition: all 0.5s;
	transition: all 0.5s;
}

.cont_info_log_sign_up {
	position: absolute;
	width: 640px;
	height: 280px;
	top: 0px;
	z-index: 1;
}

.col_md_login {
	position: relative;
	float: left;
	width: 50%;
}

.col_md_login>h2 {
	font-weight: 400;
	margin-top: 70px;
	color: #757575;
}

.col_md_login>p {
	font-weight: 400;
	margin-top: 15px;
	width: 80%;
	color: #37474f;
}

.btn_login {
	background-color: #26c6da;
	border: none;
	padding: 10px;
	width: 200px;
	border-radius: 3px;
	box-shadow: 1px 5px 20px -5px rgba(0, 0, 0, 0.4);
	color: #fff;
	margin-top: 10px;
	cursor: pointer;
}

.col_md_sign_up {
	position: relative;
	float: left;
	width: 50%;
}

.cont_ba_opcitiy>h2 {
	font-weight: 400;
	color: #fff;
}

.cont_ba_opcitiy>p {
	font-weight: 400;
	margin-top: 15px;
	color: #fff;
}
/* ----------------------------------
background text    
------------------------------------
 */
.cont_ba_opcitiy {
	position: relative;
	background-color: rgba(120, 144, 156, 0.55);
	width: 80%;
	border-radius: 3px;
	margin-top: 60px;
	padding: 15px 0px;
}

.btn_sign_up {
	background-color: #ef5350;
	border: none;
	padding: 10px;
	width: 200px;
	border-radius: 3px;
	box-shadow: 1px 5px 20px -5px rgba(0, 0, 0, 0.4);
	color: #fff;
	margin-top: 10px;
	cursor: pointer;
}

.cont_forms_active_sign_up {
	z-index: 2;
}

@
-webkit-keyframes animar_fondo {from { -webkit-transform:scale(1)translate(0px);
	-moz-transform: scale(1) translate(0px);
	-ms-transform: scale(1) translate(0px);
	-o-transform: scale(1) translate(0px);
	transform: scale(1) translate(0px);
}

to {
	-webkit-transform: scale(1.5) translate(50px);
	-moz-transform: scale(1.5) translate(50px);
	-ms-transform: scale(1.5) translate(50px);
	-o-transform: scale(1.5) translate(50px);
	transform: scale(1.5) translate(50px);
}

}
@
-o-keyframes identifier {from { -webkit-transform:scale(1);
	-moz-transform: scale(1);
	-ms-transform: scale(1);
	-o-transform: scale(1);
	transform: scale(1);
}

to {
	-webkit-transform: scale(1.5);
	-moz-transform: scale(1.5);
	-ms-transform: scale(1.5);
	-o-transform: scale(1.5);
	transform: scale(1.5);
}

}
@
-moz-keyframes identifier {from { -webkit-transform:scale(1);
	-moz-transform: scale(1);
	-ms-transform: scale(1);
	-o-transform: scale(1);
	transform: scale(1);
}

to {
	-webkit-transform: scale(1.5);
	-moz-transform: scale(1.5);
	-ms-transform: scale(1.5);
	-o-transform: scale(1.5);
	transform: scale(1.5);
}

}
@
keyframes identifier {from { -webkit-transform:scale(1);
	-moz-transform: scale(1);
	-ms-transform: scale(1);
	-o-transform: scale(1);
	transform: scale(1);
}

to {
	-webkit-transform: scale(1.5);
	-moz-transform: scale(1.5);
	-ms-transform: scale(1.5);
	-o-transform: scale(1.5);
	transform: scale(1.5);
}

}
.cont_form_login {
	position: absolute;
	display: none;
	width: 320px;
	-webkit-transition: all 0.5s;
	-moz-transition: all 0.5s;
	-ms-transition: all 0.5s;
	-o-transition: all 0.5s;
	transition: all 0.5s;
}

.cont_forms_active_login {
	z-index: 2;
}

.cont_form_sign_up {
	position: absolute;
	width: 320px;
	float: left;
	opacity: 0;
	display: none;
	-webkit-transition: all 0.5s;
	-moz-transition: all 0.5s;
	-ms-transition: all 0.5s;
	-o-transition: all 0.5s;
	transition: all 0.5s;
}

.cont_form_sign_up>input {
	text-align: left;
	padding: 15px 5px;
	margin-left: 10px;
	margin-top: 20px;
	width: 260px;
	border: none;
	color: #757575;
}

.cont_form_sign_up>h2 {
	margin-top: 50px;
	font-weight: 400;
	color: #757575;
}

.cont_form_login>input {
	padding: 15px 5px;
	margin-left: 10px;
	margin-top: 20px;
	width: 260px;
	border: none;
	text-align: left;
	color: #757575;
}

.cont_form_login>h2 {
	margin-top: 110px;
	font-weight: 400;
	color: #757575;
}

.cont_form_login>a, .cont_form_sign_up>a {
	color: #757575;
	position: relative;
	float: left;
	margin: 10px;
	margin-left: 30px;
}

.topmenu{
display: flex;
justify-content: flex-end;
}

.loginnone{
display: none;
}
</style>
<script>
$(document).ready(function() {
    var mainHeader = $('#mainHeader');
    var navToggleBtn = $('#navToggleBtn');

    // 로그인 페이지 로드 시 header를 숨깁니다.
    mainHeader.hide();  // jQuery의 hide() 메서드를 사용하여 숨김

    // 네비게이션 버튼을 항상 표시합니다.
    navToggleBtn.css('display', 'block');

    // 토글 버튼 클릭 시 메뉴를 슬라이드로 표시/숨김
    window.toggleMenu = function() {
        if (mainHeader.is(':visible')) {
            mainHeader.slideUp(300); // 슬라이드 업 애니메이션
            navToggleBtn.removeClass('nav-toggle-btn-open');
        } else {
            mainHeader.slideDown(300); // 슬라이드 다운 애니메이션
            navToggleBtn.addClass('nav-toggle-btn-open');
        }
    };
});
</script>

</head>



<body>
	<div class="navBtn flex justify-center ">
		<button id="navToggleBtn" class="nav-toggle-btn" onclick="toggleMenu()">&#9776; 메뉴</button>
	</div>
	<div class="cotn_principal">

		<div class="cont_centrar">

			<div class="cont_login">
				<div class="cont_info_log_sign_up">
					<div class="col_md_login">
						<div class="cont_ba_opcitiy">

							<h2>LOGIN</h2>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
							<button class="btn_login" onclick="change_to_login()">LOGIN</button>
						</div>
					</div>
					<div class="col_md_sign_up">
						<div class="cont_ba_opcitiy">
							<h2>SIGN UP</h2>


							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

							<button class="btn_sign_up" onclick="change_to_sign_up()">SIGN UP</button>
						</div>
					</div>
				</div>


				<div class="cont_back_info">
					<div class="cont_img_back_grey">
						<img
							src="https://media.istockphoto.com/id/1495955855/ko/%EC%82%AC%EC%A7%84/%EA%B2%BD%EB%A7%A4%EC%97%90-%EC%95%89%EC%95%84-%EC%9E%88%EB%8A%94-%EC%82%AC%EB%9E%8C%EB%93%A4%EC%9D%98-%EA%B7%B8%EB%A3%B9.jpg?s=2048x2048&w=is&k=20&c=rgsb0aDXpZUar6Lco2cCBBesqecMOmrctHvFI7gYfcY="
							alt="" />
					</div>

				</div>
				<div class="cont_forms">
					<div class="cont_img_back_">
						<img
							src="https://media.istockphoto.com/id/1495955855/ko/%EC%82%AC%EC%A7%84/%EA%B2%BD%EB%A7%A4%EC%97%90-%EC%95%89%EC%95%84-%EC%9E%88%EB%8A%94-%EC%82%AC%EB%9E%8C%EB%93%A4%EC%9D%98-%EA%B7%B8%EB%A3%B9.jpg?s=2048x2048&w=is&k=20&c=rgsb0aDXpZUar6Lco2cCBBesqecMOmrctHvFI7gYfcY="
							alt="" />
					</div>

					<form action="../member/doLogin" method="POST">
						<div class="cont_form_login">
							<a href="#" onclick="hidden_login_and_sign_up()"><i class="material-icons">arrow_back</i></a>
							<h2>LOGIN</h2>
							<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" /> <input type="text" name="loginId"
								autocomplete="off" placeholder="LoginId" /> <input type="password" name="loginPw" autocomplete="off"
								placeholder="Password" />
							<button class="btn_login">LOGIN</button>
							<a href="/oauth2/authorization/google" style="text-decoration: none;">
    <div style="display: inline-block; background-color: #4285F4; color: white; padding: 10px 20px; border-radius: 5px; font-family: Arial, sans-serif; font-size: 14px; cursor: pointer;">
        Sign in with Google <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google Logo" style="vertical-align: middle; width: 20px; margin-right: 10px; display: inline-block;">
    </div>
</a>
						</div>
					</form>

					<form action="../member/doSign" method="POST">
						<div class="cont_form_sign_up">
							<a href="#" onclick="hidden_login_and_sign_up()"><i class="material-icons">&#xE5C4;</i></a>
							<h2>SIGN UP</h2>
							<input type="text" placeholder="LoginId" name="loginId" autocomplete="off" /> <input type="password"
								placeholder="Password" name="loginPw" autocomplete="off" /> <input type="text" placeholder="Name" name="name"
								autocomplete="off" /> <input type="text" placeholder="Email" name="email" autocomplete="off" /> <input
								type="text" placeholder="Phone_Num" name="cellphoneNum" autocomplete="off" />
							<button class="btn_sign_up">SIGN UP</button>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>

</body>
</html>