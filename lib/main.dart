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
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return const MyApp();
    },
  ));

  // FlutterError.onError = (d) async {
  //   Zone.current
  //       .handleUncaughtError(d.exception, d.stack ?? StackTrace.current);
  // };
  // runZonedGuarded(
  //   () => runApp(
  //     ScreenUtilInit(
  //       designSize: const Size(375, 812),
  //       minTextAdapt: true,
  //       splitScreenMode: true,
  //       builder: (context, child) {
  //         return const MyApp();
  //       },
  //     ),
  //   ),
  //   (error, stack) {
  //     print('clmd err:' +
  //         error.toString() +
  //         '\nclmd stack info:\n' +
  //         stack.toString());
  //   },
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: 50,
                  width: 100,
                  child: File('/private/var/mobile/Containers/Data/Application/14801AF9-72F5-4F24-9A22-8A31996A0014/tmp/image_picker_9BEAEFD6-E07F-43ED-8D5D-7AE2A11CB4C6-4995-00001F81C7711BA8.jpg').existsSync() ? Text('存在') : Text('不存在')),

              SizedBox(
                height: 50,
                width: 100,
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Row(children: [
                          Image.asset(
                            fit: BoxFit.fitHeight,
                            'assets/home_good_man.png',
                          ),
                          if (_counter % 4 > 0)
                            Image.asset(
                              fit: BoxFit.fitHeight,
                              'assets/home_good_man.png',
                            ),
                        ])),
                    if (_counter % 4 > 1)
                      Expanded(
                          flex: 1,
                          child: Row(children: [
                            Image.asset(
                              fit: BoxFit.fitHeight,
                              'assets/home_good_man.png',
                            ),
                            if (_counter % 4 > 2)
                              Image.asset(
                                fit: BoxFit.fitHeight,
                                'assets/home_good_man.png',
                              ),
                          ])),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  final result =
                      await _channel.invokeMethod('getDNS', 'bc.jtexpress.my');
                  print(result.toString());
                  Api.post1Data('https://${result}:443/bclogin/out/loginV2', {
                    "content-type": "application/json; charset=utf-8",
                    "timestamp": "1723716255312",
                    "signature": "NjM0QkZFRkYwODJGODg2ODg5Q0RCQjFBNUI4MDcyNTY=",
                    "userCode": "null",
                    "authToken": "913ee941fd6a4133bf322d3d03f05ce5",
                    "X-SimplyPost-Id": "1723716255312",
                    "X-SimplyPost-Signature":
                        "2a5068066e62da248e73e0186bbeee75",
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
                child: const Text(
                  '阿里 DNS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  // var sppResult = await Navigator.pushNamed(context, 'spp');
                  print('JT内部扫描库需要重新导入');
                },
                child: const Text(
                  '内部组件 scanPlugin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  for (int i = 0; i < 3; i++) {
                    futuresCall(i);
                  }
                },
                child: const Text(
                  'future list call',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final String reply = await _basecChannel.send('dart 2 na');
                  print('MessageChannelTest in dart： $reply');
                },
                child: const Text(
                  'basic channl test - dart 2 na',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  _channel.invokeMethod('basicChannlTest');
                },
                child: const Text(
                  'basic channl test - na 2 dart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  _channel.invokeMethod('imgPicker');
                },
                child: const Text(
                  'channel到原生拍摄',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                // controller: widget.textController,
                // style: JTStyle.text3c16SpStyle,
                textAlign: TextAlign.left,
                autofocus: false,
                minLines: 1,
                maxLines: 5,
                readOnly: false,
                maxLength: 50,
                // inputFormatters: widget.inputFormatters,
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
                // focusNode: widget.focusNode,
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              TextButton(
                onPressed: () async {
                  // var model = OssRequest.fromJson({
                  //   "requestUrl":
                  //       "https://demo-ylapp.jtexpress.my/bc/upload/file/getBatchUploadSignedUrl",
                  //   "headers": {
                  //     "app-version": "1.0.43",
                  //     "app-platform": "iOS_com.jitu.express.malaysia.outfield",
                  //     "device-id": "WCI3822FB18-D524-4ED5-9CF1-4014A762BEBF",
                  //     "device-name": "iPhone 8 Plus",
                  //     "device-version": "iOS-13.7",
                  //     "user-agent": "ios/app_out",
                  //     "app-channel": "Internal Deliver",
                  //     "device": "WCI3822FB18-D524-4ED5-9CF1-4014A762BEBF",
                  //     "devicefrom": "ios",
                  //     "appid": "g0exxal082vu",
                  //     "langType": "CN",
                  //     "content-type": "application/json; charset=utf-8",
                  //     "timestamp": "1699595284927",
                  //     "signature":
                  //         "MEM1NkNGQkMxRTQzNkFFODUxOEJGRDE2ODM2MDEwMUM=",
                  //     "userCode": "NSN6100008",
                  //     "authToken": "25ba35d5fd514ac2b4f1880ef294bf76",
                  //     "X-SimplyPost-Id": "1699595284927",
                  //     "X-SimplyPost-Signature":
                  //         "99c32bf03113bcd39e4df00b5676d064",
                  //     "contentType": "application/json; charset=utf-8",
                  //     "responseType": "ResponseType.json",
                  //     "followRedirects": "true",
                  //     "connectTimeout": "10000",
                  //     "receiveTimeout": "10000"
                  //   },
                  //   "fileList": _filelist,
                  //   "moduleName": "scan_return_sign"
                  // });
                  // var result = await _ossPlugin.uploadWithOss(model);
                  print('ossSdk 内部库需要重新导入 Android用不了');
                },
                child: const Text(
                  '私有插件-oss 上传图片',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // TextButton(
              //   onPressed: () async {
              //     var rsp =
              //         await ImagePicker().pickImage(source: ImageSource.camera);
              //     _filelist = [rsp?.path ?? ''];
              //     var bd = await File(_filelist.first).readAsBytes();
              //     final result =
              //         await _channel.invokeMethod('imgComp', bd.toList());
              //     print('ossSdk fileList: $_filelist');
              //   },
              //   child: const Text(
              //     '私有插件-oss 选择图片',
              //     style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              ValueListenableBuilder(
                  valueListenable: addressNf, builder: (c, v, p) => Text('$v')),
              TextButton(
                onPressed: () async {
                  // var result = await LocationHelper()
                  //     .covertAddress(locationNf.value ?? LocationInfo());
                  // print(result.toString());
                  // addressNf.value = result;
                },
                child: const Text(
                  '私有插件-covertAddress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // ValueListenableBuilder(
              //     valueListenable: locationNf,
              //     builder: (c, v, p) =>
              //         Text('${v?.latitude} , ${v?.longitude}')),
              // TextButton(
              //   onPressed: () async {
              //     var auth = await LocationHelper().hasLocationPermission();
              //     if (auth) {
              //       var result = await LocationHelper().getLocation();
              //       print(result.toString());
              //       locationNf.value = result;
              //     } else {
              //       LocationHelper().openLocationSettings();
              //     }
              //   },
              //   child: const Text(
              //     '私有插件-location',
              //     style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              TextButton(
                onPressed: () async {
                  String url = 'tel:17621761283';
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                  }

                  final result =
                      await _channel.invokeMethod('callObs', '17621761283');
                  print(result.toString());
                },
                child: const Text(
                  '拨打电话 CallKit监听',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              TextButton(
                onPressed: () {
                  SyncUtil.syncCall(() {
                    print(DateTime.now().toString());

                    return null;
                  }, space: const Duration(seconds: 1));
                },
                child: const Text(
                  '串行异步队列',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              buildBodyScore(77, true),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              TextButton(
                onPressed: () async {
                  var info = await PackageInfo.fromPlatform();
                  print(
                      'APP info: \n -name:${info.appName} \n -packageName:${info.packageName} \n -version:${info.version} \n -buildNumber:${info.buildNumber} \n ');
                },
                child: const Text(
                  'APP Info',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              Text(DateTime.utc(2023, 1, 1).toIso8601String()),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'lrs');
                },
                child: const Text(
                  '制图',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'fds');
                },
                child: const Text(
                  '三方蓝牙搜索页',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              // DecoratedBox(
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.blue),
              //   ),
              //   child: SizedBox(
              //     width: 200,
              //     child: MarqueeWidget(
              //         text:
              //             "Hello World! How are you today? This is a demo of a MarqueeWidget in Flutter.",
              //         width: 300.0,
              //         height: 30.0,
              //         style: TextStyle(fontSize: 18.0, color: Colors.blue),
              //         speed: 3000),
              //   ),
              // ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              buildBlueWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildBodyScore(int score, bool isMan) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        width: 150.5.w,
        height: 150.h,
        decoration: BoxDecoration(
            color: Colors.lightBlue, borderRadius: BorderRadius.circular(10.5)),
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
                )),
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
        ));
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
