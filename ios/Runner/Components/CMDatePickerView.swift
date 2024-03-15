//
//  CMDatePickerView.swift
//  Runner
//
//  Created by yl on 2024/3/13.
//

import UIKit
import SwiftDate

class CMDatePickerView: UIView {
    
    var mainColor = UIColor.black
    
    lazy var startBtn: UIButton = {
        let value = UIButton()
        value.setTitleColor(.lightGray, for: .normal)
        value.setTitleColor(mainColor, for: .selected)
        value.titleLabel?.font = .systemFont(ofSize: 14)
        value.isSelected = true
        return value
    }()
    
    lazy var startLine: UILabel = {
        let value = UILabel()
        value.backgroundColor = mainColor
        return value
    }()
    
    lazy var connector: UILabel = {
        let value = UILabel()
        value.text = "-"
        value.font = .systemFont(ofSize: 14)
        return value
    }()
    
    lazy var endBtn: UIButton = {
        let value = UIButton()
        value.setTitleColor(.lightGray, for: .normal)
        value.setTitleColor(mainColor, for: .selected)
        value.titleLabel?.font = .systemFont(ofSize: 14)
        return value
    }()
    
    lazy var endLine: UILabel = {
        let value = UILabel()
        return value
    }()
    
    fileprivate var datePicker: UIDatePicker = {
        let value = UIDatePicker()
        value.locale = Locale(identifier: "zh_CN")
//        value.locale = Locale(identifier: "id_ID")
//        value.locale = Locale(identifier: "en_US")
        return value
    }()
    
    var minLimit: Date!
    var maxLimit: Date!
    var formatStr: String!
    
    init(startD: Date, endD: Date, formatStr: String, color: UIColor = .black, mode: UIDatePicker.Mode = .date) {
        super.init(frame: .zero)
        mainColor = color
        self.formatStr = formatStr
        createCellUI()
        
        startBtn.setTitle(startD.toFormat(formatStr), for: .normal)
        endBtn.setTitle(endD.toFormat(formatStr), for: .normal)
        
        datePicker.setDate(startD, animated: false)
        datePicker.datePickerMode = .date
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCellUI()
    }
    
    func createCellUI() {
        startBtn.addSubview(startLine)
        endBtn.addSubview(endLine)
        
        addSubviews([startBtn, connector, endBtn, datePicker])
        
        startBtn.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(40)
        }
        startLine.snp.makeConstraints { make in
            make.left.right.equalTo(startBtn.titleLabel!)
            make.top.equalTo(startBtn.titleLabel!.snp.bottom).offset(5)
            make.height.equalTo(1)
        }
        
        connector.snp.makeConstraints { make in
            make.centerY.equalTo(startBtn)
            make.left.equalTo(startBtn.snp.right)
        }
        
        endBtn.snp.makeConstraints { make in
            make.centerY.height.width.equalTo(startBtn)
            make.left.equalTo(connector.snp.right)
            make.right.equalToSuperview()
        }
        endLine.snp.makeConstraints { make in
            make.left.right.equalTo(endBtn.titleLabel!)
            make.top.equalTo(endBtn.titleLabel!.snp.bottom).offset(5)
            make.height.equalTo(1)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(startBtn.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        setActions()
    }
    
    func setActions() {
        startBtn.addTap {[weak self] in
            guard let `self` = self else { return }
            startBtn.isSelected = true
            endBtn.isSelected = false
            
            startLine.backgroundColor = mainColor
            endLine.backgroundColor = .clear
            
            if let date = startBtn.titleLabel?.text?.toDate()?.date {
                datePicker.setDate(date, animated: false)
            }
        }
        endBtn.addTap {[weak self] in
            guard let `self` = self else { return }
            startBtn.isSelected = false
            endBtn.isSelected = true
            
            endLine.backgroundColor = mainColor
            startLine.backgroundColor = .clear
            
            if let date = endBtn.titleLabel?.text?.toDate()?.date {
                datePicker.setDate(date, animated: false)
            }
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        var selectedDate = sender.date
        
        var limitCheck = { [weak self]  in
            guard let `self` = self else { return }
            if selectedDate > maxLimit {
                selectedDate = maxLimit
                sender.setDate(selectedDate, animated: true)
            }
            if selectedDate < minLimit {
                selectedDate = minLimit
                sender.setDate(selectedDate, animated: true)
            }
        }
        // 执行您的回调代码
        print("Selected date: \(sender.date.description)  \(selectedDate)")
        if startBtn.isSelected {
            if let endD = endBtn.titleLabel?.text?.toDate()?.date, selectedDate > endD {
                selectedDate = endD
                sender.setDate(selectedDate, animated: true)
            } else {
                limitCheck()
            }
            startBtn.setTitle(selectedDate.toFormat(formatStr), for: .normal)
        }
        if endBtn.isSelected {
            if let startD = startBtn.titleLabel?.text?.toDate()?.date, selectedDate < startD {
                selectedDate = startD
                sender.setDate(selectedDate, animated: true)
            } else {
                limitCheck()
            }
            endBtn.setTitle(selectedDate.toFormat(formatStr), for: .normal)
        }
    }
}
