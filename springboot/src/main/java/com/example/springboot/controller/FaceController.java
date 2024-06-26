package com.example.springboot.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.arcsoft.face.*;
import com.arcsoft.face.enums.DetectMode;
import com.arcsoft.face.enums.DetectOrient;
import com.arcsoft.face.enums.ErrorInfo;
import com.arcsoft.face.toolkit.ImageInfo;
import com.example.springboot.common.Result;
import com.example.springboot.constant.FaceConfig;
import com.example.springboot.constant.UserRole;
import com.example.springboot.entity.*;
import com.example.springboot.service.AdminService;
import com.example.springboot.service.DormManagerService;
import com.example.springboot.service.StudentService;
import com.example.springboot.service.UserFaceInfoService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static com.arcsoft.face.toolkit.ImageFactory.getRGBData;
import static com.example.springboot.common.Result.error;
import static com.example.springboot.common.Result.success;

/**
 * @author xh
 * @Date 2024/6/10
 */
@RestController
@RequestMapping("/face")
public class FaceController {

    @Resource
    private UserFaceInfoService userFaceInfoService;

    @Resource
    private StudentService studentService;

    @Resource
    private DormManagerService dormManagerService;

    @Resource
    private AdminService adminService;

    private String appId = FaceConfig.APP_ID;
    private String sdkKey = FaceConfig.SDK_KEY;
    private String libPath = FaceConfig.LIB_PATH;
    private FaceEngine faceEngine = new FaceEngine(libPath);

    @PostConstruct
    public void init() {
        //激活引擎
        int errorCode = faceEngine.activeOnline(appId, sdkKey);
        System.out.println(libPath);
        if (errorCode != ErrorInfo.MOK.getValue() && errorCode != ErrorInfo.MERR_ASF_ALREADY_ACTIVATED.getValue()) {
            System.out.println("引擎激活失败");
        }
        ActiveFileInfo activeFileInfo = new ActiveFileInfo();
        errorCode = faceEngine.getActiveFileInfo(activeFileInfo);
        if (errorCode != ErrorInfo.MOK.getValue() && errorCode != ErrorInfo.MERR_ASF_ALREADY_ACTIVATED.getValue()) {
            System.out.println("获取激活文件信息失败");
        }

        //引擎配置
        EngineConfiguration engineConfiguration = new EngineConfiguration();
        engineConfiguration.setDetectMode(DetectMode.ASF_DETECT_MODE_IMAGE);
        engineConfiguration.setDetectFaceOrientPriority(DetectOrient.ASF_OP_ALL_OUT);
        engineConfiguration.setDetectFaceMaxNum(10);
        engineConfiguration.setDetectFaceScaleVal(32);
        //功能配置
        FunctionConfiguration functionConfiguration = new FunctionConfiguration();
        functionConfiguration.setSupportFaceDetect(true);
        functionConfiguration.setSupportFaceRecognition(true);
//        functionConfiguration.setSupportAge(true);
//        functionConfiguration.setSupportGender(true);
        functionConfiguration.setSupportIRLiveness(true);
        engineConfiguration.setFunctionConfiguration(functionConfiguration);


        //初始化引擎
        errorCode = faceEngine.init(engineConfiguration);

        if (errorCode != ErrorInfo.MOK.getValue()) {
            System.out.println("初始化引擎失败");
        }
    }
    /**
     * 搜集人脸
     */
    @PostMapping("/search")
    public Result<?> search(@RequestParam("file") MultipartFile file, HttpSession session) {
        FaceInfoVo faceInfoVo = verifyImg(file, session);
        System.out.println(faceInfoVo);
        if(faceInfoVo == null) {
            return error("202", "未检测到人脸");
        }
        if(faceInfoVo.isResult()) {
            return success(faceInfoVo);
        } else {
            return error("203", "人物捕捉模糊或数据库不存在此人");
        }
    }

