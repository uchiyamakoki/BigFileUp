package com.sn.controller;

import com.sn.common.Const;
import com.sn.common.ServerResponse;
import com.sn.pojo.User;
import com.sn.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/*
    用户模块
 */
@Controller
@RequestMapping("/user")
public class UserController {


    @Autowired
    private IUserService iUserService;

    @RequestMapping("index")
    public String index(){
        return "login";
    }

    /**
     * 用户登录
     * @param session
     * @return
     */
    @RequestMapping("login")
    @ResponseBody
    public ServerResponse<User> login(ModelMap map, HttpServletRequest request, HttpSession session){
        //1.0获取参数
        String username=request.getParameter("username"); //与form的name对应
        String password=request.getParameter("password");
        ServerResponse<User> response=iUserService.login(username,password);
        if (response.isSuccess()){
            session.setAttribute(Const.CURRENT_USER,response.getData());
        }
        return response;
    }

    @RequestMapping("logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "login";
    }





}
