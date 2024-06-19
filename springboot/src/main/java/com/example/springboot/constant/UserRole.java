package com.example.springboot.constant;

/**
 * @author xh
 * @Date 2024/6/4
 */
public enum UserRole {
    STU("stu") , DORM("dormManager") , ADMIN("admin") ;

    private String value;

    UserRole(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
