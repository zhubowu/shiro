package org.aptech.shiro.permission.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.aptech.shiro.permission.pojo.SysPermission;

public interface SysPermissionDao extends CommonDao<SysPermission, Integer>{

	public List<Integer> getPermissionIdsByRoleId(Integer roleId);
	
	public void deletePermissionsByRoleId(Integer roleId);
	
	public void addRolePermissions(@Param("roleId") Integer roleId,@Param("perIds") List<Integer> perIds);

	public List<SysPermission> getOneType();
	
	/**
	 * 根据用户编号和类型获得权限列表
	 * @param uId
	 * @param type
	 * @return
	 */
	public List<SysPermission> getPermissionByUserId(@Param("userId")Integer uId,@Param("type")String type);


}








