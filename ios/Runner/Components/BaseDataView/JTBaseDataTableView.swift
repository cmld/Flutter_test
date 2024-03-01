//
//  JTBaseDataTableView.swift
//  JtStation-Indonesia-iOS
//
//  Created by Neil on 2023/12/1.
//  Copyright © 2023 Shine. All rights reserved.
//

import UIKit
import HandyJSON

class JTBaseDataTableViewCell: UITableViewCell {
    typealias D = HandyJSON
    var cellModel: D?
    func setContent(model: D) {}
}

class JTBaseDataTableView<T: JTBaseDataTableViewCell>: UITableView, UITableViewDelegate, UITableViewDataSource {
    var cellID: String = "" {
        didSet {
            if cellID.contains("Nib") {
                self.register(UINib(nibName: "\(T.classForCoder())", bundle: nil), forCellReuseIdentifier: cellID)
            } else {
                self.register(T.classForCoder(), forCellReuseIdentifier: cellID)
            }
        }
    }
    
    var setupCell:((_: T, _: IndexPath)->Void) = {_, _ in}
    
    var cellSelected:((_: T, _: IndexPath)->Void) = {_, _ in}
    
    var dataList: [T.D] = [] {
        didSet {
            self.reloadData()
            self.layoutIfNeeded()
            self.setEmptyView(isEmpty: dataList.count <= 0)
        }
    }
    
    var emptyView: UIView?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.sectionHeaderHeight = 0.1
        self.sectionFooterHeight = 0.1
        self.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEmptyView(isEmpty: Bool){
        guard let ev = emptyView else { return }
        if isEmpty {
            if ev.superview == nil {
                ev.frame = self.bounds
                self.addSubview(ev)
            }
        }else{
            if ev.superview != nil {
                ev.removeFromSuperview()
            }
        }
    }
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? T {
            let model = dataList[indexPath.row]
            cell.cellModel = model
            cell.setContent(model: model)
            setupCell(cell, indexPath)
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