    /**
     * 人脸验证
     */
    private FaceInfoVo verifyImg(MultipartFile file, HttpSession session) {
        int errorCode = 0;
        FaceFeature faceFeature = getFaceFeature(file, errorCode);
        if (ObjectUtil.isNull(faceFeature)) {
            return null;
        }
        // 比对结果
        FaceInfoVo faceInfoVo = new FaceInfoVo();
        // 数据库拿到所有特征 TODO 小根堆排序，异步多线程优化 设计模式优化冗余代码
        List<UserFaceInfo> userFaceInfoList = userFaceInfoService.getUserFaceFeatureAll();
        for (UserFaceInfo userFaceInfo : userFaceInfoList) {
            // 得到面部特征
            FaceFeature faceFeatureDB = new FaceFeature(userFaceInfo.getFaceFeature());
            FaceSimilar faceSimilar = new FaceSimilar();

            errorCode = faceEngine.compareFaceFeature(faceFeature, faceFeatureDB, faceSimilar);
            faceInfoVo.setSimilarity(faceSimilar.getScore());
            faceInfoVo.setResult(faceSimilar.getScore() > 0.8);
            if(faceSimilar.getScore() > 0.8) {
                // 匹配成功
                String userRole = userFaceInfo.getUserRole();
                if(userRole.equals(UserRole.STU.getValue())) {
                    String stuName = userFaceInfo.getUserName();
                    Student student = studentService.getById(stuName);
                    faceInfoVo.setUser(student);
                    faceInfoVo.setIdentity("stu");
                    //存入session
                    session.setAttribute("Identity", "stu");
                    session.setAttribute("User", student);
                } else if(userRole.equals(UserRole.DORM.getValue())) {
                    String dormName = userFaceInfo.getUserName();
                    DormManager dormManager = dormManagerService.getById(dormName);
                    faceInfoVo.setUser(dormManager);
                    faceInfoVo.setIdentity("stu");
                    //存入session
                    session.setAttribute("Identity", "dorm");
                    session.setAttribute("User", dormManager);
                } else if(userRole.equals(UserRole.ADMIN.getValue())) {
                    String adminName = userFaceInfo.getUserName();
                    Admin admin = adminService.getById(adminName);
                    faceInfoVo.setUser(admin);
                    faceInfoVo.setIdentity("admin");
                    //存入session
                    session.setAttribute("Identity", "admin");
                    session.setAttribute("User", admin);
                }
                break;
            }
        }
        System.out.println("相似度：" + faceInfoVo.getSimilarity());
        //引擎卸载
//        if (faceInfoVo.isResult()) {
//            errorCode = faceEngine.unInit();
//        }
        return faceInfoVo;
    }

    @PostMapping("/upload")
    public Result<?> upload(@RequestParam("file") MultipartFile file, HttpSession session) {
        int errorCode = 0;
        FaceFeature faceFeature = getFaceFeature(file, errorCode);
        if (ObjectUtil.isNull(faceFeature)) {
            return error("202", "未检测到人脸");
        }
        UserFaceInfo userFaceInfo = new UserFaceInfo();
        userFaceInfo.setFaceFeature(faceFeature.getFeatureData());
        JSONObject user = JSONUtil.parseObj(session.getAttribute("User"));
        userFaceInfo.setUserName(user.getStr("username"));
        userFaceInfo.setUserRole(session.getAttribute("Identity").toString());
        if (userFaceInfoService.insertUserFaceInfo(userFaceInfo) != 0) {
            return success( "人脸录入成功");
        }
        return Result.error("203", "人脸录入失败");
    }

    private FaceFeature getFaceFeature(MultipartFile file, int errorCode) {
        ImageInfo imageInfo = null;
        try {
            imageInfo = getRGBData(file.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<FaceInfo> faceInfoList = new ArrayList<>();
        errorCode = faceEngine.detectFaces(imageInfo.getImageData(), imageInfo.getWidth(), imageInfo.getHeight(), imageInfo.getImageFormat(), faceInfoList);
        ;

        // 未检测到人脸
        if (faceInfoList.size() <= 0) {
            return null;
        }

        //特征提取
        FaceFeature faceFeature = new FaceFeature();
        errorCode = faceEngine.extractFaceFeature(imageInfo.getImageData(), imageInfo.getWidth(), imageInfo.getHeight(), imageInfo.getImageFormat(), faceInfoList.get(0), faceFeature);
        return faceFeature;
    }

}
