<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>??</title>        
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">    
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
 </head>
 <body>
 	<script type="text/javascript">
 		$(function(){
 			/* 选择权限类型 */
 			$("#type").change(function(){
 				 if($(this).val()=="menu"){
 					 //当自己是父节点时  url,parentid,percode都为空
 					  $("#parentids").val("0/1/");
 					  $("#parentid").val("").attr("disabled",true);
 					  $("#url").val("").attr("disabled",true);
 					  $("#percode").val("").attr("disabled",true);
 					 $("#parent").combobox({"disabled":true,});
 				 }else if($(this).val()=="permission"){
 					$("#parentid").removeAttr("disabled");
 					$("#url").removeAttr("disabled");
					$("#percode").removeAttr("disabled");
					$("#parent").removeAttr("disabled");
					$("#parent").combobox({"disabled":false,});
 				 }
 			});
 			 
 		});
 		
 		$("#parent").combobox({
 			url:"permission/getonetype",
 			valueField:"id",
 			textField:"text", 
 			onChange:function(){ 
 				 $("#parentid").val($(this).val());
 			}
 		});
 		
 		
 	</script>
 	<h1>${id }</h1>
 	<form action="" id="permissionForm" method="post"> 
 		<p>name:<input type="text" name="text"/></p>
 		<p>type:	
 			<select id="type" name="type">
 				<option value="-1">请选择</option>
 				<option value="menu">menu</option>
 				<option value="permission">permission</option>
 			</select>
 		</p>
 		<p>url:<input type="text" name="url" id="url"/></p>
 		<p>权限代码号:<input type="text" name="percode" id="percode"/></p>
 		<p>父节点:<input type="text" id="parentid" name="parentId" /></p>
 		<!-- <p>节点id列表串:<input type="text" id="parentids" name="parentids"/></p> -->
 		<input id="parent" value="请选择"></input>
 		<p>排序号:<input type="text" id="sortstring" name="sortstring"/></p> 
 		<p>是否可用:<input name="available" value="1" class="easyui-switchbutton" data-options="onText:'Yes',offTest:'No'" /></p>
 		
 	</form>
 </body>
</html>