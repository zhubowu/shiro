package org.aptech.shiro.permission.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.aptech.shiro.permission.dao.SysPermissionDao;
import org.aptech.shiro.permission.pojo.SysPermission;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/permission")
public class SysPermissionController {
	@Resource
	private SysPermissionDao sysPermissionDao;

	public void setSysPermissionDao(SysPermissionDao sysPermissionDao) {
		this.sysPermissionDao = sysPermissionDao;
	}
	
	@RequestMapping("/index")
	public String index() throws Exception {
		return "syspermission/index";
	}
	@RequestMapping("/list")
	@ResponseBody
	public List<SysPermission> list() throws Exception {
		return sysPermissionDao.getAll();
	}
	/*
	 * 去添加权限界面
	 */
	@RequestMapping(value="/toAdd",method=RequestMethod.GET)
	public String toAdd(Integer id,Model model) {
		model.addAttribute("id", id);
		return "syspermission/add";
	};
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(SysPermission sysPermission){
		Map<String, Object> map=new HashMap<>();
		if (sysPermission.getParentId()!=null) {
			sysPermission.setParentIds("0/1"+sysPermission.getParentId());
		}
		sysPermission.setParentIds("0/1");
		sysPermissionDao.add(sysPermission);
		map.put("result", true);
		return map;
	}
	
	
	@RequestMapping("/getonetype")
	@ResponseBody
	public List<SysPermission> OneType(){
		List<SysPermission> list=sysPermissionDao.getOneType();
		return list;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(Integer id){
		Map<String, Object> map = new HashMap<>();
		Integer[] ids = {id};
		sysPermissionDao.deleteByIds(ids);
		map.put("result", true);
		return map;
	}
	
	
	
}






