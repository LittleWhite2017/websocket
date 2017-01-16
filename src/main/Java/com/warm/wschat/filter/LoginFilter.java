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
        String[] notFilter = new String[] { "login","login.jsp","user/logout","user/login" };  // 不过滤的uri
        System.out.println("contextPath = " + contextPath);
        System.out.println("URI = " + uri);
        if(uri.indexOf("jsp")!=-1){//不存在jsp
            boolean doFilter =true;
            for(String s : notFilter){
                if(uri.indexOf(s)!=-1){
                    doFilter = false;
                    break;
                }
            }
            if(doFilter){
                if (null == request.getSession().getAttribute("login_status")) {
//                    System.out.println(uri+">>>>>>>=>过滤器执行过滤");
                    response.sendRedirect(contextPath + "/login?timeout=true");
                } else {
                    // 如果session中存在登录者实体，则继续
//                    System.out.println(uri+">>>>>>>=>过滤器=>已登录");
                    filterChain.doFilter(request, response);
                }
            }else {
                // 如果不执行过滤，则继续
//                System.out.println(uri+">>>>>>>=>过滤器自动忽略");
                filterChain.doFilter(request, response);
            }
        }else{
            filterChain.doFilter(request,response);
        }

    }


}
