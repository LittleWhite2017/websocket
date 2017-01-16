package com.warm.wschat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by lihongxu1 on 2017/1/12.
 */
@Controller
@RequestMapping("login")
public class LoginController {


    @RequestMapping("userLogin")
    public String login(HttpServletRequest request , HttpServletResponse response, ModelAndView model){
        return "test";
    }

}
