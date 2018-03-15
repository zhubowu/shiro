<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>后台管理的主界面</title>        
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">    
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <%@ include file="/common.jsp" %> 
  <link rel="stylesheet" href="css/wu.css" type="text/css"/>
 </head>
 
 <body class="easyui-layout">
   <!-- begin of header -->
	<div class="wu-header" data-options="region:'north',border:false,split:true">
    	<div class="wu-header-left">
        	<h1>EasyUI Web Admin</h1>
        </div>
        <div class="wu-header-right">
        	<p><strong class="easyui-tooltip" title="2条未读消息">${sessionScope.login_user.username }</strong>，
        	<%-- <c:forEach items="${sessionScope.login_user.sysRoles }" var="role">${role.name } </c:forEach> --%>
        	
        	欢迎您！</p>
            <p><a href="#">网站首页</a>|<a href="#">支持论坛</a>|<a href="#">帮助中心</a>|<a href="user/logout" onclick="return confirm('确定要对出系统吗?');">安全退出</a></p>
        </div>
    </div>
    
    
    
    
    <div data-options="region:'south',title:'South Title',split:true" style="height:100px;"></div>
    
    
    <!--  <div data-options="region:'east',title:'East',split:true" style="width:100px;"></div> -->
   
   <!--  <div data-options="region:'west',title:'West',split:true" style="width:100px;"></div>
    --> 
    <div class="wu-sidebar" data-options="region:'west',split:true,border:true,title:'导航菜单'"> 
    		<div class="easyui-accordion" data-options="border:false,fit:true"> 
       		<%-- <c:forEach items="${sessionScope.permissions }" var="parent">
       			<c:if test="${parent.parentId == null }">
		       		<div title="${parent.text }">
		       			<ul class="easyui-tree wu-side-tree">
		       			<c:forEach items="${sessionScope.permissions }" var="child">
		       				<c:if test="${child.parentId != null && child.parentId == parent.id}">
		       				<li iconCls="icon-tip"><a href="javascript:void(0)" data-icon="icon-tip" data-link="${child.url }" iframe="1">${child.text }</a></li>
		       				</c:if>
		       			</c:forEach>
		       			</ul>
		       		</div>
	       		</c:if>
       		</c:forEach> --%>
        </div>
    </div>	
    
    
    <div data-options="region:'center',title:'center title'" style="padding:5px;background:#eee;"></div>
 
 </body>
</html>