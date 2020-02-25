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
<!-- 引入bootstrap的样式和js文件 -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.11.3.min.js"></script>
<link rel="stylesheet"
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script type="text/javascript"
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<!-- index1.jsp发送/emps请求，经处理后跳转到该页面展示员工信息 -->
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
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>

		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender=="M"?"男":"女" }</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
							<td>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>

		<!-- 分页信息 -->
		<div class="row">
			<!-- 文字信息 -->
			<div class="col-md-6">当前第 ${pageInfo.pageNum } 页,总共
				${pageInfo.pages } 页,共有 ${pageInfo.total } 条记录</div>

			<!-- 分页条信息 -->
			<div class="col-md-6">
				<ul class="pagination">
					<!-- 首页按钮 -->
					<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
					<!-- 是否显示上一页按钮 -->
					<c:if test="${pageInfo.hasPreviousPage }">
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
					</c:if>
					<!-- 显示页码按钮 -->
					<c:forEach items="${pageInfo.navigatepageNums }" var="pn">
						<c:if test="${pn==pageInfo.pageNum }">
							<li class="active"><a href="#">${pn }</a></li>
						</c:if>
						<c:if test="${pn!=pageInfo.pageNum }">
							<li><a href="${APP_PATH }/emps?pn=${pn}">${pn }</a></li>
						</c:if>
					</c:forEach>
					<!-- 是否显示下一页按钮 -->
					<c:if test="${pageInfo.hasNextPage }">
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1}" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span></a></li>
					</c:if>
					<!-- 末页按钮 -->
					<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>