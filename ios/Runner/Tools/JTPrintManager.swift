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

#if DEBUG || UAT
        let localUrl = UserDefaults.standard.string(forKey: "modeViewLocalUrl") ?? "http://10.66.103.54:8887/modeView76100.html"
        if let url = URL(string: localUrl) {
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, resp, err in
                if let resultResp = resp as? HTTPURLResponse, resultResp.statusCode == 200, err == nil {
                    value.loadUrl(localUrl)
                } else if let url = Bundle.main.url(forResource: "modeView76100", withExtension: "html"), let data = try? Data(contentsOf: url) {
                    value.load(data, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
                }
            }.resume()
        }
#else
        if let url = Bundle.main.url(forResource: "modeView76100", withExtension: "html"), let data = try? Data(contentsOf: url) {
            value.load(data, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        }
#endif
        return value
    }()
    
    func getImgWith(_ data: [String: Any], callback: Callback1Value<UIImage?>?) {
        webView.callHandler("setContent", arguments: [data], completionHandler: {[weak self] value in
            guard let `self` = self else { return }
            let config = WKSnapshotConfiguration()
            config.snapshotWidth = 700
            webView.takeSnapshot(with: config) { img, error in
                callback?(img)
            }
        })
    }
}
