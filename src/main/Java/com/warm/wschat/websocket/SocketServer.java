package com.warm.wschat.websocket;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by lihongxu1 on 2017/1/20.
 */
@ServerEndpoint("/socketServer")
public class SocketServer {
    private static List list = new ArrayList();//保存保持连接用户信息
    private static int onLineCount = 0 ;
    private Session session;//建立好的连接websocketSession 用于保存会话等信息
    @OnOpen
    public void onOpen(Session session, HttpSession httpSession){
        System.out.println("连接已经开启");
        this.session =session;
        addOnLineCount();
        System.out.println(httpSession.getAttribute("userid"));
    }
    @OnClose
    public void onClose(){
        System.out.println("连接已经关闭");
    }
    @OnMessage
    public void onMessage(Session session){
        System.out.println("消息发送中");
    }
    @OnError
    public void onError(){
        System.out.println("连接发送错误");
    }
    private void addOnLineCount() {
        SocketServer.onLineCount++;
    }

}
