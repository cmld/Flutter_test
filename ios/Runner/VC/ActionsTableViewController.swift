//
//  ActionsTableViewController.swift
//  Runner
//
//  Created by yl on 2024/2/27.
//

import UIKit

class ActionsTableViewController: BaseViewController {
    lazy var myTableV: JTBaseDataTableView<JTNoticeCell> = {
        let value = JTBaseDataTableView<JTNoticeCell>()
        value.cellID = "myTableVID"
        value.layer.borderWidth = 2
        value.layer.borderColor = UIColor.lightGray.cgColor
        value.separatorStyle = .none
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTableV)
        myTableV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let actions: [String] = ["弹出视图"]
        myTableV.dataList = actions.map { item in
            let model = JTBalanceModel()
            model.title = item
            return model
        }
        myTableV.cellSelected = { [weak self] cell, idx in
            guard let `self` = self else { return }
            
            switch idx.row {
                case 0:
                    showPopupV()
                default:
                    break
            }
            
        }
    }
    
    func showPopupV(){
        let testV = UIView()
        testV.backgroundColor = .green
        testV.snp.makeConstraints { make in
            make.width.height.equalTo(200)
        }
        
        let popupV = CMPopupView()
        popupV.showWithConfig(testV, config: CMPopupConfig(position: .top, yTopGap: 300, yDownGap: 0))
    }

}
