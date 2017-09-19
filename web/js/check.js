/**
 * Created by Programmer on 2016/12/14.
 * */


$(document).ready(function () {
	//转义html字符
	function encode(str) {
		if (str.indexOf("<")>=0)
			str = str.replaceAll("/g<", "k");
		return str;
	};

	//异步加载图片
	$("#tab1 div img").scrollLoading();
	$("#tab2 div img").scrollLoading();

	//登录注册逻辑验证
	$("#loginForm div div button").click(function () {
		var txtName = $("#loginForm div div input[name='txtName']").val();
		var txtPwd = $("#loginForm div div input[name='txtPwd']").val();

		var len = txtName.length;
		var txtName1;
		if (len > 7) {
			txtName1 = txtName.substring(0, 4);
		}

		if (txtName == "" || txtName == null){
			alert("用户名为空");
			return false;
		}
		else if (txtPwd == "" || txtPwd == null){
			alert("密码不能为空");
			return false;
		}
		else {
			$.ajaxSettings.statusCode={
				603: function () {
					alert("username or password error")
				}
			};
			$.ajax({
				url: "../src/login.jsp",
				type: "POST",
				data: $("#loginForm").serialize(),
				success: function () {
					//刷新当前页面
					location.reload();

					$("#mask").css({ display: 'none'});
					$("#login").fadeOut("fast");
					// $("#loginLi").hide();
					// $("#personLi").show();
					if (len > 7) {
						$("#personLi a").text(txtName1 + "...");
					}
					else {
						$("#personLi a").text(txtName);
					}
					alert("login successfully");
				}
			});

			return false;
		}
	});

	$("#registerForm div div button").click(function () {
		var txtName = $("#registerForm div div input[name='txtName']").val();
		var txtPwd = $("#registerForm div div input[name='txtPwd']").val();
		var txtPwd1 = $("#registerForm div div input[name='txtPwd1']").val();

		if (txtName == "" || txtName == null){
			alert("用户名为空");
			return false;
		}
		else if (txtPwd == "" || txtPwd == null){
			alert("密码不能为空");
			return false;
		}
		else if (txtPwd != txtPwd1){
			alert("两次输入的密码不一致");
			return false;
		}
		else {
			$.ajaxSettings.statusCode={
				601: function () {
					alert("user existed!");
				}
			};
			$.ajax({
				url: "../src/register.jsp",
				type: "POST",
				data: $("#registerForm").serialize(),
				success: function () {
					alert("register successfully! please login");
					$("#loginbtn1").addClass("li-style-1-1")
					$("#registerbtn1").removeClass("li-style-1-1")
					$("#login1").show();
					$("#register1").hide();
				}
			});
			return false;
		}
	});

//	公众号注册
	$("#registerForm1 div div button").click(function () {
		var txtName = $("#registerForm1 div div input[name='txtName']").val();
		var txtPwd = $("#registerForm1 div div input[name='txtPwd']").val();
		var OfficeName = $("#registerForm1 div div input[name='OfficeName']").val();

		if (txtName == "" || txtName == null){
			alert("用户名为空");
			return false;
		}
		else if (txtPwd == "" || txtPwd == null){
			alert("密码为空");
			return false;
		}
		else if (OfficeName == null || OfficeName == ""){
			alert("公众号名为空");
			return false;
		}
		else {
			$.ajaxSettings.statusCode={
				600: function () {
					alert("official account existed!");
				},
				601: function () {
					alert("user existed!");
				}
			};
			$.ajax({
				url: "../src/office_register.jsp",
				type: "POST",
				data: $("#registerForm1").serialize(),
				success: function () {
					alert("register successfully! please login");
					$("#loginbtn1").addClass("li-style-1-1")
					$("#registerbtn1").removeClass("li-style-1-1")
					$("#login1").show();
					$("#register1-1").hide();
				}
			});
			return false;
		}
	});

	//个人信息页面
	$("#ultwo li:first").click(function () {
			$("body").append("<div id='mask'></div>");
			$("#mask").addClass("mask").fadeIn("slow");
			$("#personMesgsDiv").fadeIn("slow");

	});

	//编辑个人信息
	$("#personShow div button").click(function () {
		$("#personShow").hide();
		$("#personForm").show();

		//遍历元素
		var ii=0;
		var str = new Array(5);

		$("#personShow div").each(function () {
			str[ii] = $(this).children("b").text();
			ii++;
		});

		ii=0;
		$("#person1 div").each(function () {
			$(this).children("input").val(str[ii]);
			ii++;
		});
	});

	//提交个人信息
	$("#personForm form div button").click(function () {
		$.ajax({
			url: "../src/refreshPerson.jsp",
			type: "POST",
			data: $("#personForm form").serialize(),
			success: function () {

				alert("refresh successfully! ");


				//遍历元素
				var ii=0;
				var str = new Array(5);
				$("#person1 div").each(function () {
					str[ii] = $(this).children("input").val();

					ii++;
				});

				ii=0;
				$("#personShow div").each(function () {
					$(this).children("b").text(str[ii]);
					ii++;
				});

				$("#personShow").show();
				$("#personForm").hide();
			}
		});
		return false;
	});

	//关闭个人信息页面
	$("#closebtn1").click(function () {
		$("#mask").css({ display: 'none'});
		$("#personMesgsDiv").fadeOut("fast");
		$("#personShow").show();
		$("#personForm").hide();
	});

	//注销
	$("#ultwo li:last").click(function () {
		$("#loginLi").show();
		$("#personLi").hide();
		$("#ultwo").hide();
	});


	//点击文章图片进入文章详情页面
	$("#tab1 div img").click(function () {
		var ID = $(this).attr("id");
		var url = $(this).attr("data-url");

		window.open("../src/article.jsp?ID="+ID+"&imgUrl="+url, "_blank");

		//更新文章阅读量
		$.ajax({
			url: "../src/refreshRead.jsp",
			type: "GET",
			data: "ID="+ID,
		});

		return false;
	});

	//点击公众号图片进入公众号文章页面
	$("#tab2 div img").click(function () {
		var ID = $(this).attr("id");


		window.open("../src/officeDetail.jsp?oname="+ID, "_blank");
		return false;
	});

	$("#article-public").click(function () {
		window.open("../utf8-jsp/demo.jsp", "_blank");

		return false;
	});

	$("#article-public-1").click(function () {

		alert("您还不是公众号用户，请注册成为公众号用户");

		return false;
	});

});


