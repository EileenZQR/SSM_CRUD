package crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crud.bean.Employee;
import crud.bean.EmployeeExample;
import crud.bean.EmployeeExample.Criteria;
import crud.dao.EmployeeMapper;

/**
 * 业务逻辑组件
 * @author dell
 *
 */
@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 查詢所有的员工
	 * @return
	 */
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDept(null);
	}

	
	/**
	 * 员工保存
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}


	/**
	 * 检验用户名是否重复
	 * @param empName
	 * @return	true：表示当前用户名可用
	 */
	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		//构造查詢条件
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria createCriteria = employeeExample.createCriteria();
		createCriteria.andEmpNameEqualTo(empName);
		
		long count = employeeMapper.countByExample(employeeExample);
		
		return count == 0;
	}

	/**
	 * 根据员工id查詢员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee selectByPrimaryKey = employeeMapper.selectByPrimaryKey(id);
		return selectByPrimaryKey;
	}


	/**
	 * 员工更新
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}


	/**
	 * 删除单个员工,根据id
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}


	/**
	 * 根据id的list集合批量删除员工
	 * @param id
	 */
	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
}
