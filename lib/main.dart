import 'package:clmd_flutter/ble_manager.dart';
import 'package:clmd_flutter/components/marquee_ai.dart';
import 'package:clmd_flutter/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    print(DateTime.utc(2023, 1, 1).toIso8601String());
    print(DateTime.utc(2023, 1, 7, 23, 59, 59).toIso8601String());
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
              Text(DateTime.utc(2023, 1, 1).toIso8601String()),
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
}
