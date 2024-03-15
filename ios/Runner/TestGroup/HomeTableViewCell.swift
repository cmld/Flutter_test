//
//  HomeTableViewCell.swift
//  Runner
//
//  Created by yl on 2024/3/11.
//

import UIKit

class HomeTableViewCell: JTBaseDataTableViewCell {

    lazy var contnetLb: UILabel = {
        let value = UILabel()
        value.textColor = .black
        value.font = UIFont.systemFont(ofSize: 16)
        return value
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 10
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        contentView.addSubview(contnetLb)
        contnetLb.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
            make.height.equalTo(35)
        }
    }
    
    override func setContent(model: D) {
        guard let instance = model as? JTBalanceModel else {
            return
        }
        contnetLb.text = instance.title
    }
    
}
