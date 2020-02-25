package crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crud.bean.Department;
import crud.dao.DepartmentMapper;



/**
 * 业务逻辑组件
 * @author dell
 *
 */
@Service
public class DepartmentService {

	@Autowired
	DepartmentMapper departmentMapper;
	
	/**
	 * 查詢所有的部门
	 * @return
	 */
	public List<Department> getDepts() {
		List<Department> depts = departmentMapper.selectByExample(null);
		return depts;
	}
	
}
