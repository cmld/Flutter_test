//
//  HomeListViewController.swift
//  Runner
//
//  Created by yl on 2023/12/14.
//

import UIKit

class HomeListViewController: UIViewController {
    
    lazy var tableView: JTBaseDataTableView<JTBalanceModel, JTNoticeCell> = {
        let value = JTBaseDataTableView<JTBalanceModel, JTNoticeCell>()
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
        
        tableView.dataList.insert(contentsOf: ["Main", "Oss", "ImagePicker", "AddWater", "面单"].map({ item in
            let model = JTBalanceModel()
            model.title = item
            return model
        }), at: 0)
        
        tableView.cellSelected = {[weak self] cell, idx in
            var vc: UIViewController!
            switch idx.row {
                case 0:
                    vc = MainViewController()
                case 1:
                    vc = OSSViewController()
                case 2:
                    vc = ImagePickerViewController()
                case 3:
                    vc = AddWaterViewController()
                case 4:
                    vc = ModeViewController()
                    
                default:
                    vc = MainViewController()
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.cellSelected(JTNoticeCell(), IndexPath(row: 4, section: 0))
    }
    
}
