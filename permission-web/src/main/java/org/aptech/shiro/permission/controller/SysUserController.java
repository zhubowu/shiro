package org.aptech.shiro.permission.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.jms.Session;
import javax.servlet.http.HttpSession;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.aptech.shiro.permission.dao.SysPermissionDao;
import org.aptech.shiro.permission.dao.SysUserDao;
import org.aptech.shiro.permission.pojo.SysPermission;
import org.aptech.shiro.permission.pojo.SysUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user")
public class SysUserController {
	@Resource
	private SysUserDao sysUserDao;

	public void setSysUserDao(SysUserDao sysUserDao) {
		this.sysUserDao = sysUserDao;
	}
	
	@Resource
	private SysPermissionDao sysPermissionDao;
	
	 
	 
	public void setSysPermissionDao(SysPermissionDao sysPermissionDao) {
		this.sysPermissionDao = sysPermissionDao;
	}

	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String index() throws Exception {
		return "sysuser/index";
	}
	
	@RequestMapping(value="/form",method=RequestMethod.GET)
	public String form() throws Exception {
		return "sysuser/sysuser_form";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Map<String, Object> list(Integer page, Integer rows,@RequestParam(defaultValue="id") String sort,@RequestParam(defaultValue="asc") String order,SysUser condition) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		int start = (page - 1) * rows;
		List<SysUser> list = sysUserDao.getListByCondition(start, rows, condition, sort, order);
		int total = sysUserDao.getCountByCondition(condition);
		
		map.put("rows", list);
		map.put("total", total);
		
		return map;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(SysUser user,Integer[] roleIds){
		Map<String, Object> map = new HashMap<>();
		//对密码进行加密存储
		Md5Hash md5Hash = new Md5Hash(user.getPassword(), user.getSalt());
		user.setPassword(md5Hash.toString());
		sysUserDao.add(user);
		sysUserDao.addUserRole(user.getId(), roleIds);
		
		map.put("result", true);
		return map;
	}
	
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> edit(SysUser user,Integer[] roleIds){
		Map<String, Object> map = new HashMap<>();
		//对密码进行加密存储
		Md5Hash md5Hash = new Md5Hash(user.getPassword(), user.getSalt());
		user.setPassword(md5Hash.toString());
		sysUserDao.update(user);
		sysUserDao.addUserRole(user.getId(), roleIds);
		
		map.put("result", true);
		return map;
	}
	
	@RequestMapping("/batchDelete")
	@ResponseBody
	public Map<String, Object> batchDelete(Integer[] ids) throws Exception {
		Map<String, Object> map = new HashMap<>();
		sysUserDao.deleteByIds(ids);
		map.put("result", true);
		return map;
	}
	@RequestMapping("/view")
	@ResponseBody
	public SysUser view(Integer id) throws Exception {
		return sysUserDao.getById(id);
	}
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login() {
		return "/login";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(String username,String password,Model model,HttpSession session){
		 
		SysUser sysUser= sysUserDao.getByUsername(username);
		
		if (sysUser==null) {
			
		}else {
			Md5Hash md5Hash=new Md5Hash(password, sysUser.getSalt());
			if (sysUser.getPassword().equals(md5Hash.toString())) {
				//登陆标识
				session.setAttribute("login_user", sysUser);
				//菜单
				
				List<SysPermission> permissions=sysPermissionDao.getPermissionByUserId(sysUser.getId(), "menu");
				session.setAttribute("permissions", permissions);
				 
				return "redirect:/user/main";
			}
		}
		model.addAttribute("error", "账号或密码不正确！");
		return "login";
	}
	@RequestMapping("/main")
	public String main() {
		return "main";
	}
	
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		
		session.removeAttribute("permissions");
		session.removeAttribute("login_user");
		return "redirect:/user/login";
	}
	
	
	
	
	
	
	
	
}






