<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%> 
<%@ page import="java.text.*"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>供应商列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
		http://localhost:3306/crud
 -->
<script type="text/javascript"
	src="${APP_PATH }/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<style> 
body{text-align:center} 
.divcss5{margin:0 auto;} 
</style>
<body>
<div class="divcss5">
<p>请输入你的订单号，通过订货单号查询</p><br>
<form class="navbar-form navbar-center" role="search" action="${APP_PATH}/subscriber/OneDetaillist" method="post">
  <div class="form-group">
    <input type="text" name="search" class="form-control" placeholder="请输入单号(订单)">
  </div>
  <button type="submit" class="btn btn-default">查询</button>
</form>
	
</div>    
</body>
</html>