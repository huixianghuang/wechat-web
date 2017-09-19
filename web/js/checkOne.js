/**
 * Created by Programmer on 2016/12/23.
 */
$(document).ready(function () {

	//点赞
	var temp=0;
	$("#likeBtn").click(function () {

		var s2 = $("#posts div div:first").attr("id");

		if (temp==0) {
			var a = $("#likeNum").text();
			++a;
			$("#likeNum").text(a);
			temp=1;
		}
		else {
			var a = $("#likeNum").text();
			--a;
			$("#likeNum").text(a);
			temp=0;
		}

		$.ajax({
			url: "../src/refreshLike.jsp",
			type: "GET",
			data: "likeNum="+$("#likeNum").text()+"&ID="+s2,

		});
		return false;

	});

	//提交评论
	$("#submit-btn").click(function () {
		$.ajaxSettings.statusCode={
			603: function () {
				alert("please login first!");
			}
		};

		var s1 = $(".form-style").serialize().toString();
		if (s1=="comment=" || s1==null){
			alert("留言为空");
			return false;
		}
		var s2 = $("#posts div div:first").attr("id");

		$.ajax({
			url: "../src/submitComment.jsp",
			type: "POST",
			data: s1+"&ID="+s2,
			success: function () {
				alert("submit successfully! please waitting for checking1");
			}
		});
		return false;
	});

	//点击公众号名称，跳转公众号详情页面
	$("#blogDesc").click(function () {
		var ID = $("#blogDesc1").text();

		window.open("../src/officeDetail.jsp?oname="+ID, "_blank");
		return false;
	});



});