package com.example.springboot.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.ObjectUtil;
import com.example.springboot.common.Result;
import com.example.springboot.common.UID;
import com.example.springboot.constant.FileConfig;
import com.example.springboot.entity.Admin;
import com.example.springboot.entity.DormManager;
import com.example.springboot.entity.Student;
import com.example.springboot.service.AdminService;
import com.example.springboot.service.DormManagerService;
import com.example.springboot.service.StudentService;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;

@RestController
@RequestMapping("/files")
public class FileController {

    static String rootFilePath = "";
    static String originalFilename = "";

    @PostConstruct
    private void init() {
        rootFilePath = FileConfig.ROOT_FILE_PATH;
        originalFilename = FileConfig.ORIGINAL_FILENAME;
    }

    @Resource
    private StudentService studentService;

    @Resource
    private AdminService adminService;

    @Resource
    private DormManagerService dormManagerService;

    /**
     * 将上传的头像写入本地 rootFilePath
     */
    @PostMapping("/upload")
    public Result<?> upload(@RequestParam MultipartFile file) throws IOException {
        //获取文件名
        originalFilename = file.getOriginalFilename();
        //获取文件尾缀
        String fileType = originalFilename.substring(originalFilename.lastIndexOf("."), originalFilename.length());

        //重命名
        String uid = new UID().produceUID();
        originalFilename = uid + fileType;
        System.out.println(originalFilename);
        //存储位置
        String targetPath = rootFilePath + originalFilename;
        //获取字节流
        FileUtil.writeBytes(file.getBytes(), targetPath);
        return Result.success("上传成功");
    }

    /**
     * 将头像名称更新到数据库中
     * 开启事务回滚
     */
    @PostMapping("/uploadAvatar/stu")
    @Transactional
    public Result<?> uploadStuAvatar(@RequestBody Student student) throws IOException {
        if (originalFilename != null) {
            if (!StringUtils.isEmpty(student.getAvatar())) {
                FileUtil.del(rootFilePath + student.getAvatar());
            }
            student.setAvatar(originalFilename);
            System.out.println(student);
            // 更新学生头像信息
            int i = studentService.updateNewStudent(student);
            if (i == 1) {
                return Result.success(originalFilename);
            }
        } else {
            return Result.error("-1", "rootFilePath为空");
        }
        return Result.error("-1", "设置头像失败");
    }

    @PostMapping("/uploadAvatar/admin")
    public Result<?> uploadAdminAvatar(@RequestBody Admin admin) throws IOException {
        if (originalFilename != null) {
            if (!StringUtils.isEmpty(admin.getAvatar())) {
                FileUtil.del(rootFilePath + admin.getAvatar());
            }
            System.out.println(admin);
            admin.setAvatar(originalFilename);
            int i = adminService.updateAdmin(admin);
            if (i == 1) {
                return Result.success(originalFilename);
            }
        } else {
            return Result.error("-1", "rootFilePath为空");
        }
        return Result.error("-1", "设置头像失败");
    }

    @PostMapping("/uploadAvatar/dormManager")
    public Result<?> uploadDormManagerAvatar(@RequestBody DormManager dormManager) throws IOException {
        if (originalFilename != null) {
            if (!StringUtils.isEmpty(dormManager.getAvatar())) {
                FileUtil.del(rootFilePath + dormManager.getAvatar());
            }
            dormManager.setAvatar(originalFilename);
            int i = dormManagerService.updateNewDormManager(dormManager);
            if (i == 1) {
                return Result.success(originalFilename);
            }
        } else {
            return Result.error("-1", "rootFilePath为空");
        }
        return Result.error("-1", "设置头像失败");
    }

    /**
     * 前端调用接口，后端查询存储与本地的头像，进行Base64编码 发送到前端
     */
    @GetMapping("/initAvatar/{filename}")
    public Result<?> initAvatar(@PathVariable String filename) throws IOException {
        System.out.println(filename);
        String path = rootFilePath + filename;
        System.out.println(path);
        return getImage(path);
    }

    /**
     * 根据路径得到图片字节数组
     */
    private byte[] imgToByteByPath(String path) {
        //读取图片变成字节数组
        FileInputStream fileInputStream;
        ByteArrayOutputStream bos;
        try {
            fileInputStream = new FileInputStream(path);

        bos = new ByteArrayOutputStream();
        byte[] b = new byte[1024];
        int len = -1;
        while ((len = fileInputStream.read(b)) != -1) {
            bos.write(b, 0, len);
        }
        fileInputStream.close();
        bos.close();
        } catch (IOException e) {
            return null;
        }
        return bos.toByteArray();
    }

    private Result<?> getImage(String path) throws IOException {
        byte[] fileByte = imgToByteByPath(path);
        if (ObjectUtil.isNull(fileByte)) {
            return Result.error("-1","头像不存在");
        }
        //进行base64编码
        BASE64Encoder encoder = new BASE64Encoder();
        String data = encoder.encode(fileByte);
        return Result.success(data);
    }

}
