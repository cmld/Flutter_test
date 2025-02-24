import 'dart:async';
import 'dart:io';

import 'package:clmd_flutter/pages/ble_manager.dart';
import 'package:clmd_flutter/components/marquee_ai.dart';
import 'package:clmd_flutter/routes.dart';
import 'package:clmd_flutter/utils/network.dart';
import 'package:clmd_flutter/utils/thread_sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:oss_plugin/bean/OssRequest.dart';
// import 'package:oss_plugin/oss_plugin.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  // 初始化屏幕适配
  runApp(ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 这是应用程序的根部件
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: routes,
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // 这是应用程序的主页部件。它是有状态的，意味着它有一个状态对象（在下面定义），包含影响其外观的字段。
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final MethodChannel _channel = const MethodChannel('plugin_clmd');
  final BasicMessageChannel _basecChannel =
      const BasicMessageChannel('basic_plugin_clmd', StandardMessageCodec());

  int _counter = 0;
  // ValueNotifier<LocationInfo?> locationNf = ValueNotifier(null);
  ValueNotifier<String?> addressNf = ValueNotifier(null);

  BLEManager manager = BLEManager();

  // final _ossPlugin = OssPlugin();
  List<String> _filelist = [];

  // 增加计数器的方法
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _basecChannel.setMessageHandler((message) {
      print(message.toString());
      return Future(() => "basic channl back");
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = TextButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        // 从 MyHomePage 对象中获取值，并将其用于设置应用栏标题
        title: Text(widget.title),
      ),
      body: Center(
        // Center 是一个布局部件。它接收一个子部件并将其置于父部件的中间。
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 检查文件是否存在
              SizedBox(
                height: 50,
                width: 100,
                child: File('/private/var/mobile/Containers/Data/Application/14801AF9-72F5-4F24-9A22-8A31996A0014/tmp/image_picker_9BEAEFD6-E07F-43ED-8D5D-7AE2A11CB4C6-4995-00001F81C7711BA8.jpg').existsSync()
                    ? Text('存在')
                    : Text('不存在'),
              ),
              // 显示图片
              SizedBox(
                height: 50,
                width: 100,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Image.asset(
                            fit: BoxFit.fitHeight,
                            'assets/home_good_man.png',
                          ),
                          if (_counter % 4 > 0)
                            Image.asset(
                              fit: BoxFit.fitHeight,
                              'assets/home_good_man.png',
                            ),
                        ],
                      ),
                    ),
                    if (_counter % 4 > 1)
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Image.asset(
                              fit: BoxFit.fitHeight,
                              'assets/home_good_man.png',
                            ),
                            if (_counter % 4 > 2)
                              Image.asset(
                                fit: BoxFit.fitHeight,
                                'assets/home_good_man.png',
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              // 阿里 DNS 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () async {
                          final result = await _channel.invokeMethod('getDNS', 'bc.jtexpress.my');
                          print(result.toString());
                          Api.post1Data('https://${result}:443/bclogin/out/loginV2', {
                            "content-type": "application/json; charset=utf-8",
                            "timestamp": "1723716255312",
                            "signature": "NjM0QkZFRkYwODJGODg2ODg5Q0RCQjFBNUI4MDcyNTY=",
                            "userCode": "null",
                            "authToken": "913ee941fd6a4133bf322d3d03f05ce5",
                            "X-SimplyPost-Id": "1723716255312",
                            "X-SimplyPost-Signature": "2a5068066e62da248e73e0186bbeee75",
                            "langType": "CN",
                            "contentType": "application/json; charset=utf-8",
                            "responseType": "ResponseType.json",
                            "followRedirects": "true",
                            "connectTimeout": "20000",
                            "receiveTimeout": "20000",
                          }, {
                            "account": "NSN6100003",
                            "appDeviceCode": "Android-31",
                            "appType": "4",
                            "appVersion": "1.1.13",
                            "latitudeAndLongitude": "31.220267,121.209177",
                            "macAddr": "WA-427b2c652b36c0f",
                            "password": "4e71002969fcd46813b869e931aedf4b",
                            "platform": "android",
                            "serialnumber": "WA-427b2c652b36c0f",
                            "source": "outfield",
                          });
                        },
                        child: const Text('阿里 DNS'),
                      ),
                    ],
                  ),
                ),
              ),
              // 内部组件 scanPlugin 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () async {
                          // var sppResult = await Navigator.pushNamed(context, 'spp');
                          print('JT内部扫描库需要重新导入');
                        },
                        child: const Text('内部组件 scanPlugin'),
                      ),
                    ],
                  ),
                ),
              ),
              // future list call 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () {
                          for (int i = 0; i < 3; i++) {
                            futuresCall(i);
                          }
                        },
                        child: const Text('future list call'),
                      ),
                    ],
                  ),
                ),
              ),
              // basic channl test - dart 2 na 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () async {
                          final String reply = await _basecChannel.send('dart 2 na');
                          print('MessageChannelTest in dart： $reply');
                        },
                        child: const Text('basic channl test - dart 2 na'),
                      ),
                    ],
                  ),
                ),
              ),
              // basic channl test - na 2 dart 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () async {
                          _channel.invokeMethod('basicChannlTest');
                        },
                        child: const Text('basic channl test - na 2 dart'),
                      ),
                    ],
                  ),
                ),
              ),
              // channel到原生拍摄 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () async {
                          _channel.invokeMethod('imgPicker');
                        },
                        child: const Text('channel到原生拍摄'),
                      ),
                    ],
                  ),
                ),
              ),
              // 文本输入框
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textAlign: TextAlign.left,
                      autofocus: false,
                      minLines: 1,
                      maxLines: 5,
                      readOnly: false,
                      maxLength: 50,
                      enableSuggestions: false,
                      onChanged: (String v) {
                        // widget.onChange?.call(v);
                      },
                      decoration: InputDecoration(
                        filled: false,
                        isCollapsed: true,
                        hintText: '请输入内容',
                        contentPadding: EdgeInsets.symmetric(horizontal: 13.w),
                        border: InputBorder.none,
                        enabledBorder: null,
                        focusedBorder: null,
                        counterText: '',
                      ),
                      magnifierConfiguration: TextMagnifierConfiguration(
                          shouldDisplayHandlesInMagnifier: false),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // 私有插件-oss 上传图片 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () async {
                          // var model = OssRequest.fromJson({
                          // ...existing code...
                          print('ossSdk 内部库需要重新导入 Android用不了');
                        },
                        child: const Text('私有插件-oss 上传图片'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // 私有插件-covertAddress 按钮
              ValueListenableBuilder(
                valueListenable: addressNf,
                builder: (c, v, p) => Text('$v'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () async {
                          // var result = await LocationHelper()
                          //     .covertAddress(locationNf.value ?? LocationInfo());
                          // print(result.toString());
                          // addressNf.value = result;
                        },
                        child: const Text('私有插件-covertAddress'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // 拨打电话 CallKit监听 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () async {
                          String url = 'tel:17621761283';
                          if (await canLaunchUrlString(url)) {
                            await launchUrlString(url);
                          }

                          final result = await _channel.invokeMethod('callObs', '17621761283');
                          print(result.toString());
                        },
                        child: const Text('拨打电话 CallKit监听'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // 串行异步队列 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () {
                          SyncUtil.syncCall(() {
                            print(DateTime.now().toString());

                            return null;
                          }, space: const Duration(seconds: 1));
                        },
                        child: const Text('串行异步队列'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // 显示身体得分
              buildBodyScore(77, true),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // APP Info 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () async {
                          var info = await PackageInfo.fromPlatform();
                          print(
                              'APP info: \n -name:${info.appName} \n -packageName:${info.packageName} \n -version:${info.version} \n -buildNumber:${info.buildNumber} \n ');
                        },
                        child: const Text('APP Info'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // 显示日期
              Text(DateTime.utc(2023, 1, 1).toIso8601String()),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // 制图 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, 'lrs');
                        },
                        child: const Text('制图'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // 三方蓝牙搜索页 按钮
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        style: buttonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, 'fds');
                        },
                        child: const Text('三方蓝牙搜索页'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // 蓝牙管理部件
              buildBlueWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // 这个逗号使得自动格式化更好看
    );
  }

  // 显示身体得分的方法
  Widget buildBodyScore(int score, bool isMan) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      width: 150.5.w,
      height: 150.h,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(10.5),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 5.h,
            left: 5.w,
            child: Text(
              '身体得分',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: -5.h,
            left: -5.w,
            child: Image.asset(
              'assets/home_good_man.png',
              width: 110.w,
            ),
          ),
          Positioned(
            top: 10.h,
            right: 35.w,
            child: Text(
              score.toString(),
              style: TextStyle(
                fontSize: 30.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            top: 40.h,
            right: 35.w,
            child: Text(
              '分',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 5.h,
            child: SizedBox(
              width: 21.w,
              child: Text(
                '100',
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 5.h,
            child: SizedBox(
              width: 21.w,
              child: Text(
                '0',
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 5.h,
            right: 23.w,
            child: Container(
              height: 130.h,
              width: 7.5.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(255, 255, 255, 0.2),
                  Color.fromRGBO(255, 255, 255, 1),
                ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 130.h * score / 100 - 2.5.h,
            right: 19.25.w,
            child: Container(
              height: 15.h,
              width: 15.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBlueWidget() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
      ),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              // manager.write([78, 43, 49, 48, 48, 48, 48]); // N+10000
              manager.write([
                65,
                66,
                67,
                68,
                69,
                70,
                71,
                72,
                73,
                74,
                75,
                76,
                77,
                78,
                49,
                48,
                48,
                48,
                48
              ]);
            
            },
            child: Text('初始化'),
          ),
          TextButton(
            onPressed: () {
              manager.write([
                65,
                66,
                67,
                68,
                69,
                70,
                71,
                72,
                73,
                74,
                75,
                76,
                77,
                78,
                50,
                48,
                48,
                48,
                48
              ]); // N+20000
            
            },
            child: Text('获取权限'),
          ),
          TextButton(
            onPressed: () {
              manager.write([
                65,
                66,
                67,
                68,
                69,
                70,
                71,
                72,
                73,
                74,
                75,
                76,
                77,
                78,
                52,
                49,
                48,
                48,
                48
              ]); // N+41000
            
            },
            child: Text('启动'),
          ),
          TextButton(
            onPressed: () {
              manager.write([
                65,
                66,
                67,
                68,
                69,
                70,
                71,
                72,
                73,
                74,
                75,
                76,
                77,
                78,
                51,
                48,
                48,
                51,
                49
              ]); // N+30031
            
            },
            child: Text('一档'),
          ),
          TextButton(
            onPressed: () {
              manager.write([
                65,
                66,
                67,
                68,
                69,
                70,
                71,
                72,
                73,
                74,
                75,
                76,
                77,
                78,
                51,
                48,
                49,
                53,
                53
              ]); // N+30155
            
            },
            child: Text('七档'),
          ),
          TextButton(
            onPressed: () {
              manager.write([
                65,
                66,
                67,
                68,
                69,
                70,
                71,
                72,
                73,
                74,
                75,
                76,
                77,
                78,
                54,
                48,
                48,
                48,
                48
              ]); // N+60000
            },
            child: Text('停止'),
          ),
        ],
      ),
    );
  }

  Completer comp = Completer();
  void futuresCall(int item) {
    test1()
        .then((value) => test2())
        .then((value) => test3())
        .whenComplete(() {});
  }

  Future<bool> test1() async {
    print('test1');
    return Future.delayed(const Duration(seconds: 1), () => true);
  }

  Future<bool> test2() async {
    print('test2');
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future test3() async {
    print('test3');
    return 1;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        print('paused');
        break;
      case AppLifecycleState.resumed:
        print('resumed');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.detached:
        print('detached');
        break;
    }
  }
}
