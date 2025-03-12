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
        value.navigationDelegate = self
        let bridgeApi = BridgeApi()
        bridgeApi.webV = value
        value.addJavascriptObject(bridgeApi, namespace: nil)
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
        
//        webLoad()
//        webView.loadUrl("http://10.66.103.46:5500/integral.html")
//        jsMethodCall()
        changeBtn.addTap { [weak self]  in
            guard let `self` = self else { return }
//            jsMethodCall()
            printHander()
        }
        reloadBtn.addTap { [weak self]  in
            guard let `self` = self else { return }
            webView.loadUrl("http://10.66.103.54:8887/idnStation.html")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                self.jsMethodCall()
//            })
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
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: DispatchWorkItem(block: {
//            let config = WKSnapshotConfiguration()
////            config.snapshotWidth = 375
//            if #available(iOS 13.0, *) {
//                config.afterScreenUpdates = true
//            } else {
//                // Fallback on earlier versions
//            }
//            self.webView.takeSnapshot(with: config) { img, error in
//                print(img?.size)
//            }
//        }))
    }
    
    func printHander() {
        let mock = [
  "waybillCode" : "JD9000433968",
  "cod" : "",
  "recipientProvince" : "DKI JAKARTA",
  "ez" : "EZ",
  "sender" : "Sender",
  "payTypeStr" : "TUNAI",
  "recipient" : "MACDONALD",
  "orderNo" : "ID25022500176443",
  "senderDetailAddr" : "XXXXXXXXXXXXXXXXXXX",
  "signatureTime" : "",
  "payType" : [
    "name" : "寄付",
    "id" : "PP_CASH",
    "code" : "0"
  ],
  "customerWaybillNo" : "",
  "totalCharge" : 750,
  "serviceTypeCode" : "EZ",
  "recipientArea" : "KALIDERES",
  "goodsType" : "BARANG",
  "senderProvince" : "DKI JAKARTA",
  "recipientDetailAddr" : "ZZZZZZZZZZZZZZZZZZZZZZ NO.8888",
  "id" : 9240,
  "weight" : "1.00",
  "np" : "NP",
  "isCod" : [
    "name" : "是",
    "id" : "YES",
    "code" : "0"
  ],
  "senderPhone" : "16666666666",
  "signatureTimeStr" : "",
  "goodsName" : "",
  "codMoney" : 0,
  "printTime" : "2025-02-25 15:41:38",
  "companyDutyParagraph" : "",
  "threeCode" : "JK5-23243",
  "fm" : "",
  "sixCode" : "23243",
  "recipientCity" : "JAKARTA",
  "printTimeStr" : "25-02-2025",
  "fourCode" : "NO . 8888",
  "recipientPhone" : "19999999999",
  "companyName" : "测试021300reeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeweewewezxXVXCVXVXVXCVXVXVXVXCVXVXVXVXVXCVXVXVVXCVXVXVXVXVXCVXVXVXCVXCVCXVXVCVXVXVCVXVXCXVXVCVXCVXVXVXVXCVXCVCXVXVXCVXVXVXCVXCVXCVNHJHKSDHKJSHDKJSHFKJSHDFJKHSJDKFHJAHFDASJHDFK",
  "remark" : "",
  "numberPieces" : 1,
  "companyAddress" : "4554454545455455SDSFSSDFSFSFSFSFSFSDFHJKFDHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHBCNBXCZMBNXCBZCZNCZXNCZNCZNCZnxc,znxC,nIOW4EUIOWQERUIJFKSNJDFJKNFMZN CMzCBNJKZHCJKHFJHFJSHFSNFFNHJMHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHBCNBXCZMBNXCBZCZNCZXNCZNCZNCZnxc,znxC,nIOW4EUIOWQERUIJFKSNJDFJKNFMZN CMzCBNJKZHCJKHFJHFJSHFSNFFNHJMBNXCBZCZNCZXNCZNCZNCZnxc,znxC,nIOW4EUIOWQERUIJFKSNJDFJKNFMZN CMzCBNJKZHCJKHFJHFJSHFSNFFNHJMHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHBCNBXCZMBNXCBZCZNCZXNCZNCZNCZnxc,znxC,nIOW4EUIOBNXCBZ",
  "senderCity" : "JAKARTA",
  "serviceTypeName" : "EZ"
] as [String : Any]
        
        webView.callHandler("setContent",arguments: [mock]) { code in
            print("armand p:", code)
        }
        
//        webView.callHandler("setupChart", arguments: ["daf"])
        
    }

}

extension EchartsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
}


class BridgeApi: NSObject {
    var webV: DWKWebView!
    
    @objc func finishedCall( _ arg:String) -> String {
        webV.takeSnapshot(with: WKSnapshotConfiguration()) { img, error in
            print(img?.size)
        }
        
        return ""
    }
}
