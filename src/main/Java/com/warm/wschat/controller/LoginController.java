package com.warm.wschat.controller;

import com.warm.wschat.commons.Message;
import com.warm.wschat.domain.User;
import com.warm.wschat.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by lihongxu1 on 2017/1/12.
 */
@Controller
public class LoginController {
    @Resource
    private UserService userService;

    @RequestMapping(value = "user/login",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public Message login(User entity , HttpServletRequest request, HttpServletResponse response){
        User user = userService.selectByUserid(entity.getUserid());
        Message message = new Message();
        String password = entity.getPassword();
        if(user==null){
            message.setSuccess(false);
            message.setMsg("用户不存在");
            message.setData("");
        }else {
            if(password.equals(entity.getPassword())){
                message.setSuccess(true);
                message.setMsg("用户存在");
                message.setData(user);
            }else{
                message.setSuccess(false);
                message.setMsg("密码错误，请确认密码后登录");
                message.setData(user);
            }
        }
        return message;
    }
    @RequestMapping(value = "/doLogin",method = {RequestMethod.POST,RequestMethod.GET})
    public String doLogin(){

        return "main";
    }

}
