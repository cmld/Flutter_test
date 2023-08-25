//
//  JTCallManager.swift
//  Runner
//
//  Created by Gotnf on 2023/4/20.
//

import UIKit
import CallKit

class JTCallManager: NSObject {
    
    public static var shared: JTCallManager { return self.instance }
    private static let instance = JTCallManager()
    private override init() {}
    
    /// 回调（通话状态、活跃状态）
    fileprivate var callEventHandler:((JTCallState, Bool) -> Void)?
    /// 通话完毕
    public var callComplete:(() -> Void)?
    
    fileprivate var backgroundTask: UIBackgroundTaskIdentifier?
    
    // 监听对象
    private var callObserver: CXCallObserver?
    // 活跃状态
    private var appIsForeground: Bool = true
    // 是否接通
    private var isConnected: Bool = false
    
    /// 电联开始时间
    private var contactStartTime: String = ""
    /// 电联结束时间
    private var contactEndTime: String = ""
    /// 电联是否接通
    private var isContacted: Bool = false
    
    // 设置电话监听
    func setupObserver() {
        callObserver = CXCallObserver()
        callObserver?.setDelegate(self, queue: .main)
        
        // 监听活跃状态
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    // 移除电话监听
    func removeObserver() {
        contactStartTime = ""
        contactEndTime = ""
        isContacted = false
        
        if callObserver != nil {
            callObserver?.setDelegate(nil, queue: .main)
            callObserver = nil
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    // 将进入前台通知
    @objc private func appWillEnterForeground(){
        appIsForeground = true
    }
    // 应用程序确实进入了后台
    @objc private func appDidEnterBackground(){
        appIsForeground = false
    }
}


// MARK: - CXCallObserverDelegate
extension JTCallManager: CXCallObserverDelegate {
    /*
     拨打:  outgoing :1  onHold :0   hasConnected :0   hasEnded :0
     拒绝:  outgoing :0  onHold :0   hasConnected :0   hasEnded :1
     链接:  outgoing :1  onHold :0   hasConnected :1   hasEnded :0
     挂断:  outgoing :1  onHold :0   hasConnected :0   hasEnded :1
     对方未接听时挂断：  outgoing :1  onHold :0   hasConnected :0   hasEnded :1
     
     新来电话:    outgoing :0  onHold :0   hasConnected :0   hasEnded :0
     保留并接听:  outgoing :1  onHold :1   hasConnected :1   hasEnded :0
     另一个挂掉:  outgoing :0  onHold :0   hasConnected :1   hasEnded :0
     已断开链接:  outgoing :1  onHold :0   hasConnected :1   hasEnded :1
     对方挂掉:    outgoing :0  onHold :0   hasConnected :1   hasEnded :1
     */
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        debugPrint("outgoing :\(call.isOutgoing)  onHold :\(call.isOnHold)  hasConnected :\(call.hasConnected)   hasEnded :\(call.hasEnded)")
        let outgoing = call.isOutgoing
        let onHold = call.isOnHold
        let hasConnected = call.hasConnected
        let hasEnded = call.hasEnded
        
        // 通话状态
        var callState: JTCallState = .none
        
        if outgoing && !onHold && !hasConnected && !hasEnded {
            // 主动拨打电话 CallStateDialing
            debugPrint("主动拨打电话")
            callState = .dialing
        }else if outgoing && !onHold && hasConnected && !hasEnded {
            // 已链接 CallStateConnected
            debugPrint("已链接")
            callState = .connected
        }else if outgoing && !onHold && !hasConnected && hasEnded {
            // 挂断 - 对方未接听时挂断 CallStateDisconnectedHangup
            debugPrint("挂断 - 未接通时挂断")
            callState = .disconnectedHangup
        }else if outgoing && !onHold && hasConnected && hasEnded {
            // 已断开链接 CallStateDisconnected
            debugPrint("已断开链接")
            callState = .connectedHangup
        }
        // 回调
        callEventHandler?(callState,appIsForeground)
    }
}

/// 通话状态
enum JTCallState {
    case none               // 初始状态
    case dialing            // 拨打电话
    case connected          // 接通电话
    case disconnectedHangup // 未接通挂断
    case connectedHangup    // 已接通挂断
}

// MARK: - JTCallObserverManager 通话监听上传
extension JTCallManager {
    /// 开启电话监听
    /// - Parameters:
    ///   - phone: 联系电话
    func setupCallObserver(_ phone: String, complete: @escaping ([String : Any])-> Void) {
        // Request the task assertion and save the ID.
        registerBackgroundTask()
        // 电话监听
        JTCallManager.shared.setupObserver()
        // 系统通话回调
        JTCallManager.shared.callEventHandler = {[weak self] callState, activeState in
            debugPrint(Date().timeIntervalSince1970)
            // 记录通话
            switch callState {
            case .dialing:
                // 拨号
                    self?.contactStartTime = "\(Date().timeIntervalSince1970)"
                self?.contactEndTime = ""
                self?.isContacted = false
            case .connected:
                // 接通电话
                self?.contactStartTime = "\(Date().timeIntervalSince1970)"
                self?.contactEndTime = ""
                self?.isContacted = true
            case .connectedHangup:
                // 未接通挂断
                self?.contactEndTime = "\(Date().timeIntervalSince1970)"
                self?.isContacted = true
                self?.handleCallBack(phone, complete: complete)
            case .disconnectedHangup:
                // 接通挂断
                self?.contactEndTime = "\(Date().timeIntervalSince1970)"
                self?.isContacted = false
                self?.handleCallBack(phone, complete: complete)
            default: break
            }
        }
    }
    
    // 开启电话监听
    private func handleCallBack(_ phone: String, complete: @escaping ([String : Any])-> Void) {
        // End the task assertion.
        endBackgroundTask()
        
        // 通话总时长
        var contactTime: Int = Int(TimeInterval(contactEndTime) ?? 0 - (TimeInterval(contactStartTime) ?? 0))
        if contactTime < 0 { contactTime = 0 }
        // 接通时长
        var duration = contactTime
        
        // 默认等待时长7秒
        if isContacted {
            duration = contactTime
        }else {
            duration = 0
        }
        
        var params: [String : Any] = [:]
        // 类型 未接通 not_answered 接通 outgoing
        params["type"] = isContacted ? "outgoing" : "not_answered"
        params["phone"] = phone
        params["time"] = contactStartTime
        params["duration"] = duration
        params["endTime"] = contactEndTime
        params["contactTime"] = contactTime
        
        complete(params)
            
        // 移除电话监听
        JTCallManager.shared.removeObserver()
    }
}


extension JTCallManager {
    /// Register background task.
    private func registerBackgroundTask() {
        DispatchQueue.global().async {
            self.backgroundTask = UIApplication.shared.beginBackgroundTask (withName: "CallBackgroundTask") {
                // Ends long-running background task
                self.endBackgroundTask()
            }
        }
    }
    /// Ends long-running background task.
    private func endBackgroundTask() {
        if let backgroundTask = self.backgroundTask {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            self.backgroundTask = UIBackgroundTaskIdentifier.invalid
        }
    }
}
