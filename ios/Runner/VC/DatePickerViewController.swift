//
//  DatePickerViewController.swift
//  Runner
//
//  Created by yl on 2024/3/15.
//

import UIKit
import SwiftDate

class DatePickerViewController: BaseViewController {
    
    lazy var picker: CMDatePickerView = {
        let value = CMDatePickerView(startD: Date() - 6.days, endD: Date(), minLimit: Date() - 6.months, maxLimit: Date(), mode: .date)
        
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews([picker])
        picker.snp.makeConstraints { make in
            make.centerY.left.right.equalToSuperview().inset(15)
        }
    }
    

}
