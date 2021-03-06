package com.sn.controller;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sn.common.Const;
import com.sn.pojo.User;
import com.sn.util.JsonResult;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;



@Controller
@RequestMapping("/uploadFile" )
public class UploadController extends BaseController{
	
	@Value("${uploadFolder}")
	private String filePath;

	@RequestMapping("index")
	public String snFile(ModelMap map, HttpServletRequest request){
		HttpSession session=request.getSession();
		User user= (User) session.getAttribute(Const.CURRENT_USER);

		if (user!=null){
			map.put("user",user);
			return "index";
		}
		return "login";
	}
	
	/**
	 * 上传文件
	 * @param request
	 * @param response
	 * @param guid
	 * @param chunk
	 * @param file
	 * @param chunks
	 */
	@RequestMapping("bigFile")
	public void bigFile(HttpServletRequest request, HttpServletResponse response,String guid,Integer chunk, MultipartFile file,Integer chunks){
		HttpSession session=request.getSession();
		User user= (User) session.getAttribute(Const.CURRENT_USER);
		if(user.getRole()==Const.Role.ROLE_ADMIN){
			try {
				boolean isMultipart = ServletFileUpload.isMultipartContent(request);
				if (isMultipart) {
					// 临时目录用来存放所有分片文件
					String tempFileDir = filePath + guid;
					File parentFileDir = new File(tempFileDir);
					if (!parentFileDir.exists()) {
						parentFileDir.mkdirs();
					}
					// 分片处理时，前台会多次调用上传接口，每次都会上传文件的一部分到后台
					File tempPartFile = new File(parentFileDir, guid + "_" + chunk + ".part");
					FileUtils.copyInputStreamToFile(file.getInputStream(), tempPartFile);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {

		}

	}
	
	/**
	 * 组合文件
	 * @param guid
	 * @param fileName
	 * @throws Exception
	 */
	@RequestMapping("mergeFile")
	@ResponseBody
	public JsonResult mergeFile(String guid,String fileName){
		 // 得到 destTempFile 就是最终的文件  
		JsonResult jsonReulst = new JsonResult();
		try {
			File parentFileDir = new File(filePath + guid);
			if(parentFileDir.isDirectory()){
				File destTempFile = new File(filePath + "/merge",fileName);
		        for (int i = 0; i < parentFileDir.listFiles().length; i++) {  
		            File partFile = new File(parentFileDir, guid + "_" + i + ".part");  
		            FileOutputStream destTempfos = new FileOutputStream(destTempFile, true);  
		            //遍历"所有分片文件"到"最终文件"中  
		            FileUtils.copyFile(partFile, destTempfos);  
		            destTempfos.close();  
		        }  
		        // 删除临时目录中的分片文件  
		        FileUtils.deleteDirectory(parentFileDir);
		        //this.successFormat(jsonReulst);
				jsonReulst.setState("SUCCESS");
				jsonReulst.setCode(200);
				return jsonReulst;

			}else {
				jsonReulst.setState("NoRole");
				jsonReulst.setCode(600);
				return jsonReulst;
			}
		} catch (Exception e) {
			e.printStackTrace();
			//this.failFormat(jsonReulst);
			jsonReulst.setState("FailED");
			jsonReulst.setCode(400);
			return jsonReulst;
		}

          
	}
}
