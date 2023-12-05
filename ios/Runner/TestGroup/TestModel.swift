//
//  TestModel.swift
//  Runner
//
//  Created by yl on 2023/12/5.
//

import Foundation
import HandyJSON

class JTBalanceModel: HandyJSON {
    var title: String?

    required init() {}
}

class JTBalanceItemCell: JTBaseDataCollectionCell<JTBalanceModel> {
    
    var titleV: UILabel = {
        let value = UILabel()
        value.textColor = .black
        value.font = UIFont.systemFont(ofSize: 14)
        
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
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        addSubview(titleV)
        titleV.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(5)
            make.height.equalTo(25)
        }
    }
    
    override func setContent(model: JTBalanceModel) {
        cellModel = model
        
        titleV.text = model.title ?? "empty"
    }
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.black.cgColor
        }
    }
}
