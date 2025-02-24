//
//  HomeListViewController.swift
//  Runner
//
//  Created by yl on 2023/12/14.
//

import UIKit

class HomeListViewController: BaseViewController {
    
    lazy var tableView: JTBaseDataTableView<HomeTableViewCell> = {
        let value = JTBaseDataTableView<HomeTableViewCell>()
        value.cellID = "JTHomeCellID"
        value.separatorStyle = .none
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            self.title = "\(appVersion)(\(buildNumber))"
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        let dataSourceList = [
            "MainViewController, Main",
            "OSSViewController, Oss",
            "ImagePickerViewController, ImagePicker",
            "AddWaterViewController, AddWater",
            "ModeViewController, 面单",
            "ToolsViewController, Tools + DesensitizationView + CustomInputView + UIStackView + AutoDecodeReceivingView",
            "MyScrollViewController, tableView + collectionView",
            "PDFViewController, PDF",
            "TableViewController, tableView",
            "ActionsTableViewController, ActionsTableView",
            "DatePickerViewController, DatePickerViewController + TextView加载html",
            "EchartsViewController, Echarts Web嵌入",
        ]
        
        tableView.dataList = dataSourceList.enumerated().map({ (index, item) in
            let model = JTBalanceModel()
            model.title = "\(index)、" + item
            return model
        })
        
        tableView.cellSelected = {[weak self] cell, idx in
            guard let `self` = self else { return }
            
            if let classStr = dataSourceList[idx.row].components(separatedBy: ",").first {
                guard let vclass = NSClassFromString("Runner."+classStr) as? UIViewController.Type else {
                    return
                }
                let vc = vclass.init()
                navigationController?.pushViewController(vc, animated: true)
                UserDefaults.standard.set(idx.row, forKey: "lastIndex")
            }
        }
        let lastIdx = UserDefaults.standard.integer(forKey: "lastIndex")
        tableView.cellSelected(HomeTableViewCell(), IndexPath(row: lastIdx, section: 0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.scrollToRow(at: IndexPath(row: tableView.dataList.count - 1, section: 0), at: .bottom, animated: false)
    }
    
}
