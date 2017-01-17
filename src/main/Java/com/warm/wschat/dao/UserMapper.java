package com.warm.wschat.dao;

import com.warm.wschat.domain.User;
import org.springframework.stereotype.Service;

/**
 * Created by lihongxu1 on 2017/1/16.
 */
@Service("userMapper")
public interface UserMapper {
    User selectByUserId(String userid);
}
