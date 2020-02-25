package crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import crud.bean.Employee;
import crud.bean.Msg;
import crud.service.EmployeeService;

/**
 * 处理员工的CRUD请求
 * @author dell
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 处理查詢员工的请求，实现分页，不使用ajax
	 * @param pn 页数（第几页）
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn,Model model) {
		//调用业务逻辑组件查询到所有的员工（此时还不是分页查詢）
		/* List<Employee> emps = employeeService.getAll(); */
		
		//使用 PageHelper 分页插件
		//在查詢之前调用 PageHelper.startPage(页码, 每页的大小)
		PageHelper.startPage(pn, 5);
		//startPage()后面紧跟的查詢就是分页查詢
		List<Employee> emps = employeeService.getAll();
		//用PageInfo对结果进行包装,只需要将PageInfo交给页面就可以在页面获取封装好的详细分页信息（包括查詢出来的数据）
		//第二个参数 表示连续显示的页数
		PageInfo page = new PageInfo(emps,5);	
		
		//返回给页面
		model.addAttribute("pageInfo", page);
		
		return "list";
	}
	
	/**
	 * 分页查詢所有员工，返回JSON格式的数据
	 * @ResponseBody 这个注解表明了返回的数据格式为JSON，需要导入jackson包
	 * @param pn
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/emps")
	public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		PageInfo page = new PageInfo(emps,5);	
		return Msg.success().add("pageInfo", page);
	}
	
	
	/**
	 * 新增用户
	 * 要支持JSR303校验，需要导入 Hibernate-Validator 包
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			//校验失败，在模态框中显示校验失败的错误信息
			Map<String,Object> map = new HashMap<>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for(FieldError error:fieldErrors) {
				System.out.println("错误的信息："+error.getField()+" "+error.getDefaultMessage());
				map.put(error.getField(), error.getDefaultMessage());
			}
			//返回错误信息
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}	
	}
	
	
	/**
	 * 检验用户名
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkUser(@RequestParam(value = "empName")String empName) {
		//先判断用户名是否是合法的表达式
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名必须为2-5位中文或者6-16位英文和数字的组合!");
		};
		//用户名是否重复的校验
		boolean b = employeeService.checkUser(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	
	/**
	 * 查詢指定的员工信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	/**
	 * 更新员工信息的处理方法
	 * 路径中的员工id会封装进employee对象(路径中的占位符应该和要封装的对象的属性名一致才能正确封装)
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	
	/**
	 * 根据id删除员工(可单个删除也可批量删除)
	 * 批量删除:id1-id2-id3-
	 * 单个删除:id
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			//批量删除
			String[] str_ids = ids.split("-");
			List<Integer> list = new ArrayList<>();
			for(String id:str_ids) {
				list.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(list);
		}else {
			//单个删除
			employeeService.deleteEmp(Integer.parseInt(ids));
		}
		
		return Msg.success();
	}
}
