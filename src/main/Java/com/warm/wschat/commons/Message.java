package com.warm.wschat.commons;

/**
 * 利用json将用户登录状态，写入message类，发送到前端页面做验证
 */
public class Message {
    private String msg;

    private boolean success = true;

    private Object data;

    public Message(){

    }
    public Message(Object data){
        this.data  = data   ;
    }

    public Message(String msg, boolean success, Object data) {
        this.msg = msg;
        this.success = success;
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
