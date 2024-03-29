//
//  TableViewController.swift
//  Runner
//
//  Created by yl on 2024/1/29.
//

import UIKit

class TableViewController: BaseViewController {
    
//    lazy var tableV: JTBaseDataTableView<GoodsInfoMSCell> = {
//        let value = JTBaseDataTableView<GoodsInfoMSCell>()
//        value.cellID = "RecipientInternCellNibID"
//        return value
//    }()
    lazy var tableV: JTBaseDataTableView<OrderListNewCell> = {
        let value = JTBaseDataTableView<OrderListNewCell>()
        value.cellID = "RecipientInternCellNibID"
//        value.backgroundColor = .lightGray
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableV)
        tableV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableV.dataList = [JTBalanceModel(), JTBalanceModel(), ]
    }

}
