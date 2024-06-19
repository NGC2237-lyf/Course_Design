package com.example.springboot.entity;

import lombok.Data;

/**
 * @author xh
 * @Date 2024/6/12
 */
@Data
public class FaceLoginInfoVo {
    private FaceInfoVo faceInfoVo;
    private Object user;
    private String identity;
}
