<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
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
<body>
<%
java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");  
java.util.Date currentTime = new java.util.Date();  
String time = simpleDateFormat.format(currentTime).toString();   //放到页面的head中
%>
<!-- 进货修改的模态框 -->
<div class="modal fade" id="returnOrderUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">退货单修改</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
         <div class="form-group">
		    <label class="col-sm-2 control-label">仓库</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		      <select id="select_storeHouse" class="form-control" name="shId">
		      </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">供应商</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		      <select id="select_supplier" class="form-control" name="supId">
		      </select>
		    </div>
		  </div>
		   <div class="form-group">
		    <label class="col-sm-2 control-label">退货日期</label>
		    <div class="col-sm-10">
		      <input type="text" name="roDate" class="form-control" id="roDate_update_input" readonly="readonly">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">应退</label>
		    <div class="col-sm-10">
		      	 <input type="text" name="roPayable" class="form-control" id="roPayable_update_input" >
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">实退</label>
		    <div class="col-sm-10">
		      <input type="text" name="roPaid" class="form-control" id="roPaid_update_input" >
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">明细单号</label>
		    <div class="col-sm-10">
		      <input type="text" name="roOriginal" class="form-control" id="roOriginal_update_input" readonly="readonly">
		      <span class="help-block"></span>
		    </div>
		  </div>
		   <div class="form-group">
		    <label class="col-sm-2 control-label">备注</label>
		    <div class="col-sm-10">
		      <input type="text" name="roRemark" class="form-control" id="roRemark_update_input" >
		      <span class="help-block"></span>
		    </div>
		  </div>
		 
		  <div class="form-group">
		    <label class="col-sm-2 control-label">经办人</label>
		    <div class="col-sm-10">
		      <input type="text" name="roAttn" class="form-control" id="roAttn_update_input" >
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">操作员</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		      <select id="select_user" class="form-control" name="roOperator">
		      </select>
		    </div>
		  </div>
		 
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="returnOrder_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>



