package com.example.springboot;


import com.example.springboot.manager.AiManager;

import lombok.extern.slf4j.Slf4j;

import org.junit.jupiter.api.Test;

import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

@Slf4j
public class AiTests {

    @Test
    void contextLoads() {
    }


    @Resource
    private AiManager aiManager;

    @Test
    void testChatgpt() {
        String answer = aiManager.doChat(1669210882330079234L, "我现在学习压力有点大，如何缓解自己的压力呢?");
        System.out.println(answer);
    }


}
