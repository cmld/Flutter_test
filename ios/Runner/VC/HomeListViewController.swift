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
            "ToolsViewController, Tools",
            "MyScrollViewController, tableView + collectionView",
            "PDFViewController, PDF",
            "TableViewController, tableView",
            "ActionsTableViewController, ActionsTableView",
            "DatePickerViewController, DatePickerViewController",
        ]
        
        tableView.dataList = dataSourceList.reversed().map({ item in
            let model = JTBalanceModel()
            model.title = item
            return model
        })
        
        tableView.cellSelected = {[weak self] cell, idx in
            guard let `self` = self else { return }
            
            if let classStr = dataSourceList.reversed()[idx.row].components(separatedBy: ",").first {
                guard let vclass = NSClassFromString("Runner."+classStr) as? UIViewController.Type else {
                    return
                }
                let vc = vclass.init()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        tableView.cellSelected(HomeTableViewCell(), IndexPath(row: 0, section: 0))
    }
    
}
