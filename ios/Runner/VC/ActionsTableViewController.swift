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

}
