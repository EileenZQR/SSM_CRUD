package crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import crud.bean.Department;
import crud.bean.Employee;
import crud.dao.DepartmentMapper;
import crud.dao.EmployeeMapper;

/**
 * 测试dao层的工作
 * 建议Spring的项目使用Spring的单元测试，可以自动注入需要的组件
 * 1.导入springTest需要的模块
 * 2.使用 @ContextCondiguration 注解指定Spring配置文件的位置
 * 3.直接Autowired需要使用的组件
 * @author dell
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * 测试DepartmentMapper
	 */
	@Test
	public void testCRUD() {
		//1.根据配置文件创建ioc容器
		//ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.从容器中获取mapper
		//DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);
		
		//插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
		
		//生成员工数据，测试员工插入
//		employeeMapper.insertSelective(new Employee(null, "jerry", "M", "jerry.com", 1));
		
		//批量插入员工
		/*
		 * for() { employeeMapper.insertSelective(new Employee(null, "jerry", "M",
		 * "jerry.com", 1)); }
		 */
		
		//配置一个可以执行批量的sqlSession,提高效率
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+".com", 1));
		}
	}
}
