//
//  JTPrintManager.swift
//  JtStation-Indonesia-iOS
//
//  Created by yl on 2025/1/9.
//  Copyright © 2025 Shine. All rights reserved.
//

import UIKit
import dsBridge

class JTPrintManager: NSObject {
    static let share = JTPrintManager()
    
    lazy var webView: DWKWebView = {
        let value = DWKWebView()
        value.frame = CGRectMake(0, 0, 300, 600)
//        if let url = Bundle.main.url(forResource: "idnStation", withExtension: "html") {
//            value.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
//        }
        value.loadUrl("http://10.66.103.46:8887/idnStation.html")
        return value
    }()
    
    func getImgWith(_ data: [String: Any], callback: Callback1Value<UIImage?>?) {
        webView.callHandler("setContent", arguments: [data], completionHandler: {[weak self] value in
            guard let `self` = self else { return }
            webView.takeSnapshot(with: WKSnapshotConfiguration()) { img, error in
                callback?(img)
            }
        })
    }
}
