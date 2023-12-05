//
//  ViewController.swift
//  JTOSSUploader-iOS
//
//  Created by armand.chen on 11/03/2023.
//  Copyright (c) 2023 armand.chen. All rights reserved.
//

import UIKit
import JTOSSUploader_iOS
import Alamofire
import SnapKit

class OSSViewController: UIViewController {
    var imgList: [String] = []
    
    var resultDic: [String: String] = [:]
    
    let headers = ["app-version": "1.0.43",
                   "app-platform": "iOS_com.jitu.express.malaysia.outfield",
                   "device-id": "WCI3822FB18-D524-4ED5-9CF1-4014A762BEBF",
                   "device-name": "iPhone 8 Plus",
                   "device-version": "iOS-13.7",
                   "user-agent": "ios/app_out",
                   "app-channel": "Internal Deliver",
                   "device": "WCI3822FB18-D524-4ED5-9CF1-4014A762BEBF",
                   "devicefrom": "ios",
                   "appid": "g0exxal082vu",
                   "langType": "CN",
                   "content-type": "application/json; charset=utf-8",
                   "timestamp": "1699501049743",
                   "signature": "QUFEM0Y0REM5NkIzMzQ2QkM4MkFGRjQ5M0E5MkNBNTc=",
                   "userCode": "NSN6100008",
                   "authToken": "d02520f987744309a89b46d98408922c",
                   "X-SimplyPost-Id": "1699501049743",
                   "X-SimplyPost-Signature": "7b9268c0386e0302badb23d931c7c7cc",
                   "contentType": "application/json; charset=utf-8",
                   "responseType": "ResponseType.json",
                   "followRedirects": "true",
                   "connectTimeout": "10000",
                   "receiveTimeout": "10000",]
    
