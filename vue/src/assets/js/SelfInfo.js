import request from "@/utils/request";

const { ElMessage } = require("element-plus");
export default {
    name: "selfInfo",
    data() {
        // 手机号验证
        const checkPhone = (rule, value, callback) => {
            const phoneReg = /^1[3|4|5|6|7|8][0-9]{9}$/;
            if (!value) {
                return callback(new Error("电话号码不能为空"));
            }
            setTimeout(() => {
                if (!Number.isInteger(+value)) {
                    callback(new Error("请输入数字值"));
                } else {
                    if (phoneReg.test(value)) {
                        callback();
                    } else {
                        callback(new Error("电话号码格式不正确"));
                    }
                }
            }, 100);
        };
        const checkPass = (rule, value, callback) => {
            if (!this.editJudge) {
                console.log("验证");
                if (value == "") {
                    callback(new Error("请再次输入密码"));
                } else if (value !== this.form.password) {
                    callback(new Error("两次输入密码不一致!"));
                } else {
                    callback();
                }
            } else {
                console.log("不验证");
                callback();
            }
        };
        return {
            showpassword: true,
            image: "",
            editJudge: true,
            disabled: true,
            dialogVisible: false,
            faceVisible: false,
            ishandleClick: false,
            identity: "",
            username: "",
            name: "",
            gender: "",
            age: "",
            phoneNum: "",
            email: "",
            targetURL: "",
            avatar: "",
            vdstate: false,
            form: {
                username: "",
                name: "",
                gender: "",
                age: "",
                phoneNum: "",
                email: "",
            },
            rules: {
                username: [
                    { required: true, message: "请输入账号", trigger: "blur" },
                    {
                        pattern: /^[a-zA-Z0-9]{4,9}$/,
                        message: "必须由 4 到 9 个字母或数字组成",
                        trigger: "blur",
                    },
                ],
                name: [
                    { required: true, message: "请输入姓名", trigger: "blur" },
                    {
                        pattern: /^(?:[\u4E00-\u9FA5·]{2,10})$/,
                        message: "必须由 2 到 10 个汉字组成",
                        trigger: "blur",
                    },
                ],
                gender: [{ required: true, message: "请选择性别", trigger: "change" }],
                age: [
                    { required: true, message: "请输入年龄", trigger: "blur" },
                    { type: "number", message: "年龄必须为数字值", trigger: "blur" },
                    {
                        pattern: /^(1|[1-9]\d?|100)$/,
                        message: "范围：1-100",
                        trigger: "blur",
                    },
                ],
                phoneNum: [{ required: true, validator: checkPhone, trigger: "blur" }],
                email: [
                    { type: "email", message: "请输入正确的邮箱地址", trigger: "blur" },
                ],
                password: [
                    { required: true, message: "请输入密码", trigger: "blur" },
                    {
                        min: 6,
                        max: 32,
                        message: "长度在 6 到 16 个字符",
                        trigger: "blur",
                    },
                ],
                checkPass: [{ validator: checkPass, trigger: "blur" }],
            },
            display: {
                display: "none",
            },
            imgDisplay: {
                display: "none",
            },
        };
    },
    created() {
        this.load();
        this.find();
        this.init(this.avatar);
    },
    methods: {
        //获取个人信息页面信息
        load() {
            this.form = JSON.parse(sessionStorage.getItem("user"));
            this.identity = JSON.parse(sessionStorage.getItem("identity"));
            this.username = this.form.username;
            this.name = this.form.name;
            this.gender = this.form.gender;
            this.age = this.form.age;
            this.phoneNum = this.form.phoneNum;
            this.email = this.form.email;
            this.avatar = this.form.avatar;
        },
        //查询数据，更新session
        find() {
            this.form = JSON.parse(sessionStorage.getItem("user"));
            request.post("/" + this.identity + "/login", this.form).then((res) => {
                //更新sessionStorage
                window.sessionStorage.setItem("user", JSON.stringify(res.data));
                //更新页面数据
                this.load();
            });
        },
        Edit() {
            this.dialogVisible = true;
            this.$nextTick(() => {
                this.$refs.form.resetFields();
                this.form = JSON.parse(sessionStorage.getItem("user"));
            });
        },
        cancel() {
            this.$refs.form.resetFields();
            this.display = { display: "none" };
            this.showpassword = true;
            this.editJudge = true;
            this.disabled = true;
            this.dialogVisible = false;
        },
        async save() {
            this.$refs.form.validate(async (valid) => {
                if (valid) {
                    //修改
                    await request.put("/" + this.identity + "/update", this.form).then((res) => {
                        if (res.code === "0") {
                            ElMessage({
                                message: "修改成功",
                                type: "success",
                            });
                            //更新sessionStorage
                            window.sessionStorage.setItem(
                                "user",
                                JSON.stringify(this.form)
                            );
                            this.find();
                            this.dialogVisible = false;
                        } else {
                            ElMessage({
                                message: res.msg,
                                type: "error",
                            });
                        }
                    });
                }
            });
        },
        EditPass() {
            if (this.editJudge) {
                this.display = { display: "flex" };
                this.showpassword = false;
                this.disabled = false;
                this.editJudge = false;
            } else {
                this.display = { display: "none" };
                this.showpassword = true;
                this.editJudge = true;
                this.disabled = true;
            }
        },
        //发送请求，获取头像
        async init(data) {
            if (data === null || data === "") {
                console.log("用户未设置头像");
                this.imgDisplay = { display: "none" };
            } else {
                this.imgDisplay = { display: "block" };
                console.log("头像名称：" + data);
                await request.get("/files/initAvatar/" + data).then((res) => {
                    if (res.code === "0") {
                        this.image = res.data.data;
                    } else {
                        ElMessage({
                            message: res.msg,
                            type: "error",
                        });
                    }
                });
            }
        },
        async uploadSuccess() {
            this.form = JSON.parse(sessionStorage.getItem("user"));
            await request.post("/files/uploadAvatar/" + this.identity, this.form).then((res) => {
                if (res.code === "0") {
                    ElMessage({
                        message: "设置成功",
                        type: "success",
                    });
                    //获取头像文件名
                    this.avatar = res.data;
                    console.log("上传成功：" + this.avatar);
                    this.find();
                    this.init(this.avatar);
                } else {
                    ElMessage({
                        message: res.msg,
                        type: "error",
                    });
                }
            });
        },
        checkCamera() {
            var _this = this;
            let a = JSON.stringify(navigator);
            // console.log(this.$route.query.code)
            // this.handlecode()
            this.$nextTick(() => {
                var _this = this;
                // console.log('video', this.$refs['vd'])
                // return
                // 访问用户媒体设备的兼容方法
                function getUserMedia(constrains, success, error) {
                    var video = _this.$refs["vd"];
                    if (navigator.mediaDevices.getUserMedia) {
                        // 最新标准API
                        let myCons = { ...constrains, video: true };
                        navigator.mediaDevices
                            .getUserMedia(constrains)
                            .then((stream) => {
                                video.srcObject = stream;
                                video.play();
                                _this.vdstate = true;
                            })
                            .catch(error);
                    } else if (navigator.webkitGetUserMedia) {
                        // webkit内核浏览器
                        navigator.webkitGetUserMedia(constrains).then(success).catch(error);
                    } else if (navigator.mozGetUserMedia) {
                        // Firefox浏览器
                        navagator.mozGetUserMedia(constrains).then(success).catch(error);
                    } else if (navigator.getUserMedia) {
                        // 旧版API
                        navigator.getUserMedia(constrains).then(success).catch(error);
                    }
                }
                var video = this.$refs["vd"];
                var canvas = this.$refs["cav"];
                // debugger
                var context = canvas.getContext("2d");

                // 成功的回调函数
                function success(stream) {
                    _this.vdstate = true;
                    // 兼容webkit内核浏览器
                    var CompatibleURL = window.URL || window.webkitURL;
                    // 将视频流设置为video元素的源
                    video.src = CompatibleURL.createObjectURL(stream);
                    // 播放视频
                    video.play();
                }
                // 异常的回调函数
                function error(error) {
                    alert(error);
                    console.log("访问用户媒体设备失败：", error.name, error.message);
                }
                if (
                    navigator.mediaDevices.getUserMedia ||
                    navigator.getUserMedia ||
                    navigator.webkitGetUserMedia ||
                    navigator.mozGetUserMedia
                ) {
                    // 调用用户媒体设备，访问摄像头
                    getUserMedia(
                        {
                            video: { width: 200, height: 200 }
                        },
                        success,
                        error
                    );
                } else {
                    alert("你的浏览器不支持访问用户媒体设备");
                }
                // 获取图片
            });
        },
        handleClick() {
            // 1.开启截图
            this.ishandleClick = true;
            let _this = this;
            // 2.设备是否可以使用
            if (!_this.vdstate) {
                return false;
            }
            // 3.是否已经通过
            if (!_this.states) {
                // 注册拍照按钮的单击事件

                let video = this.$refs["vd"];
                let canvas = this.$refs["cav"];
                // let form = this.$refs["myForm"];
                let context = canvas.getContext("2d");
                // 绘制画面
                context.drawImage(video, 0, 0, 200, 200);
                let base64Data = canvas.toDataURL("image/png");

                // 封装blob对象
                let blob = this.dataURItoBlob(base64Data, "camera.png"); // base64 转图片file
                let formData = new FormData();
                formData.append("file", blob);

                this.imgUrl = base64Data;
                // 4.人脸检测 && 识别
                request
                    .post("/face/upload", formData)
                    .then((response) => {
                        console.log(response);
                        if (response.code == 0 ) {
                            // 验证通过
                            ElMessage({
                                message: "上传成功",
                                type: "success",
                            });
                            // 延迟加载
                            setTimeout(() => {
                                this.faceVisible = false;
                                this.ishandleClick = false;
                            }, 700);
                        } else {
                            ElMessage({
                                message: response.msg,
                                type: "error",
                            });
                            // 识别失败，重新截屏
                            this.ishandleClick = false;
                        }
                    })
                    .catch(function (error) {
                        console.log(error);
                    });
            }
        },
        dataURItoBlob(base64Data) {
            var byteString;
            if (base64Data.split(",")[0].indexOf("base64") >= 0)
                byteString = atob(base64Data.split(",")[1]);
            else byteString = unescape(base64Data.split(",")[1]);
            var mimeString = base64Data.split(",")[0].split(":")[1].split(";")[0];
            var ia = new Uint8Array(byteString.length);
            for (var i = 0; i < byteString.length; i++) {
                ia[i] = byteString.charCodeAt(i);
            }
            return new Blob([ia], { type: mimeString });
        },
    }
};