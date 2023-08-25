import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
    let msger: FlutterBinaryMessenger  = window?.rootViewController as! FlutterBinaryMessenger
    pluginChannel(msg: msger)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
//    channel
    func pluginChannel(msg: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(name: "plugin_clmd", binaryMessenger: msg)
        channel.setMethodCallHandler { (call: FlutterMethodCall, result:@escaping FlutterResult) in
            switch (call.method) {
                case "callObs":
                    print("invok call Obs")
                    guard let phone = call.arguments as? String else {
                        return
                    }
                    JTCallManager.shared.setupCallObserver(phone) { datas in
                        result(datas)
                    }
                    break
                default:
                    break
            }
        }
    }
}
