//
//  EchartsViewController.swift
//  Runner
//
//  Created by yl on 2024/12/12.
//

// 相关API文档： https://echarts.apache.org/zh/option.html#yAxis.interval

import UIKit
import dsBridge

class EchartsViewController: BaseViewController {

    lazy var webView: DWKWebView = {
        let value = DWKWebView()
        
        return value
    }()
    
    lazy var changeBtn: UIButton = {
        let value = UIButton()
        value.setTitle("change", for: .normal)
        value.setTitleColor(.black, for: .normal)
        return value
    }()
    lazy var reloadBtn: UIButton = {
        let value = UIButton()
        value.setTitle("reloadBtn", for: .normal)
        value.setTitleColor(.black, for: .normal)
        return value
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.layer.borderWidth = 1
        webView.layer.borderColor = UIColor.red.cgColor
        
        view.addSubviews([webView, changeBtn, reloadBtn])
        webView.snp.makeConstraints { make in
            make.center.width.equalToSuperview()
            make.height.equalTo(300)
        }
        
        changeBtn.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(15)
            make.width.height.equalTo(100)
            make.centerX.equalTo(webView)
        }
        
        reloadBtn.snp.makeConstraints { make in
            make.top.equalTo(changeBtn.snp.bottom).offset(15)
            make.width.height.equalTo(100)
            make.centerX.equalTo(webView)
        }
        
        webLoad()
//        webView.loadUrl("http://10.66.103.46:5500/integral.html")
        jsMethodCall()
        changeBtn.addTap { [weak self]  in
            guard let `self` = self else { return }
            jsMethodCall()
            
        }
        reloadBtn.addTap { [weak self]  in
            guard let `self` = self else { return }
            webView.loadUrl("http://10.66.103.46:5500/integral.html")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.jsMethodCall()
            })
        }
        
    }
    
    func webLoad() {
        if let url = Bundle.main.url(forResource: "integral", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            jsMethodCall()
        }
    }
    var itemcount = 4
    func jsMethodCall() {
        itemcount = itemcount == 4 ? 12 : 4
        let arg = (0..<itemcount).map({item in
            return [
                "xTitle": "2023-\(item)",
                "value1": Int(arc4random() % 50),
                "value2": Int(100 + arc4random() % 100),
            ]
        })
        print("armand p:", JTJsonTrans(arg))
        webView.callHandler("setupChart",arguments: [arg])
    }

}