// <%--tab事件--%>
$(document).ready(function () {
	$("#div2 ul li").hover(function () {
		$(this).addClass("li-bgcOne");
		$(this).ch
	},function () {
		$(this).removeClass("li-bgcOne");
	});
});

// <%--订阅事件--%>
$(document).ready(function () {
	$("#status-li").click(function () {

		$.ajaxSettings.statusCode={
			603: function () {
				alert("please login first!");
			}
		};

		var status = $("#status-li a").text();
		var oname = $("#oname-aa").text();
		var status1;
		if (status == "订阅"){
			status1="1";
		}
		else {
			status1="0";
		}

		$.ajax({
			url: "../src/refreshStatus.jsp",
			type: "GET",
			data: "status="+status1+"&oname="+oname,
			success: function () {
				if (status == "订阅"){
					$("#status-li a").text("取消订阅");
				}
				else {
					$("#status-li a").text("订阅");
				}
			}
		});

		return false;
	});
});


// <%--header 导航菜单事件--%>
$(document).ready(function () {
	$("#ulone li").hover(function () {
		$(this).addClass("li-bgc");
	},function () {
		$(this).removeClass("li-bgc");
	});

	$("#personLi").hover(function () {
		$("#ultwo li").addClass("li-bgc");
		$("#ultwo").slideDown("show");
	},function () {
		$("#ultwo li").removeClass("li-bgc");
	});

	$("#ultwo li").hover(function () {
		$(this).addClass("li-bgc");
	},function () {
		$(this).removeClass("li-bgc");
	});
	$("#ultwo").mouseleave(function () {
		$("#ultwo").slideUp("show");
	});
});

$(document).ready(function () {
	$("#divBt button").hover(function () {
		$(this).addClass("bt-bgc");
	},function () {
		$(this).removeClass('bt-bgc');
	});
});

// <%-- 文章，公众号显示 --%>
$(document).ready(function () {
	$("#div2 ul li:first").click(function () {
		$("#tab1").show();
		$("#tab2").hide();
	});
	$("#div2 ul li:last").click(function () {
		$("#tab2").show();
		$("#tab1").hide();
	})
});

// <%-- 登录注册 --%>
$(document).ready(function () {
	$("#loginbtn").click(function () {
		$("body").append("<div id='mask'></div>");
		$("#mask").addClass("mask").fadeIn("slow");
		$("#login").fadeIn("slow");

	});

	// <%-- 登录，注册显示 --%>
	$(document).ready(function () {
		$("#loginbtn1").click(function () {
			$(this).addClass("li-style-1-1")
			$("#registerbtn1").removeClass("li-style-1-1")
			$("#login1").show();
			$("#register1").hide();
			$("#register1-1").hide();
		});
		$("#registerbtn1").click(function () {
			$(this).addClass("li-style-1-1")
			$("#loginbtn1").removeClass("li-style-1-1")
			$("#register1").show();
			$("#login1").hide();
			$("#register1-1").hide();
		})
		$("#officeBtn").click(function () {
			$("#register1-1").show();
			$("#login1").hide();
			$("#register1").hide();
		})
	});

	//关闭
	$("#closebtn").click(function () {
		$("#mask").css({ display: 'none'});
		$("#login").fadeOut("fast");
	});

});