    lazy var footV: testView = {
        let value = testView()
        value.backgroundColor = .blue
        return value
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.gray
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        tableView.rowHeight = 100
        tableView.sectionFooterHeight = 0.1
        tableView.register(UINib(nibName: "JTTableViewCell", bundle: nil), forCellReuseIdentifier: "JTTableViewCellID")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.tableFooterView = footV
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - 100, y: UIScreen.main.bounds.maxY - 100, width: 100, height: 100))
        button.backgroundColor = .red
        button.setTitle("选图", for: .normal)
        button.addTarget(self, action: #selector(pushToImagePicker), for: .touchUpInside)
        self.view.addSubview(button)
        
        let button1 = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - 300, y: UIScreen.main.bounds.maxY - 100, width: 100, height: 100))
        button1.backgroundColor = .blue
        button1.setTitle("upload2Oss", for: .normal)
        button1.addTarget(self, action: #selector(pushToImagePicker1), for: .touchUpInside)
        self.view.addSubview(button1)
        
        let bgView = UIScrollView(frame: CGRect(x: 20, y: 94, width: 350, height: 500))
        bgView.backgroundColor = .purple
        
        bgView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        bgView.addSubview(footV)
        self.view.addSubview(bgView)
        footV.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        footV.translatesAutoresizingMaskIntoConstraints = false
        bgView.contentSize = CGSize(width: tableView.bounds.size.width, height: tableView.bounds.size.height + footV.bounds.size.height)
        
//        self.view.addSubview(tableView)
        
    }
    
    @objc func pushToImagePicker()  {
        let imgPickerVC = UIImagePickerController()
        imgPickerVC.delegate = self
        self.present(imgPickerVC, animated: true)
    }
    
    @objc func pushToImagePicker1()  {
        
        let requestUrl = "https://demo-ylapp.jtexpress.my/bc/upload/file/getBatchUploadSignedUrl"
        
        JTOssHelper.shared.config = OssConfig(isShowLog: true)
        JTOssHelper.shared.uploadWithOss(requestUrl, headersDic: headers, fileList: imgList, moduleName: "scan_return_sign") {[weak self] showList in
            print("获取到的oss可访问列表：\(showList)")
            self?.resultDic = showList
            self?.tableView.reloadData()
        }
    }
    
    func pushToImagePicker2(keyUrl: String, call:@escaping (UIImage)->Void)  {
        let url = "https://demo-ylapp.jtexpress.my/bc/oss/common/getDownloadSignedUrl?path=" + keyUrl
        if let downUrl = URL(string: url) {
            AF.request(downUrl, headers: HTTPHeaders(headers)).responseDecodable(queue: DispatchQueue.global()){ (resp: AFDataResponse<responseModel<String>>) in
                switch resp.result {
                    case .success(let data):
                        if let imgUrl = URL(string: data.data ?? ""), let imgData = try? Data(contentsOf: imgUrl), let img = UIImage(data: imgData) {
                            Dispatch.DispatchQueue.main.async {
                                call(img)
                            }
                        }
                        break
                    case .failure(_):
                        break
                }
            }
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension OSSViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let origianalImage = info[.originalImage] as? UIImage else {
            return
        }
         print("\(Date()) || " + "图片宽高: \(origianalImage.size) 大小:\((origianalImage.jpegData(compressionQuality: 1)?.count ?? 0) / 1024) kb")
         
         // 创建文件
         ///let filePath = FileManager.createDirectory(jt_image_cach_path)
         ///if !FileManager.default.fileExists(atPath: path) {
         let filePath = NSHomeDirectory() + "/Library/Application Support"
         print("文件夹名|| \(filePath)")
         do{
             try FileManager.default.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
         } catch{
             print("文件创建失败")
             return
         }
         
         // 文件名称
         let timeFormatter = DateFormatter()
         timeFormatter.timeZone = TimeZone.current
         timeFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss-SSS"
         timeFormatter.locale = Locale(identifier: "en")
         let mediaName = timeFormatter.string(from: Date()) + ".jpg"
         
         // 输出地址
         let outputURL = URL(fileURLWithPath: filePath).appendingPathComponent(mediaName)
         print("文件存储地址|| \(outputURL.relativePath)")
         do {
             let imgdata = origianalImage.jpegData(compressionQuality: 0.6)
             try imgdata?.write(to: outputURL)
             
             imgList.append(outputURL.relativePath)
             tableView.reloadData()
             tableView.snp.updateConstraints { make in
                 make.height.equalTo(imgList.count * 100)
             }
         }catch _{}
         
        picker.dismiss(animated: true)
    }
}


extension OSSViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "JTTableViewCellID") as? JTTableViewCell {
            cell.titleLB.text = imgList[indexPath.row]
            if let imgUrl = resultDic[imgList[indexPath.row]] {
                pushToImagePicker2(keyUrl: imgUrl) { img in
                    cell.ossImageV.image = img
                }
            }else {
                cell.ossImageV.image = nil
            }
            return cell
        }
        return UITableViewCell()
    }
    
}

struct responseModel<T: Codable>: Codable {
    var code: Int = 1
    var msg = ""
    var succ: Bool = false
    var fail: Bool = false
    var data: T? = nil
}


class testView: UIView {
    
    lazy var firstV: UIView = {
        let value = UIView()
        value.backgroundColor = .yellow
        return value
    }()
    
    lazy var secendV: UIView = {
        let value = UIView()
        value.backgroundColor = .red
        return value
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    var ish = false
    
    func setupUI() {
        addSubview(firstV)
        addSubview(secendV)
        
        let bui = UIButton(frame: CGRectMake(0, 0, 50, 50))
        bui.backgroundColor = .brown
        firstV.addSubview(bui)
        bui.addTarget(self, action: #selector(lskdj), for: .touchUpInside)
        
        firstV.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(350)
        }
        
        secendV.snp.makeConstraints { make in
            make.top.equalTo(firstV.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(350)
            make.bottom.equalToSuperview()
        }
        
    }
    
    @objc func lskdj(sender: UIButton){
        ish = !ish
        firstV.snp.updateConstraints { make in
            make.height.equalTo(ish ? 100 : 350)
        }
        UIView.animate(withDuration: 0.2) {[weak self]in
            self?.layoutIfNeeded()
        }
    }
}
