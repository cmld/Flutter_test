//
//  ModeViewController.swift
//  Runner
//
//  Created by yl on 2023/12/14.
//

import UIKit
import dsBridge

class ModeViewController: BaseViewController {
    
    lazy var scrollV: UIScrollView = {
        let value = UIScrollView()
        
        return value
    }()
    
    lazy var webView: DWKWebView = {
        let value = DWKWebView()
        let bridgeApi = BridgeApi()
        bridgeApi.webV = value
        value.addJavascriptObject(bridgeApi, namespace: nil)
        value.layer.borderWidth = 1
        value.layer.borderColor = UIColor.red.cgColor
        return value
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        self.title = "面单"
        
        creatUI()
        
        webView.loadUrl("http://10.66.103.46:8887/idnStation.html")
        
    }
    
    func creatUI() {
        scrollV.addSubview(webView)
        let width = 300
        webView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width)
            make.height.equalTo(width * 2)
        }
        
        let imgV = UIImageView()
        scrollV.addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width)
            make.height.equalTo(width * 2)
        }
        
        let reloadBtn = UIButton()
        reloadBtn.setTitle("reload", for: .normal)
        reloadBtn.backgroundColor = .red
        scrollV.addSubview(reloadBtn)
        reloadBtn.snp.makeConstraints { make in
            make.top.equalTo(webView)
            make.left.equalTo(webView.snp.right).offset(10)
            make.width.height.equalTo(100)
        }
        reloadBtn.addTap { [weak self] in
            guard let `self` = self else { return }
            webView.reload()
            
        }
        
        let reloadBtn1 = UIButton()
        reloadBtn1.setTitle("setData", for: .normal)
        reloadBtn1.backgroundColor = .red
        scrollV.addSubview(reloadBtn1)
        reloadBtn1.snp.makeConstraints { make in
            make.top.equalTo(reloadBtn.snp.bottom).offset(20)
            make.left.equalTo(webView.snp.right).offset(10)
            make.width.height.equalTo(100)
        }
        
        reloadBtn1.addTap { [weak self] in
            guard let `self` = self else { return }
            let test = [
                "totalCharge": 1111,
                "companyAddress": "JALANJALANANANNANANANANANNANAN",
                "remark": "",
                "waybillCode": "JD9000490567",
                "id": 8431,
                "sixCode": "",
                "companyName": "MANGGIS ALPUKAT PISANG SIRSAK MANGGIS ALPUKAT PISANG SIRSAK MANGGIS ALPUKAT PISANG SIRSAK MANGGIS ALPUKAT PISANG SIRSAK MANGGIS ALPUKAT PISANG SIRSAK MANGGIS ALPUKAT PISANG SIRSAK MANGGIS ALPUKAT PISANG SIRSAK MANGGIS ALPUKAT PISANG SIRSAK MANGGIS ALPUKAT PISANG SIRSAK MANGGIS ALPUKAT PISANG SIRSAK0",
                "signatureTime": "",
                "recipientArea": "KALIDERES",
                "recipientCity": "JAKARTA",
                "serviceTypeCode": "EZ",
                "recipient": "testshoujian",
                "senderCity": "KUTACANE",
                "printTimeStr": "10-01-2025",
                "customerWaybillNo": "",
                "recipientDetailAddr": "yehhdbxbb",
                "goodsType": "BARANG",
                "recipientProvince": "DKI JAKARTA",
                "goodsName": "硬件",
                "senderDetailAddr": "斑斑驳驳呢",
                "payTypeStr": "TUNAI",
                "payType": ["code": "0",
                            "name": "寄付",
                            "id": "PP_CASH"],
                "recipientPhone": "628946646465",
                "weight": "1.00",
                "senderPhone": "6280656599595",
                "printTime": "2025-01-10 12:55:56",
                "signatureTimeStr": "",
                "numberPieces": 1,
                "senderProvince": "NANGGROE ACEH DARUSSALAM",
                "threeCode": "JKT-JKT02A",
                "isCod": ["code": "1",
                          "id": "NO",
                          "name": "否"],
                "codMoney": 0,
                "serviceTypeName": "EZ",
                "orderNo": "1745536704967054346",
                "companyDutyParagraph": "12345678587458",
                "sender": "testjj"
            ]
            
            
            
            webView.callHandler("setContent", arguments: [test], completionHandler: {[weak self] value in
                guard let `self` = self else { return }
                print("armand p:", test)
                webView.takeSnapshot(with: WKSnapshotConfiguration()) { img, error in
                    print(img?.size)
                }
            })
            
//            JTPrintManager.share.getImgWith(test) { img in
//                print(img?.size)
//                imgV.image = img
//            }
        }
        
//        let content = JTReturnModeView(frame: CGRect(x: 10, y: 100, width: 304, height: 400))
//        let content = JTHandoverModeView(frame: CGRect(x: 10, y: 100, width: 304, height: 400))
        let content = JTSendSecondModeView(frame: CGRect(x: 10, y: 800, width: 304, height: 200))
        content.setContent()
        scrollV.addSubview(content)
        content.snp.makeConstraints { make in
            make.top.equalTo(imgV.snp.bottom).offset(20)
            make.left.equalTo(10)
            make.width.equalTo(304)
            make.height.equalTo(200)
            make.bottom.equalToSuperview().inset(20)
        }
        
        view.addSubview(scrollV)
        scrollV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
