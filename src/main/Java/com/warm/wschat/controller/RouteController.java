package com.warm.wschat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by lihongxu1 on 2017/1/13.
 */
@Controller
public class RouteController {

    @RequestMapping(value = "")
    public String index() {

        return "test";
    }

    @RequestMapping(value = "login")
    public String login() {
        return "login";
    }

    @RequestMapping(value = "about")
    public String about() {
        return "about";
    }

    @RequestMapping(value = "help")
    public String help() {
        return "help";
    }
}
