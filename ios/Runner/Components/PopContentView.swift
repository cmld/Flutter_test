//
//  PopContentView.swift
//  JtStation-Indonesia-iOS
//
//  Created by yl on 2024/9/27.
//  Copyright © 2024 Shine. All rights reserved.
//

import Foundation
import UIKit

class PopContentView: UIView {
    lazy var titleLb: UILabel = {
        let value = UILabel()
        value.textColor =  UIColor(hex: "#3C3C3C")
        value.textAlignment = .center
        value.font = .systemFont(ofSize: 17)
        return value
    }()
    
    var contentV: UIView = UIView()
    
    lazy var leftBtn: UIButton = {
        let value = UIButton()
        value.setTitleColor(UIColor(hex: "#3C3C3C"), for: .normal)
        value.layer.borderWidth = 1
        value.layer.borderColor = UIColor(hex: "#DCDEE1").cgColor
        value.titleLabel?.font = .systemFont(ofSize: 16)
        return value
    }()
    lazy var rightBtn: UIButton = {
        let value = UIButton()
        value.setTitleColor(UIColor(hex: "#3C3C3C"), for: .normal)
        value.layer.borderWidth = 1
        value.layer.borderColor = UIColor(hex: "#DCDEE1").cgColor
        value.titleLabel?.font = .systemFont(ofSize: 16)
        return value
    }()
    
    var leftTitle = "cancel".localized
    var rightTitle = "OK".localized
    
    init(_ content: UIView, leftTitle: String = "", rightTitle: String = "OK".localized) {
        super.init(frame: .zero)
        contentV = content
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        createCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCellUI()
    }
    
    func createCellUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        
        leftBtn.setTitle(leftTitle, for: .normal)
        rightBtn.setTitle(rightTitle, for: .normal)
        
        addSubviews([titleLb, contentV, leftBtn, rightBtn])
        titleLb.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(20)
        }
        contentV.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        leftBtn.snp.makeConstraints { make in
            make.top.equalTo(contentV.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(-1)
            make.bottom.equalToSuperview().offset(1)
            make.height.equalTo(46)
            make.width.equalToSuperview().multipliedBy(leftTitle.isEmpty ? 0 : 0.5)
        }
        rightBtn.snp.makeConstraints { make in
            make.top.equalTo(contentV.snp.bottom).offset(10)
            make.left.equalTo(leftBtn.snp.right).offset(-1)
            make.right.bottom.equalToSuperview().offset(1)
            make.height.equalTo(46)
        }
    }
}
