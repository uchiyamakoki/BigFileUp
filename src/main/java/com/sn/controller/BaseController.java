package com.sn.controller;


import com.sn.util.JsonResult;
import org.springframework.stereotype.Controller;



/**
 * 父类控制器, 包含一些常用的方法和属性
 *
 */
@Controller
public abstract class BaseController {


	/**
	 * 成功的jsonresult固定格式
	 * @param jsonResult
	 * @return
	 */
	protected JsonResult successFormat(JsonResult jsonResult) {
		jsonResult.setState("SUCCESS");
		return jsonResult;
	}
	
	/**
	 * 返回参数空或其他异常错误
	 * @param
	 * @return
	 */
	protected JsonResult failFormat(JsonResult jsonResult){
		jsonResult.setCode(400);
		return jsonResult;
	}

	/**
	 * 返回参数空或其他异常错误
	 * @param description
	 * @return
	 */
	protected JsonResult failFormat(String description){
		
		JsonResult jsonResult = new JsonResult();
		jsonResult.setCode(200);
		jsonResult.setDescription(description);
		return jsonResult;
	}

	/**
	 * 返回参数空或其他异常错误
	 * @param description
	 * @return
	 */
	protected JsonResult failFormat(String description,Object obj){
		
		JsonResult jsonResult = new JsonResult();
		jsonResult.setResults(obj);
		jsonResult.setCode(200);
		jsonResult.setDescription(description);
		return jsonResult;
	}
}