<!-- 商品添加的模态框 -->
<div class="modal fade" id="returnOrderAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">退货单添加</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
        <div class="form-group">
		    <label class="col-sm-2 control-label">仓库</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		      <select id="select_storeHouse" class="form-control" name="shId">
		      </select>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label class="col-sm-2 control-label">供货商</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		      <select id="select_supplier" class="form-control" name="supId">
		      </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">退货日期</label>
		    <div class="col-sm-10">
		      <input type="text" name="roDate" class="form-control" id="roDate_add_input" value="<%=time%>" readonly="readonly" placeholder="<%=time%>">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">应退</label>
		    <div class="col-sm-10">
		    <input type="text" name="roPayable" class="form-control" id="roPayable_add_input" placeholder="请输入应付">
		      <span class="help-block"></span>
		    </div>
		  </div>
		   <div class="form-group">
		    <label class="col-sm-2 control-label">实退</label>
		    <div class="col-sm-10">
		    <input type="text" name="roPaid" class="form-control" id="roPaid_add_input" placeholder="请输入实付">
		      <span class="help-block"></span>
		    </div>
		  </div> 
		  
		   <div class="form-group">
		    <label class="col-sm-2 control-label">备注</label>
		    <div class="col-sm-10">
		    <input type="text" name="roRemark" class="form-control" id="roRemark_add_input" placeholder="请输入备注">
		      <span class="help-block"></span>
		    </div>
		  </div>
		   <div class="form-group">
		    <label class="col-sm-2 control-label">经办人</label>
		    <div class="col-sm-10">
		    <input type="text" name="roAttn" class="form-control" id="roAttn_add_input" placeholder="请输入经办人">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">操作员</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		      <select id="select_user" class="form-control" name="roOperator">
		      </select>
		    </div>
		  </div>
		 
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="returnOrder_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>


	<!-- 搭建显示页面 -->
	<div class="container">
	<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
			<shiro:hasAnyRoles name="admin,manager,user">
				<button class="btn btn-primary" id="returnOrder_add_modal_btn">新增</button>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="admin">
				<button class="btn btn-danger" id="returnOrder_delete_all_btn">删除</button>
			</shiro:hasAnyRoles>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="ros_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>单号</th>
							<th>仓库</th>
							<th>供应商</th>
						    <th>收货日期</th>
							<th>应付</th>
							<th>实付</th>
							<th>明细单号</th>
							<th>备注</th>
							<th>经办人</th>
							<th>操作员</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!--分页文字信息  -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
		
	</div>
	<script type="text/javascript">
	
		var totalRecord,currentPage;
		//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
		$(function(){
			//去首页
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/returnOrder/ros",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					
					//console.log(result);
					//1、解析并显示员工数据
					build_ros_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条数据
					build_page_nav(result);
				}
			});
		}
		
		function build_ros_table(result){
			//清空table表格
			$("#ros_table tbody").empty();
			var ros = result.extend.pageInfo.list;
			$.each(ros,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var roIdTd = $("<td></td>").append(item.roId);
				var shNameTd = $("<td></td>").append(item.storeHouse.shName);
				var supNameTd = $("<td></td>").append(item.supplier.supName);
				var roDateTd = $("<td></td>").append(item.roDate);
				var roPayableTd = $("<td></td>").append(item.roPayable);
				var roPaidTd = $("<td></td>").append(item.roPaid);
				var roOriginalTd = $("<td></td>").append(item.roOriginal);
				var roRemarkTd = $("<td></td>").append(item.roRemark);
				var roAttnTd = $("<td></td>").append(item.roAttn);
				var truenameTd = $("<td></td>").append(item.user.truename);
				var editBtn = $("<shiro:hasAnyRoles name="admin,manager"><button></button></shiro:hasAnyRoles>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个自定义的属性，来表示当前员工id
				editBtn.attr("edit-id",item.roId);
				var delBtn =  $("<shiro:hasAnyRoles name="admin"><button></button></shiro:hasAnyRoles>").addClass("btn btn-danger btn-sm delete_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加一个自定义的属性来表示当前删除的员工id
				delBtn.attr("del-id",item.roId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				//var delBtn = 
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd)
					.append(roIdTd)
					.append(shNameTd)
					.append(supNameTd)
					.append(roDateTd)
					.append(roPayableTd)
					.append(roPaidTd)
					.append(roOriginalTd)
					.append(roRemarkTd)
					.append(roAttnTd)
					.append(truenameTd)
					.append(btnTd)
					.appendTo("#ros_table tbody");
			});
		}
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
					result.extend.pageInfo.pages+"页,总"+
					result.extend.pageInfo.total+"条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//解析显示分页条，点击分页要能去下一页....
		function build_page_nav(result){
			//page_nav_area
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			//构建元素
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页的事件
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum -1);
				});
			}
			
			
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum +1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			
			
			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi);
			//1,2，3遍历给ul中添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);
			
			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮弹出模态框。
		$("#returnOrder_add_modal_btn").click(function(){
			//清除表单数据（表单完整重置（表单的数据，表单的样式））
			reset_form("#returnOrderAddModal form");
			//s$("")[0].reset();
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getSups("#returnOrderAddModal #select_supplier");
			
			getShs("#returnOrderAddModal #select_storeHouse");
			
			getUsers("#returnOrderAddModal #select_user");
			//弹出模态框
			$("#returnOrderAddModal").modal({
				backdrop:"static"
			});
		});
		
		//查出所有的部门信息并显示在下拉列表中
		function getSups(ele){
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/goods/suppliers",
				type:"GET",
				success:function(result){
					
					//显示部门信息在下拉列表中
					//$("#empAddModal select").append("id='building'")
					$.each(result.extend.suppliers,function(){
						var optionEle = $("<option></option>").append(this.supName).attr("value",this.supId);
						optionEle.appendTo(ele);
					});
				}
			});
			
		}
		function getShs(ele){
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/goods/storeHouses",
				type:"GET",
				success:function(result){
					
					//显示部门信息在下拉列表中
					//$("#empAddModal select").append("")
					$.each(result.extend.storeHouses,function(){
						var optionEle = $("<option></option>").append(this.shName).attr("value",this.shId);
						optionEle.appendTo(ele);
					});
				}
			});
			
		}
		function getUsers(ele){
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/user/users",
				type:"GET",
				success:function(result){
					
					//显示部门信息在下拉列表中
					//$("#empAddModal select").append("id='building'")
					$.each(result.extend.users,function(){
						var optionEle = $("<option></option>").append(this.truename).attr("value",this.id);
						optionEle.appendTo(ele);
					});
				}
			});
			
		}
		//校验表单数据
		function validate_add_form(){
			//1、拿到要校验的数据，使用正则表达式
			var roPayable = $("#roPayable_add_input").val();
			var regroPayable = /^[0-9]*$/;
			if(!regroPayable.test(roPayable)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#roPayable_add_input", "error", "请输入数字");
				return false;
			}else{
				show_validate_msg("#roPayable_add_input", "success", "");
			};
			
			var roPaid = $("#roPaid_add_input").val();
			var regroPaid = /^[0-9]*$/;
			if(!regroPaid.test(roPaid)){
				show_validate_msg("#roPaid_add_input", "error", "请输入数字");
				return false;
			}else{
				show_validate_msg("#roPaid_add_input", "success", "");
			};
			
			
			return true;
		}
		
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		
		
		//点击保存，保存员工。
		$("#returnOrder_save_btn").click(function(){
			//1、模态框中填写的表单数据提交给服务器进行保存
			//1、先对要提交给服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			};
			
			//2、发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH}/returnOrder/insert",
				type:"POST",
				data:$("#returnOrderAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					if(result.code == 100){
						//员工保存成功；
						//1、关闭模态框
						$("#returnOrderAddModal").modal('hide');
					
						var RoId = result.extend.RoId;
						alert("退货单号"+RoId+"正在进行处理，请根据退货单号或退货明细单号查询并填写 明细单，否则退货单将无效");
						to_page(currentPage);
					}else{
						//显示失败信息
						//console.log(result);
						//有哪个字段的错误信息就显示哪个字段的；
						
						if(undefined != result.extend.errorFields.roPayable){
							//显示手机号的错误信息
							show_validate_msg("#roPayable_add_input", "error", result.extend.errorFields.roPayable);
						}
						if(undefined != result.extend.errorFields.roPaid){
							//显示手机号的错误信息
							show_validate_msg("#roPaid_add_input", "error", result.extend.errorFields.roPaid);
						}
					}
				}
			});
		});
		
		//1、我们是按钮创建之前就绑定了click，所以绑定不上。
		//1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
		//jquery新版没有live，使用on进行替代
		$(document).on("click",".edit_btn",function(){
			//alert("edit");
			
			
			//1、查出部门信息，并显示部门列表
			getSups("#returnOrderUpdateModal #select_supplier");
			
			getShs("#returnOrderUpdateModal #select_storeHouse");
			
			getUsers("#returnOrderUpdateModal #select_user");
			//2、查出员工信息，显示员工信息
			getReturnOrder($(this).attr("edit-id"));
			
			
			
			//3、把员工的id传递给模态框的更新按钮
			$("#returnOrder_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#returnOrderUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		function getReturnOrder(id){
			$.ajax({
				url:"${APP_PATH}/returnOrder/select/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var returnOrderData = result.extend.returnOrder;
					$("#returnOrderUpdateModal #select_storeHouse").val([returnOrderData.shId]);
					$("#returnOrderUpdateModal #select_supplier").val([returnOrderData.supId]);
					$("#roDate_update_input").val(returnOrderData.roDate);
					$("#roPayable_update_input").val(returnOrderData.roPayable);
					$("#roPaid_update_input").val(returnOrderData.roPaid);
					$("#roArrears_update_input").val(returnOrderData.roArrears);
					$("#roOriginal_update_input").val(returnOrderData.roOriginal);
					$("#roRemark_update_input").val(returnOrderData.roRemark);
					$("#roAttn_update_input").val(returnOrderData.roAttn);
					$("#returnOrderUpdateModal #select_user").val([returnOrderData.roOperator]);
				}
			});
		}
		
		//点击更新，更新员工信息
		$("#returnOrder_update_btn").click(function(){
			
			//2、发送ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/returnOrder/update/"+$(this).attr("edit-id"),
				type:"POST",
				data:$("#returnOrderUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//1、关闭对话框
					$("#returnOrderUpdateModal").modal("hide");
					//2、回到本页面
					to_page(currentPage);
				}
			});
		});
		
		//单个删除
		$(document).on("click",".delete_btn",function(){
			//1、弹出是否确认删除对话框
			var roId = $(this).attr("del-id");
			//alert($(this).parents("tr").find("td:eq(1)").text());
			if(confirm("确认删除【"+roId+"】吗？")){
				//确认，发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/returnOrder/delete/"+roId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			}
		});
		
		//完成全选/全不选功能
		$("#check_all").click(function(){
			//attr获取checked是undefined;
			//我们这些dom原生的属性；attr获取自定义属性的值；
			//prop修改和读取dom原生属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//check_item
		$(document).on("click",".check_item",function(){
			//判断当前选择中的元素是否5个
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，就批量删除
		$("#returnOrder_delete_all_btn").click(function(){
			//
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				//组装员工id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除删除的id多余的-
			del_idstr = del_idstr.substring(0, del_idstr.length-1);
			if(confirm("确认删除【"+del_idstr+"】吗？")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/returnOrder/delete/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>