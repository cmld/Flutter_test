//
//  RecipientNormalCell.swift
//  Runner
//
//  Created by yl on 2024/1/31.
//

import UIKit
// 普通件 + MS件
class RecipientNormalCell: JTBaseDataTableViewCell {
    @IBOutlet weak var autoDecodeV: AutoDecodeReceivingView!
    @IBOutlet weak var nameV: CustomInputView!
    @IBOutlet weak var phoneV: CustomInputView!
    @IBOutlet weak var postCodeV: CustomInputView!
    @IBOutlet weak var areaV: CustomInputView!
    @IBOutlet weak var addressTypeV: UIView!
    @IBOutlet weak var detailAddressV: CustomTextView!
    
    lazy var addressTypeOptionCV: JTBaseDataCollectionView<OptionCollectionViewCell> = {
        let flowlayout = UICollectionViewLeftFlowLayout.init()
        flowlayout.scrollDirection = .vertical
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowlayout.minimumLineSpacing = 15
        flowlayout.minimumInteritemSpacing = 15
        
        let value = JTBaseDataCollectionView<OptionCollectionViewCell>.init(frame: .zero, collectionViewLayout: flowlayout)
        value.cellID = "OptionCollectionViewCellID"
        return value
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupUI()
    }
    
    func setupUI(){
        
        areaV.titleLb.text = "州/城市/区域-r".localized
        areaV.textF.placeholder = "请选择州/城市/区域-r".localized
        areaV.setupConten(isRequired: true, showSwitch: false, prefixStr: "", optionImgName: "addShelf")
        
        nameV.titleLb.text = "姓名-r".localized
        nameV.textF.placeholder = "请输入-r".localized
        nameV.setupConten(isRequired: true, showSwitch: false, prefixStr: "", optionImgName: "addShelf")
        
        phoneV.titleLb.text = "电话-r".localized
        phoneV.textF.placeholder = "请输入-r".localized
        phoneV.setupConten(isRequired: true, showSwitch: false, prefixStr: "+60", optionImgName: "addShelf")
        
        postCodeV.titleLb.text = "收件邮编-r".localized
        postCodeV.textF.placeholder = "请输入-r".localized
        postCodeV.setupConten(isRequired: true, showSwitch: false, prefixStr: "", optionImgName: "addShelf")
        
        addressTypeOptionCV.dataList = ["家-r".localized, "公司-r".localized, "学校-r".localized].map({ item in
            let model = JTBalanceModel()
            model.title = item
            return model
        })
        addressTypeOptionCV.setupCell = {cell, idx in
            let width = (kScreenWidth - 30 - 30) / 3
            cell.titleV.snp.updateConstraints { make in
                make.width.equalTo(width - 10)
            }
        }
        addressTypeV.addSubview(addressTypeOptionCV)
        addressTypeOptionCV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
