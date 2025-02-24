//
//  ActionsTableViewController.swift
//  Runner
//
//  Created by yl on 2024/2/27.
//

import UIKit

class ActionsTableViewController: BaseViewController {
    lazy var myTableV: JTBaseDataTableView<HomeTableViewCell> = {
        let value = JTBaseDataTableView<HomeTableViewCell>()
        value.cellID = "myTableVID"
        value.separatorStyle = .none
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTableV)
        myTableV.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        let actions: [String] = [
                                 "模态弹出",
                                 "弹出视图1",
                                 "弹出视图2",
                                 "弹出视图3",
                                 "date 操作",
                                 "BloomFilter",
                                 "model trans",
                                 "阿里 DNS -data",
                                 "阿里 DNS",
                                 "获取代理ip端口",
                                 "ping URL",
        ]
        
        myTableV.dataList = actions.map { item in
            let model = JTBalanceModel()
            model.title = item
            return model
        }
        myTableV.cellSelected = { [weak self] cell, idx in
            guard let `self` = self, let model = cell.cellModel as? JTBalanceModel else { return }
            
            switch idx.row {
                case 0:
                    let vc = ToolsViewController()
                    self.present(vc, animated: true)
                case 4:
                    getBanner()
                case 5:
                    print("armand p: 1", Date().toFormat("YYYY-MM-dd HH:mm:ss:SSS"))
                    let bloomFilter = BloomFilter(size: 239626460, hashFunctionsCount: 17)
                    print("armand p: 2", Date().toFormat("YYYY-MM-dd HH:mm:ss:SSS"))
                    for i in (0..<10000) {
                        bloomFilter.add("slkjfsfadfadfafdsa" + i.description)
                    }
                    print("armand p: 3", Date().toFormat("YYYY-MM-dd HH:mm:ss:SSS"))
                    let dd = bloomFilter.contains("slkjfsfadfadfafdsa01")
                    print("armand p: 4 \(dd)", Date().toFormat("YYYY-MM-dd HH:mm:ss:SSS"))
                case 6:
                    let temp = JTStoreCertificationDetailUserModel()
                    print(temp.toJSONString(prettyPrint: true) ?? "")
                case 7:
                    DNSResolver.share().getIpv4Data(withDomain: "bc.jtexpress.my") { ipList in
                        print("armand p:", ipList)
                    }
                    break
                case 8:
                    DNSResolver.share().getIpv4Info(withDomain: "bc.jtexpress.my") { ipList in
                        print("armand p:", ipList)
                    }
                    break
                case 9:
                    getProxyIPAddress { ip, error in
                        if let error = error {
                            print("Error: \(error)")
                        } else if let ip = ip {
                            print("Proxy IP Address: \(ip)")
                        }
                    }
                    getProxy()
                    break
                case 10: // ping URL
                    if let url = URL(string: "http://10.66.103.54:8887/idnStation.html") {
                        let startTime = Date()
                        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, resp, err in
                            if let resultResp = resp as? HTTPURLResponse, resultResp.statusCode == 200, err == nil {
                                let duration = Date().timeIntervalSince(startTime) * 1000
                                print("duration:\(duration) ms")
                            }
                        }.resume()
                    }
                    break
                default:
                    showPopupV(idx.row % 3)
                    break
            }
            
        }
    }
    
    func showPopupV(_ isdown: Int = 0){
        let testV = UIView()
        testV.backgroundColor = .green
        testV.snp.makeConstraints { make in
            make.width.height.equalTo(200)
        }
        
        let optV = OptionsView(["附件上传", "编辑", "取消"])
        optV.actionCall = {[weak self] index in
            guard let `self` = self else { return }
            print("点击了 \(index)")
        }
        
        
        testV.addSubview(optV)
        optV.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        let filteringV = OrderFilteringView()
        filteringV.snp.makeConstraints { make in
            make.width.equalTo(SCREEN_WIDTH)
        }
        switch isdown {
            case 0:
                CMPopupView().showWithConfig(filteringV, config: CMPopupConfig(position: .top, yTopGap: 200, yDownGap: 0))
            case 1:
                CMPopupView().showWithConfig(filteringV, config: CMPopupConfig(position: .down, yTopGap: 0, yDownGap: 0))
            case 2:
                CMPopupView().showWithConfig(filteringV, config: CMPopupConfig(position: .center, yTopGap: 100, yDownGap: 100))
            default:
                break
        }
        
    }
    
    func getBanner() {
        let startDate = Calendar.current.startOfDay(for: Date())
        var popDates = ""
        if let temp = UserDefaults.standard.value(forKey: "BannerPopDates") as? String {
            popDates = temp
        }
        var dates: [String] = []
        if !popDates.isEmpty {
            dates = popDates.split(separator: ",")
                    .map({String($0)})
                    .filter({$0.toDate("YYYY-MM-dd HH:mm:ss:SSS")?.date.isAfterDate(startDate, granularity: .nanosecond) ?? false})
        }
        if let lastDate = dates.last?.toDate("YYYY-MM-dd HH:mm:ss:SSS")?.date, Date().timeIntervalSince(lastDate) > 7200, dates.count < 5 {
            dates.append(Date().toFormat("YYYY-MM-dd HH:mm:ss:SSS"))
            popDates = dates.joined(separator: ",")
            UserDefaults.standard.set(popDates, forKey: "BannerPopDates")
            // TODO: Armand 开始请求
        }
    }
    
    func getProxyIPAddress(completion: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: "https://api.ipify.org?format=json") else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []),
                  let dictionary = json as? [String: Any],
                  let ipAddress = dictionary["ip"] as? String else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse IP address"]))
                return
            }

            completion(ipAddress, nil)
        }.resume()
    }
    
    func getProxy() -> String {
        var reslut = ""
        if let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue(), let dic = proxy as? [String: Any] {
            if let httpsProxy = dic["HTTPSProxy"] as? String {
                reslut = httpsProxy
            }
            if let httpsPort = dic["HTTPSPort"] as? Int64 {
                reslut = reslut + ":\(httpsPort)"
            }
        }
        print("armand p: Proxy->", reslut)
        return reslut
    }

}
