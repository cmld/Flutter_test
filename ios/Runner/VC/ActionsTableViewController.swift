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
        
        let actions: [String] = ["弹出视图", "模态弹出"]
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
                case 1:
                    let vc = ToolsViewController()
                    self.present(vc, animated: true)
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
        
        CMPopupView().showWithConfig(filteringV, config: CMPopupConfig(position: .top, yTopGap: 100, yDownGap: 0))
    }

}
