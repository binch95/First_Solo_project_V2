<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<hr />

<!-- 변수 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}')
	
	
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	var isAlreadyAddBadRp = ${isAlreadyAddBadRp};
</script>

<!-- 조회수 -->
<script>
	function ArticleDetail__doIncreaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyOnView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);

		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json')
	}

	$(function() {
		// 		ArticleDetail__doIncreaseHitCount();
		setTimeout(ArticleDetail__doIncreaseHitCount, 2000);
	})
</script>

<script>
<!-- 좋아요 버튼 -->

$(function() {
	userCanReaction = ${userCanReaction	};
	$('.like-button').click(function() {
		if (userCanReaction == -2) {
			alert("이용할수 없습니다 로그인 해주세요");
			location.href = '../member/login';
			return false;
		}
		
		params.comid = $(this).attr('id');
		params.updown = 1;
		params.type = $(this).attr('name');
		console.log(params.comid);
		$('.doNotlike-button').removeClass('clickOn');
		$.get('../article/doInOutLikeCountRd', {
			id : params.id,
			upAnddown : 1,
			comid : params.comid,
			relTypeCode : params.type,
			ajaxMode : 'Y'
		}, function(data) {

			if ($('.like-button' + params.type).hasClass('clickOn')) {
				$('.like-button' + params.type).removeClass('clickOn');
			}
			if (!data.fail) {
				$('.like-button' + params.type).addClass('clickOn');
			}
			const selector = params.type == 'article' ? `.goodReactionPoint` + params.type : `.goodReactionPointcomment` + params.comid;
			$(selector).empty().html(data.data1);
		}, 'json');
	});
});
</script>

<section class="mt-24 text-xl px-4">
	<div class="mx-auto">
		<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
			<tbody>
				<tr>
					<th style="text-align: center;">ID</th>
					<td style="text-align: center;">${article.id}</td>
				</tr>
				<tr>
					<th style="text-align: center;">Registration Date</th>
					<td style="text-align: center;">${article.regDate }</td>
				</tr>
				<tr>
					<th style="text-align: center;">Modified date</th>
					<td style="text-align: center;">${article.updateDate}</td>
				</tr>
				<tr>
					<th style="text-align: center;">BoardId</th>
					<td style="text-align: center;">${article.boardId}</td>
				</tr>
				<tr>
					<th class="reaction" style="text-align: center;">Like</th>
					<td id="likeCount" style="text-align: center;">${article.goodReactionPoint}</td>
				</tr>
				<tr>
					<th style="text-align: center;">LIKE / Dislike / ${usersReaction }</th>
					<td style="text-align: center;">

						<button id="likeButton" class="btn btn-outline btn-success" onclick="doGoodReaction(${param.id})">
							👍 LIKE <span class="likeCount">${article.goodReactionPoint}</span>
						</button> <%-- 						<a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.currentUri}" --%>
						<%-- 							class="btn btn-outline btn-success">👍 LIKE ${article.goodReactionPoint}</a> --%>
					</td>
				</tr>

				<tr>
					<th style="text-align: center;">Views</th>

					<td style="text-align: center;"><span class="article-detail__hit-count">${article.hitCount}</span></td>

				</tr>
				<tr>
					<th style="text-align: center;">Title</th>
					<td style="text-align: center;">${article.title}</td>
				</tr>
				<tr>
					<th style="text-align: center;">Attached Image</th>
					<td style="text-align: center;">
						<div style="text-align: center;">
							<img class="mx-auto rounded-xl" src="${rq.getImgUri(article.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}"
								alt="" />
						</div>
						<div>${rq.getImgUri(article.id)}</div>
					</td>
				</tr>
				<tr>
					<th style="text-align: center;">Body</th>
					<td>
						<div class="toast-ui-viewer">
							<script type="text/x-template">${article.body}</script>
						</div>
					</td>
				</tr>

			</tbody>
		</table>
		<div class="btns">
			<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
			<c:if test="${article.userCanModify }">
				<a class="btn" href="../article/modify?id=${article.id }">수정</a>
			</c:if>
			<c:if test="${article.userCanDelete }">
				<a class="btn" href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>

		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>
