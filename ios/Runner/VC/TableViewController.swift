//
//  TableViewController.swift
//  Runner
//
//  Created by yl on 2024/1/29.
//

import UIKit

class TableViewController: BaseViewController {
    

    lazy var tableV: JTBaseDataTableView<OrderListNewCell> = {
        let value = JTBaseDataTableView<OrderListNewCell>()
        value.cellID = "RecipientInternCellNibID"
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableV)
        tableV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableV.cellSelected = {[weak self] cell, idx in
            guard let `self` = self else { return }
            guard let model = cell.cellModel as? JTBalanceModel else { return }
            // cell as OrderListNewCell
            // idx as IndexPath
            
            
        }
        
        tableV.setupCell = {[weak self] cell, idx in
            guard let `self` = self else { return }
            guard let model = cell.cellModel as? JTBalanceModel else { return }
            // cell as OrderListNewCell
            // idx as IndexPath
            
        }
        
        tableV.dataList = [JTBalanceModel(), JTBalanceModel(), ]
    }

}
