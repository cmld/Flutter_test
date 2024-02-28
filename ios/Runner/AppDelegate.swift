import UIKit
import Flutter
import IQKeyboardManagerSwift

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
    let msger: FlutterBinaryMessenger  = window?.rootViewController as! FlutterBinaryMessenger
    pluginChannel(msg: msger)
    
    configKeyBoard()
      
      // MARK: 走Flutter - main
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
      // MARK: 走Native - main
     let nativeWindow = UIWindow(frame: UIScreen.main.bounds)
     nativeWindow.backgroundColor = .white

     let nv = UINavigationController(rootViewController: HomeListViewController())
     nativeWindow.rootViewController = nv
     self.window = nativeWindow
     self.window.makeKeyAndVisible()
     return true
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
                case "imgComp":
                    if let data = call.arguments as? [UInt8] {
                        print(data.count)
                        let imgData: Data = Data(bytes: data, count: data.count)
                        let img = UIImage(data: imgData)
                        print(imgData.count)
                        
                    }
                    break
                default:
                    break
            }
        }
    }
    
    private func configKeyBoard() {
        IQKeyboardManager.shared.enable = true;
        IQKeyboardManager.shared.enableAutoToolbar = false;
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done".localized;
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true;
    }
}
