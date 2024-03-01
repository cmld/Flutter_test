//
//  OrderFilteringView.swift
//  Runner
//
//  Created by yl on 2024/2/28.
//

import Foundation
import UIKit

class OrderFilteringView: UIView {
    lazy var internationalTitle: UILabel = {
        let value = UILabel()
        value.font = UIFont.systemFont(ofSize: 12)
        value.textColor = UIColor(hex: "#61666D")
        value.text = "国际国内件-r".localized
        return value
    }()
    
    lazy var internationalCollectionV: JTBaseDataCollectionView<JTBalanceItemCell> = {
        let flowlayout = UICollectionViewLeftFlowLayout.init()
        flowlayout.scrollDirection = .vertical
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10
        
        let value = JTBaseDataCollectionView<JTBalanceItemCell>.init(frame: .zero, collectionViewLayout: flowlayout)
        value.cellID = "internationalCollectionVID"
        return value
    }()
    
    lazy var recipientView: CustomInputView = {
        let value = CustomInputView()
        value.setupConten(isRequired: false, showSwitch: false, prefixStr: "", optionImgName: "")
        value.titleLb.text = "收件人手机号-r".localized
        value.titleLb.textColor = UIColor(hex: "#61666D")
        value.textF.placeholder = "请输入收件人手机号-r".localized
        return value
    }()
    
    lazy var codTitle: UILabel = {
        let value = UILabel()
        value.font = UIFont.systemFont(ofSize: 12)
        value.textColor = UIColor(hex: "#61666D")
        value.text = "COD订单-r".localized
        return value
    }()
    
    lazy var codButton: UIButton = {
        let value = UIButton()
        
        value.setTitle("COD金额 >0-r".localized, for: .normal)
        value.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        value.setTitleColor(UIColor(hex: "#333333"), for: .normal)
        value.setTitleColor(UIColor(hex: "#E6262C"), for: .selected)
        
        value.setImage(UIImage(named: "addShelf"), for: .normal)
        value.setImage(UIImage(named: "home_send_set"), for: .selected)
        return value
    }()
    
    lazy var businessTypeTitle: UILabel = {
        let value = UILabel()
        value.font = UIFont.systemFont(ofSize: 12)
        value.textColor = UIColor(hex: "#61666D")
        value.text = "业务类型-r".localized
        return value
    }()
    
    lazy var businessTypeCollectionV: JTBaseDataCollectionView<JTBalanceItemCell> = {
        let flowlayout = UICollectionViewLeftFlowLayout.init()
        flowlayout.scrollDirection = .vertical
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10
        
        let value = JTBaseDataCollectionView<JTBalanceItemCell>.init(frame: .zero, collectionViewLayout: flowlayout)
        value.cellID = "businessTypeCollectionVID"
        return value
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        createCellUI()
        
        codButton.addTap { [weak self]  in
            guard let `self` = self else { return }
            codButton.isSelected = !codButton.isSelected
        }
        self.layoutIfNeeded()
        
        internationalCollectionV.dataList = ["全部", "国际", "国内"].map({ item in
            let model = JTBalanceModel()
            model.title = item
            return model
        })
        print("armand", internationalCollectionV.contentSize.height)
//        internationalCollectionV.setupCell = {cell, idx in
//            let width = (kScreenWidth - 30) / 3
//            cell.titleV.snp.updateConstraints { make in
//                make.width.equalTo(width - 10)
//            }
//        }

        businessTypeCollectionV.dataList = ["全部", "NE", "MS"].map({ item in
            let model = JTBalanceModel()
            model.title = item
            return model
        })
//        businessTypeCollectionV.setupCell = {cell, idx in
//            let width = (kScreenWidth  - 30) / 3
//            cell.titleV.snp.updateConstraints { make in
//                make.width.equalTo(width - 10)
//            }
//        }
    }
    
    func createCellUI() {
        addSubviews([internationalTitle, internationalCollectionV, recipientView, codTitle, codButton, businessTypeTitle, businessTypeCollectionV])
        
        internationalTitle.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(15)
        }
        
        internationalCollectionV.snp.makeConstraints { make in
            make.top.equalTo(internationalTitle.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(35)
        }
        
        recipientView.snp.makeConstraints { make in
            make.top.equalTo(internationalCollectionV.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
        }
        
        codTitle.snp.makeConstraints { make in
            make.top.equalTo(recipientView.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
        }
        
        codButton.snp.makeConstraints { make in
            make.top.equalTo(codTitle.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(15)
        }
        
        businessTypeTitle.snp.makeConstraints { make in
            make.top.equalTo(codButton.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
        }
        
        businessTypeCollectionV.snp.makeConstraints { make in
            make.top.equalTo(businessTypeTitle.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().inset(15)
        }
    }
}
