package com.warm.wschat.service;

import com.warm.wschat.domain.User;

/**
 * Created by lihongxu1 on 2017/1/16.
 */
public interface UserService {
    User selectByUserid(String userid);

    boolean update(User user);
}
