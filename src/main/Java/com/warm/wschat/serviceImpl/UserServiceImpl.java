package com.warm.wschat.serviceImpl;

import com.warm.wschat.dao.UserMapper;
import com.warm.wschat.domain.User;
import com.warm.wschat.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by lihongxu1 on 2017/1/16.
 */
@Service("userService")
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;


    public User selectByUserid(String userid) {
        User user = userMapper.selectByUserId(userid);
        return user;
    }
}
