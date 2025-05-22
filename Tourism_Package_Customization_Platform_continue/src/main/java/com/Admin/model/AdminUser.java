package com.Admin.model;

import com.User.model.User;

public class AdminUser extends User {
    public AdminUser(String username, String password, String email) {
        super(username, password, email);
    }

    @Override
    public String login() {
        return "Admin " + username + " logged in.";
    }

    @Override
    public String toString() {
        return "ADMIN," + getUsername() + ","  + getPassword() + "," + getEmail() ;
    }

}
