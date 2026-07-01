package com.tapyfood.dao;

import com.tapyfood.model.User;

public interface UserDAO {

    boolean registerUser(User user);

    User validateLogin(String email, String password);

    User getUserByEmail(String email);
}