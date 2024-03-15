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
        let value = CMDatePickerView(startD: Date() - 6.days, endD: Date(), formatStr: "YYYY-MM-dd", color: UIColor.red)
        value.minLimit = Date() - 6.months
        value.maxLimit = Date()
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
