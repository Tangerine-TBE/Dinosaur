# base

Flutter项目基础架构

## Getting Started

### 引入


## 目录说明

#### `/example`目录 app基础架构案例

- example（架构代码运用实例）
    - app
        - launcher
            - flavor // 启动对应的环境
            - strategy // 环境配置策略
        - src // 页面、业务
    - app_base
        - config // 路由、环境变量等配置
        - http // 网络请求对象、拦截器
        - mvvm // 基于架构，定制化适合app自身的base类
        - repository // api 仓库

#### `/lib` 架构核心目录
- lib
    - base
        - app
        - helper
        - mvvm // MVVM架构基类
            - model // 数据模型
            - repo // api仓库、api数据转换
            - view // 基于GetView<C>，base_page、base_appbar_page封装基础页面
            - vm // 基于GetXController的数据持久化层、持有repo对象
        - route // 抽象路由
    - common
        - common // 可共享组件和拓展
        - launcher // 启动策略
        - log // 日志工具
        - network // 网络请求工具
        - startup // 启动任务初始化工具

> 架构封装并非简单抽取，应尽可能使用ioc技术，聚焦管理抽象依赖

### 1. /example/app 详细说明

- launcher 专注配置启动策略，以创造环境变量
    - flavor 启动入口，配合Android Studio的Run Configuration使用
    - strategy 启动策略，继承ALauncherStrategy
- src 页面和业务，可参考如何实现MVVM
    - my_app.dart // app加载入口

### 2. /example/app_base 详细说明

#### 2.1 http 请求

- 主要看sample_dio_proxy，继承DioProxy按照模板配置参数，自身做一个单例
- 另外所有拦截器也放这里

#### 2.2 mvvm

对架构代码的继承本地化，增加拓展性

- base_controller.dart // 作为ViewModel的子类，专注数据和业务状态存储
- base_repo.dart // 作为基础请求仓库的存在，提供并持有dio代理对象

#### 2.2 repository api请求仓库

- 如menu_repo.dart，需要继承base_repo.dart

### 3. /lib/base 详细说明

#### 3.1 app

app入口类需要继承`BaseMaterialApp`，规定构造参数`ALauncherStrategy`和`ARoute`

#### 3.2 mvvm

MVVM架构，abstract类居多，可供客户端拓展

#### 3.3 route

基于GetPage，规定了客户端路由配置模板

### 4. /lib/common 说明

#### 4.1 startup 启动任务

使用时，需要继承`FlutterStartup`，

> 具体案例参考 `example/lib/app/src/config/startup_config.dart`

```dart
// 由于依赖BuildContext
// 需要等待页面build完毕，执行startup
// 例如在app首次启动页面的构造函数中，调用下面代码
WidgetsBinding.instance.addPostFrameCallback((_) {
  StartupManager(Get.context!, startupMap).start();
});
```

> 補充：已經集成到BaseLauncherPage
