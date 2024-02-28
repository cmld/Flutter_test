//
//  OptionCollectionViewCell.swift
//  Runner
//
//  Created by yl on 2024/1/31.
//

import UIKit

class OptionCollectionViewCell: JTBaseDataCollectionCell {
    var titleV: UILabel = {
        let value = UILabel()
        value.textColor = .black
        value.font = UIFont.systemFont(ofSize: 14)
        value.textAlignment = .center
        value.backgroundColor = .white
        return value
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCellUI()
    }
    
    func createCellUI() {
        self.addBorder(color: .lightGray, radius: 4)
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        addSubview(titleV)
        
        titleV.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(5)
            make.height.equalTo(25)
            make.width.equalTo(50)
        }
    }
    
    override func setContent(model: D) {
        if let  instance = model as? JTBalanceModel {
            cellModel = instance
            titleV.text = instance.title ?? "empty"
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.lightGray.cgColor
        }
    }
}
