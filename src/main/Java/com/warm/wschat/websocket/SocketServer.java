package com.warm.wschat.websocket;

import com.alibaba.fastjson.JSONObject;
import com.warm.wschat.domain.Enum.MsgType;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * Created by lihongxu1 on 2017/1/20.
 */
@ServerEndpoint(value = "/socketServer",configurator = HttpSessionConfigurator.class)
public class SocketServer {
    private static List list = new ArrayList();//保存保持连接用户信息
    private static int onLineCount = 0 ;
    private static String userid;
    private static Map routeMap = new HashMap<>();
    private static CopyOnWriteArraySet<SocketServer> webSocketSet = new CopyOnWriteArraySet<>();//每个连接 持有一个SocketSocket对象实例，可以这么理解
    private Session session;//建立好的连接websocketSession 用于保存会话等信息
    @OnOpen
    public void onOpen(Session session, EndpointConfig config){
        System.out.println("连接已经开启");
        this.session =session;
        HttpSession httpSession =(HttpSession) config.getUserProperties().get(HttpSession.class.getName());

        this.userid= (String)httpSession.getAttribute("userid");
        String password = (String)httpSession.getAttribute("password");
//        System.out.println(userid);
//        System.out.println(password);
        webSocketSet.add(this);
        addOnLineCount();
        list.add(userid);
        routeMap.put(userid,session);//静态路由保存回话与用户的对应关系
        String message = jsonMessage("[" + userid + "]加入聊天室,当前在线人数为"+getOnLineCount()+"位", MsgType.NOTICE.getValue(),  list);
        //广播用户登录消息，发送给所有在线用户
        boreadMsg(message);

    }
    @OnClose
    public void onClose(){
        webSocketSet.remove(this);  //从set中删除
        subOnlineCount();           //在线数减1
        list.remove(userid);        //从在线列表移除这个用户
        routeMap.remove(userid);
        String message = jsonMessage("[" + userid +"]离开了聊天室,当前在线人数为"+getOnLineCount()+"位", "notice", list);
        boreadMsg(message);         //广播
        System.out.println("连接已经关闭");
    }

    private void subOnlineCount() {
        SocketServer.onLineCount--;
    }

    @OnMessage
    public void onMessage(String _message){
        System.out.println("消息发送中");
    }
    @OnError
    public void onError(Throwable error){
        error.printStackTrace();
        System.out.println("连接发送错误");
    }
    //用户登录，在线人数加1，用于统计在线人数以及用户登录的时候的消息推送
    private void addOnLineCount() {
        SocketServer.onLineCount++;
    }

    private String jsonMessage(String message ,String type, List list){
        JSONObject object = new JSONObject();
        object.put("message",message);
        object.put("type",type);
        object.put("list",list);
        return object.toString();
    }
    public static int getOnLineCount() {
        return onLineCount;
    }
    private void boreadMsg(String message){
        for(SocketServer socketServer : webSocketSet ){
            try {
                socketServer.session.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();

            }
        }
    }
}
