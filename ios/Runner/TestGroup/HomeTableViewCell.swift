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
    
    lazy var descLb: UILabel = {
        let value = UILabel()
        value.textColor = .lightGray
        value.font = UIFont.systemFont(ofSize: 14)
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
        contentView.addSubview(descLb)
        contnetLb.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
        }
        
        descLb.snp.makeConstraints { make in
            make.top.equalTo(contnetLb.snp.bottom).offset(5)
            make.bottom.left.right.equalToSuperview().inset(10)
        }
    }
    
    override func setContent(model: D) {
        guard let instance = model as? JTBalanceModel else {
            return
        }
        let items = instance.title?.components(separatedBy: ",")
        contnetLb.text = items?.first
        descLb.text = items?.last
    }
    
}
