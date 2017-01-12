package com.warm.wschat.filter;

import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by lihongxu1 on 2017/1/12.
 */
public class LoginFilter extends OncePerRequestFilter {

    private static final String LOGIN_URI = "/login";
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response ,FilterChain filterChain) throws ServletException, IOException {
        String contextPath = request.getContextPath();  //主路径
        String uri = request.getRequestURI();
        System.out.println("contextPaht = " + contextPath);
        System.out.println("URI = " + uri);
    }


}
