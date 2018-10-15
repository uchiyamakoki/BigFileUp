package com.sn.dao;

import com.sn.pojo.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    int checkUsername(String username);

    User selectLogin(@Param("username") String username,@Param("password") String password);
}
