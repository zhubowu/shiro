<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="/common.jsp" %>
<script type="text/javascript">
	$(function(){
		$("#permissionTable").treegrid({
			toolbar:"#tb",
			idField:"id",
			treeField:"text",
			animate:true,
			onLoadSuccess : function(){
				//$(this).treegrid("collapseAll");
			},
			loadFilter : function(data){
				$.each(data,function(){
					this.state = "open";
				});
				return data;
			}
		});
	});
	
	function add_permission(){
		
		//创建一个元素加到页面
		var d=$("<div></div>").appendTo("body");
		d.dialog({
			title:"添加权限",
			width:300,
			height:400,
			modal:true,
			href:"permission/toAdd",
			buttons:[
				{
					iconCls:"icon-ok",
					text:"确定",
					handler:function(){  
						$.post("permission/add",$("#permissionForm").serialize(),function(data){
							 
							if(data.result){
								d.dialog("close");
								$("#permissionTable").treegrid("reload");
							}	    
						}); 
					}
				},{
					iconCls:"icon-cancel",
					text:"取消",
					handler:function(){
						d.dialog("close");
					} 
				},
			],
		});
	};
	function edit_permission(){
		var row= $("#permissionTable").treegrid("getSelected");
		 
		if(row==null){
			$.messager.alert("提示！","请选择行数据","info");
			return;
		}
		var type=row.children;
		/* if(type!=null){
			console.log("menu");
		}else {
			console.log("permission");
		} 
		console.log(row.id); */
		
		//创建一个元素加到页面
		var d=$("<div></div>").appendTo("body");
		d.dialog({
			title:"编辑权限",
			width:300,
			height:400,
			modal:true,
			href:"permission/toAdd?id="+row.id,
			buttons:[
				{
					iconCls:"icon-ok",
					text:"确定",
					handler:function(){  
						$.post("permission/update",$("#permissionForm").serialize(),function(data){
							 
							if(data.result){
								d.dialog("close");
								$("#permissionTable").treegrid("reload");
							}	    
						}); 
					}
				},{
					iconCls:"icon-cancel",
					text:"取消",
					handler:function(){
						d.dialog("close");
					} 
				},
			],
		});
		
		
		
	};
	function delete_permission(){			 
		var row= $("#permissionTable").treegrid("getSelected");
		var rowId=row.id;
		
		var isok=confirm("是否删除选中行！！！");
		if(isok){
			$.post("permission/delete",{id:rowId},function(data){
				if(data.result){
					$("#permissionTable").treegrid("reload");
				}
			});
		}
	};
	
</script>
</head>
<body>

<table id="permissionTable"  title="Permission List"
        data-options="url:'permission/list',fitColumns:true,striped:true,iconCls:'icon-search'">
    <thead>
        <tr>
            <th data-options="field:'id',width:100,sortable:true">ID</th>
            <th data-options="field:'text',width:100,sortable:true">Text</th>
            <th data-options="field:'available',width:100,sortable:true">Available</th>
            <th data-options="field:'url',width:50">Url</th>
        </tr>
    </thead>
</table>
<div id="tb">
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="add_permission();" data-options="iconCls:'icon-add',plain:true">添加</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit_permission();" data-options="iconCls:'icon-edit',plain:true">修改</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="delete_permission();" data-options="iconCls:'icon-remove',plain:true">删除</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">导出</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-sum',plain:true">批量导入</a>
</div>
</body>
</html>




