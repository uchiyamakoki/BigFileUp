package com.sn.service;

import com.sn.common.ServerResponse;
import com.sn.pojo.User;

public interface IUserService {

    ServerResponse<User> login(String username, String password);
}
