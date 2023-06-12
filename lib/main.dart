import 'package:clmd_flutter/ble_manager.dart';
import 'package:clmd_flutter/components/marquee_ai.dart';
import 'package:clmd_flutter/routes.dart';
import 'package:clmd_flutter/utils/thread_sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

void main() {
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  BLEManager manager = BLEManager();

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
  Widget build(BuildContext context) {
    var ble_options = DecoratedBox(
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
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: SizedBox(
                  width: 200,
                  child: MarqueeWidget(
                      text:
                          "Hello World! How are you today? This is a demo of a MarqueeWidget in Flutter.",
                      width: 300.0,
                      height: 30.0,
                      style: TextStyle(fontSize: 18.0, color: Colors.blue),
                      speed: 3000),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.black,
              ),
              ble_options,
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
}
