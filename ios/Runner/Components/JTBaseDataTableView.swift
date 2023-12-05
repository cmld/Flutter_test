//
//  JTBaseDataTableView.swift
//  JtStation-Indonesia-iOS
//
//  Created by Neil on 2023/12/1.
//  Copyright © 2023 Shine. All rights reserved.
//

import UIKit
import HandyJSON

class JTBaseDataTableViewCell<D: HandyJSON>: UITableViewCell {
    var cellModel: D?
    func setContent(model: D) {}
}

class JTBaseDataTableView<D: HandyJSON, T: JTBaseDataTableViewCell<D>>: UITableView, UITableViewDelegate, UITableViewDataSource {
    var cellID: String = "" {
        didSet {
            self.register(T.classForCoder(), forCellReuseIdentifier: cellID)
        }
    }
    
    var actionHander:((_: T)->Void) = {_ in}
    
    var cellSelected:((_: T, _: IndexPath)->Void) = {_, _ in}
    
    var dataList: [D] = [] {
        didSet {
            self.reloadData()
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.estimatedRowHeight = UITableView.automaticDimension
        self.sectionHeaderHeight = 10
        self.sectionFooterHeight = 1
        self.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        
        self.delegate = self
        self.dataSource = self
        self.rowHeight = UITableView.automaticDimension
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? T {
            let model = dataList[indexPath.row]
            cell.setContent(model: model)
            actionHander(cell)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? T {
            cellSelected(cell, indexPath)
        }
    }
}
