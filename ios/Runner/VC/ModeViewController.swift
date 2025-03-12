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
        
//        webView.loadUrl("http://10.66.103.54:8887/modeView76100.html")
        if let url = Bundle.main.url(forResource: "modeView76100", withExtension: "html"), let data = try? Data(contentsOf: url) {
            
//            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            webView.load(data, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        }
        
    }
    
    func creatUI() {
        scrollV.addSubview(webView)
        let width = 300
        let height = 428.6
        webView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        let imgV = UIImageView()
        scrollV.addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width)
            make.height.equalTo(height)
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
                "recipientDetailAddr": "testt",
                "senderDetailAddr": "test",
                "senderCity": "เขตบางนา",
                "goodsType": "0",
                "billingWeight": "1",
                "recipientTown": "พรหมณี",
                "senderPostalCode": "10260",
                "tiktokLogo": "true",
                "goodsLength": "24",
                "codMoney": "0",
                "goodsHeight": "0",
                "orderNo": "25030509296482",
                "expressCompanyName": "J&T Express",
                "website": "www.jtexpress.co.th",
                "recipientCity": "เมืองนครนายก",
                "recipientRedion": "พรหมณี เมืองนครนายก นครนายก 26000",
                "volumeWeight": "0",
                "ref1": "EZ",
                "senderRedion": "บางนา เขตบางนา กรุงเทพมหานคร 10260",
                "weight": "1",
                "printTime": "2025-03-05 09:29:20",
                "companyType": "0",
                "printTypeText": "已打印",
                "senderTown": "บางนา",
                "remoteFee": "0.00",
                "expressCompanyIcon": "https:\\/\\/uat-jmsth-file-public-1304629426.cos.ap-bangkok.myqcloud.com\\/tmp\\/jmsth-home-uat\\/eade29c2-50e7-4d82-ad40-3eb42ce41b47jtlogo.png?q-sign-algorithm=sha1&q-ak=IKIDMdmoeGrJadVEl493mIPL7kPs7AVebLtF&q-sign-time=1722397696%3B2037678617&q-key-time=1722397696%3B2037678617&q-header-list=host&q-url-param-list=&q-signature=74db84b1178a45c0de68caed81efdfd10d6b4bf1",
                "printType": "0",
                "totalCharge": "5.50",
                "sender": "TH手机10260",
                "wayBillCode": "160006255544",
                "hotLine": "021-789655544",
                "senderProvince": "กรุงเทพมหานคร",
                "signingStatement": "ผู้รับได้ตรวจสอบใบเสร็จและความถูกต้องของพัสดุโดยเข้าใจและยอมรับเงื่อนไขการจัดส่ง ของ J&T Express",
                "recipientPostalCode": "26000",
                "sortingCode": "P1 G81-89 004B",
                "printLogo": "https:\\/\\/uat-jmsth-file-public-1304629426.cos.ap-bangkok.myqcloud.com\\/tmp\\/jmsth-home-uat\\/2023%20JT%20logo.png?q-sign-algorithm=sha1&q-ak=IKIDMdmoeGrJadVEl493mIPL7kPs7AVebLtF&q-sign-time=1701326473%3B2015994139&q-key-time=1701326473%3B2015994139&q-header-list=host&q-url-param-list=&q-signature=42a88e85d75731bd82c17a2865b9d544888eb9ad",
                "ref2": "Order No.:25030509296482",
                "recipient": "Th手机收",
                "goodsWidth": "30",
                "transportCharge": "5.50",
                "recipientProvince": "นครนายก",
                "recipientMobile": "0806122616",
                "qrCode": "https:\\/\\/lin.ee\\/PnyTJyI",
                "senderMobile": "0807065440",
                "stationName": "JT HOME Stitch",
                "printNumber": "1",
                "codNeed": "0",
                "createDate": "2025-03-05 09:29:19"
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
