package com.warm.wschat.controller;

import com.warm.wschat.domain.User;
import com.warm.wschat.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * Created by lihongxu1 on 2017/1/18.
 * @SessionAttributes("userid")用于HttpSession中的attributes对象的值
 */
@Controller
@SessionAttributes("userid")
public class UserController {
    @Resource
    private UserService userService;
    @RequestMapping("/chat")
    public ModelAndView chat(){
        ModelAndView view = new ModelAndView("main");
        return view;
    }
    @RequestMapping("{userid}/config")
    public ModelAndView userConfig(@PathVariable String userid){
        ModelAndView view = new ModelAndView("info-setting");
        User user =userService.selectByUserid(userid);
        view.addObject("user",user);
        return view;
    }
    @RequestMapping("{userid}/update")
    public ModelAndView update(User user){
        ModelAndView view = new ModelAndView("info-setting");

        boolean flag = userService.update(user);
        return view;
    }
}
