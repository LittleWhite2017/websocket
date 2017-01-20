package com.warm.wschat.domain.Enum;

/**
 * Created by lihongxu1 on 2017/1/20.
 */
public enum MsgType {
    NOTICE(0,"notice");

    private int code;
    private String value;
    MsgType(int code , String value){
        this.code = code;
        this.value = value;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
