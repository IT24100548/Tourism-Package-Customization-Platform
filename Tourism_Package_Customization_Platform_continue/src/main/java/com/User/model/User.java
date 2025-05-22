package com.User.model;

import java.io.Serializable;

// Abstract class: Cannot be instantiated directly
public abstract class User implements Serializable {
    protected String username;
    protected String password;
    protected String email;

    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
    }

    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getEmail() { return email; }

    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setUsername(String username){this.username = username;}

    public abstract String login();

    @Override
    public String toString() {
        return this.getClass().getSimpleName() + "," + getUsername() + "," + getEmail() + "," + getPassword();
    }

}
