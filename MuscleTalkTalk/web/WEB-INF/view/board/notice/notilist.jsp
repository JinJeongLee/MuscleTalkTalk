<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kh.semi.mtt.member.model.vo.MemberVo"%>
<%@page import="kh.semi.mtt.notice.model.vo.NoticeVo"%>
<%@ include file="/WEB-INF/view/csslink.jsp"%>
<%@ include file="/WEB-INF/view/font.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReadAllNotice</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%@ include file="/WEB-INF/view/font.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<style>
a{
      text-decoration: none;
      color: black;
}
a:visited {
      text-decoration: none;
      color: black;
}
a:link{
      text-decoration: none;
      color: black;
} 

section {
	margin-left: 210px;
	background-color: white;
	border-radius: 10px 10px 0 0;
	width: 930px;
	height: 2000px;
	position: relative;
	font-family:'THEmpgtM';
	}

#notice_main {
	/* margin-top: 65px; */
	/* margin-left: 65px; */
	padding-top: 65px;
	margin-left: 65px;
	font-weight: bold;
	display: inline-block;
	/* margin-bottom: 40px; */
	font-size: 15px;
}

#notice_top_button{
	padding-top: 65px;
	/* margin-bottom: 40px; */
	float: right;
}


#board_category {
	padding-top: 65px;
	margin-right: 65px;
	float: right;
	font-size: 12px;
}




#btn_search {
	height: 27px;
	width: 63px;
	font-size: 12px;
	padding: 12px auto;
	float: right;
}

#input_search {
	height: 24px;
	width: 203px;
	margin-top: 2.5px;
	margin-right: 10px;
	float: right;
	font-size: 12px;
}

#input_search::placeholder {
	font-size: 12px;
}

#input_search:focus {
	outline: none;
}

#sort {
	width: 94.5px;
	height: 32px;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-right: 65px;
	float: right;
	font-size: 12px;
}

#notice_table {
	margin: 50px auto;
	width: 800px;
	font-size: 12px;
}

.table_line {
	background: gray;
	background-clip: content-box;
	height: 1px !important;
}

#table_title {
	height: 38px;
	line-height: 38px;
}

.table_content {
	height: 50px;
	line-height: 50px;
}

.table_content :first-child {
	width: 60px;
	padding-left: 17px;
	box-sizing: border-box;
}

.search_notice {
	display: inline-block;
	float: right;
	margin-right: 60px;
}

.Pageing {
	text-align: center;
}

.Pageing a {
	border: 1px solid #4B4DB2;
}

.Pageingclick {
	background-color: #4B4DB2;
}

.Page {
	width: 30px;
	height: 30px;
	box-sizing: content-box;
	
}


</style>
</head>
<body bgcolor="#ECECEC">
<%@ include file="/WEB-INF/view/template.jsp"%>
	<section>
		<div id="notice_main">공지사항</div>
		<table id="notice_table">
			<tr>
				<td colspan="3" class="table_line"></td>
			</tr>
			<tr id="table_title">
				<td class="first_col"></td>
				<td style="width: 50%;">&nbsp;&nbsp;&nbsp;&nbsp;제목</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;등록일</td>
			</tr>
			<tr>
				<td colspan="3" class="table_line"></td>
			</tr>
			<c:forEach var="vo" items="${noticereadall}">
				<tr class="table_content">
					<td><a href="noticeread?noticeNo=${vo.noticeNo}">${vo.noticeNo }</a></td>
					<td><a href="noticeread?noticeNo=${vo.noticeNo}">${vo.notiTitle}</a></td>
					<td>${vo.notiDate}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="Pageing">
			<p>
				<c:if test="${startPage > 1 }">
					<a class="Page" href="noticereadall?page=${startPage-1 }">이전</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				<c:forEach begin="${startPage }" end="${endPage }" var="p">
					<a class="Page" href="noticereadall?page=${p }">${p }</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</c:forEach>
				<c:if test="${endPage < totalPageCnt }">
					<a class="Page" href="noticereadall?page=${endPage+1 }">다음</a>
				</c:if>
			<p>
		</div>
		<div class="search_notice">
				<button type="button" id="btn_search">검색</button>
				<input id="input_search" type="text" name="searchInput" 
					placeholder="검색어입력">
		</div>
		
	</section>
	<%@ include file="/WEB-INF/view/footer.jsp"%>
	<script>
	$("#btn_search").click(function(){
		console.log("btn_search CLICK");
		$.ajax({
			url:"noticereadall",
			type:"post",
			data:{inputsearch:$("#input_search").val()},
			dataType:"json",
			success: function(result){
				console.log(result);
				var html = "";
				for(var i = 0; i < result.noticereadall.length; i++){
                    var vo = result.noticereadall[i];
                    html += '<tr class="table_content">';
                    html += '<td><a href="noticeread?noticeNo='+vo.noticeNo+'">'+vo.noticeNo+'</a></td>';
                    html += '<td><a href="noticeread?noticeNo='+vo.noticeNo+'">'+vo.notiTitle+'</a></td>';
                    html += '<td>'+vo.notiDate+'</td>';
                    html += '</tr>';
                }
				$("#table_title").next().nextAll().remove();
				$("#notice_table").append(html);
			},
			error: function(result){
				
			}
		});
	});
	</script>
</body>
</html>