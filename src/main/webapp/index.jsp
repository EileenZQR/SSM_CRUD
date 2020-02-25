<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.11.3.min.js"></script>
<link rel="stylesheet"
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script type="text/javascript"
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题行 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>

		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>

		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>	</tbody>
				</table>
			</div>
		</div>

		<!-- 分页信息 -->
		<div class="row">
			<!-- 文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>

			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	
	
	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<!-- 员工添加的表单 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="empName_add_input" name="empName"
									placeholder="empName">
								 <span id="" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_add_input" name="email"
									placeholder="Jerry.com">
								<span id="" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender_add_input" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M" checked="checked">
									男
								</label> 
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F">
									女
								</label>
							</div>
						</div>
						<!-- 部门信息从数据库中查詢出来再构建,提交部门id -->
						<div class="form-group">
							<label for="dept_add_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<!-- 编辑员工的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<!-- 员工修改的表单 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_update_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="email_update_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_update_input" name="email"
									placeholder="email">
								<span id="" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender_update_input" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M" checked="checked">
									男
								</label> 
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F">
									女
								</label>
							</div>
						</div>
						<!-- 部门信息从数据库中查詢出来再构建,提交部门id -->
						<div class="form-group">
							<label for="dept_update_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update_select"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<script type="text/javascript">
		//全局变量，总记录数
		var totalRecord;
		//全局变量,当前页面
		var currentPage;
	
		//页面加载完成后直接发送Ajax请求拿到分页数据
		$(function() {
			//页面加载时定位到首页
			to_page(1);
		});	
		
		
		//跳转到指定页面的ajax请求
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//解析并显示员工数据
					build_emps_table(result);
					//解析并显示分页信息
					build_page_info(result);
					//解析并显示分页条信息
					build_page_nav(result);
				}
			});
		};		
		
		
		//解析员工信息
		function build_emps_table(result) {
			//构建之前先清空
			$("#emps_table tbody").empty();
			//构建
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var gender = item.gender=="M"?"男":"女";
				var genderTd = $("<td></td>").append(gender);
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//给员工编辑按钮添加一个自定义的属性来表示当前员工的id
				editBtn.attr("edit_id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//给删除按钮添加一个自定义的属性来表示当前删除的员工的id
				delBtn.attr("delete_id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(checkBoxTd)
							.append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd)
							.append(btnTd).appendTo("#emps_table tbody");
			});
		};
		
		
		//解析显示分页信息
		function build_page_info(result) {
			//清空
			$("#page_info_area").empty();
			//构建
			$("#page_info_area").append("当前第 "+result.extend.pageInfo.pageNum+" 页,总共 "+result.extend.pageInfo.pages+" 页,共有 "+result.extend.pageInfo.total+" 条记录");
			//修改全局变量总记录数的值
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		};
		
		
		//解析显示分页条,点击链接发送ajax请求
		function build_page_nav(result) {
			//清空
			$("#page_nav_area").empty();
			//构建
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//添加点击事件
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1)
				});
			}
			//构建
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				//添加点击事件
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages)
				});
			}		
			//添加首页和前一页
			ul.append(firstPageLi).append(prePageLi);
			//遍历给ul中添加页码
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				if(result.extend.pageInfo.pageNum==item){
					numLi.addClass("active")
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			//把ul加入到nav元素中
			var nav = $("<nav></nav>").append(ul);
			nav.appendTo("#page_nav_area");
		};
		
		
		//新增按钮的点击事件，弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//清除表单信息(表单重置)
			reset_form("#empAddModal form");
			//发送ajax请求查出部门信息，显示再下拉列表中
			getDepts("#dept_add_select");
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		
		//表单重置方法
		function reset_form(ele){
			//调用DOM对象的reset方法，清空表单内容
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		};
		
		
		//查詢部门信息的方法,发送ajax请求,并显示在指定的表单中
		function getDepts(ele) {
			//清空之前下拉列表的值
			$(ele).empty();
			//发送ajax请求获取部门信息并显示
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//将部门信息显示在模态框的下拉列表中
					$.each(result.extend.depts,function(){
						var optionEl = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEl.appendTo(ele);
					});
				}
			});
		};
		
		
		//保存员工的点击事件
		$("#emp_save_btn").click(function(){
			//对要提交给服务器的数据进行校验,前端校验
			if(!validate_add_form()){
				//校验失败
				return false;
			};
			//用户名校验是否成功，成功才进行保存
			if($(this).attr("ajax-va")=="error"){
				//用户名重复
				return false;
			}
			//模态框中的数据提交给服务器,发送ajax请求(利用jQuery的serialize方法来序列化表单数据)
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//判断是否保存成功
					if(result.code==100){
						//弹出保存成功的提示框
						alert("保存成功！");
						//关闭模态框
						$("#empAddModal").modal('hide');
						//来到列表的最后一页显示刚保存的数据(发送ajax请求显示最后一页(足够大的页码即可)数据)
						to_page(totalRecord);
					}else{
						//保存失败，显示失败信息，有哪个字段的错误信息就显示哪个字段
						if(undefined != result.extend.errorFields.email){
							//邮箱错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							//员工名错误信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}					
					};
				}
			});
			
		});
		
		
		//表单数据的校验方法
		function validate_add_form(){
			//拿到要校验的数据，使用正则表达式
			//校验用户名
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名必须为2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_add_input","error","用户名必须为2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			};
			//校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
			};
			return true;
		};
		
		
		//校验结果信息的显示
		function show_validate_msg(ele,status,msg){
			//先清楚元素原来的的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			//校验信息显示
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			};
		}
		
		
		//员工姓名输入框的change事件,验证用户名是否重复
		$("#empName_add_input").change(function(){
			var empName = this.value;
			//发送ajax请求
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						//给保存按钮添加属性
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		
		//编辑按钮的单击事件(由于按钮创建之前绑定点击事件,所以使用.click()绑定不上)
		//解决:1.创建按钮时的绑定事件 2.使用 .live()方法(旧版本jQuery) 或者 on (新的jQuery)
		$(document).on("click",".edit_btn",function(){
			//查出部门信息并显示部门列表
			getDepts("#empUpdateModal select");
			//查出员工信息并显示
			getEmp($(this).attr("edit_id"));
			//把员工id传递给更新按钮
			$("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
			//弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			});	
		});

		
		//查詢员工信息的方法
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					var empData = result.extend.emp;
					//将查询到的员工数据显示到模态框中
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		//编辑模态框中更新按钮的点击事件
		$("#emp_update_btn").click(function(){
			//验证邮箱是否合法
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input","success","");
			};
			//发送ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//关闭模态框
					$("#empUpdateModal").modal("hide");
					//回到本页面
					to_page(currentPage);
				}
			});
		});
		
		
		//单个删除按钮的点击事件
		$(document).on("click",".delete_btn",function(){
			//获得要删除的员工的名字
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("delete_id");
			//弹出确认删除对话框
			if(confirm("确认删除[ "+empName+" ]吗?")){
				//确认删除,发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			};
		});
		
		
		//全选全不选的点击事件(使用prop修改和读取dom原生属性的值)
		$("#check_all").click(function(){
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//单个选择框的点击事件
		$(document).on("click",".check_item",function(){
			//判断当前选中的元素的个数是不是等于所有的item的总数
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//全部删除按钮的点击事件
		$("#emp_delete_all_btn").click(function(){
			var empNames = " ";
			//组装员工id字符串
			var del_ids_str = "";
			//遍历每个被选中的项	
			$.each($(".check_item:checked"),function(){
				empNames = empNames + $(this).parents("tr").find("td:eq(2)").text() + "  ";
				del_ids_str += $(this).parents("tr").find("td:eq(1)").text() +"-";
			});
			//去掉末尾的 -
			del_ids_str = del_ids_str.substring(0,del_ids_str.length-1);
			//确认删除对话框
			if(confirm("确认删除[ "+empNames+" ]吗?")){
				//发送ajax请求删除员工
				$.ajax({
					url:"${APP_PATH}/emp/"+del_ids_str,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage);
					}
				});
			};
		});
	</script>
</body>
</html>