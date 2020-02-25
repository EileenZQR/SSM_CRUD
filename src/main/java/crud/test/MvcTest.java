package crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

import crud.bean.Employee;

/**
 * 使用Spring的单元测试提供的测试请求功能来测试crud请求的正确性
 * @WebAppConfiguration 这个注解用于后面获取SpingMvc的配置文件
 * @author dell
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/springDispatcherServlet-servlet.xml"})
public class MvcTest {
	
	//传入SpringMvc的ioc
	@Autowired
	WebApplicationContext context;
	
	//虚拟MVC请求,获取到处理结果
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {	
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		//模拟发送/emps请求并拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		
		//请求成功后，在请求域中会有pageInfo，去除pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
		
		//获取PageInfo封装的信息
		System.out.println("当前页码："+pi.getPageNum());
		System.out.println("总页码："+pi.getPages());
		System.out.println("总记录数："+pi.getTotal());
		System.out.println("在页面需要练习显示的页码：");
		int[] navigatepageNums = pi.getNavigatepageNums();
		for(int i:navigatepageNums) {
			System.out.println(" "+i);
		}
		
		//获取员工数据
		List<Employee> list = pi.getList();
		for(Employee emp:list) {
			System.out.println("Id:"+emp.getEmpId());
			System.out.println("name:"+emp.getEmpName());
			System.out.println("dept_name:"+emp.getDepartment().getDeptName());
		}
		
	}
}
