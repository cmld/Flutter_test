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
        
        let actions: [String] = ["弹出视图", 
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
                                 "模态弹出",
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
                    showPopupV()
                case 1:
                    let vc = ToolsViewController()
                    self.present(vc, animated: true)
                case 2:
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
                CMPopupView().showWithConfig(filteringV, config: CMPopupConfig(position: .down, yTopGap: 0, yDownGap: 200))
            case 2:
                CMPopupView().showWithConfig(filteringV, config: CMPopupConfig(position: .center, yTopGap: 100, yDownGap: 100))
            default:
                break
        }
        
    }

}
