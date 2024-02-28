//
//  RecipientInternCell.swift
//  Runner
//
//  Created by yl on 2024/1/29.
//

import UIKit

class RecipientInternCell: JTBaseDataTableViewCell {

    @IBOutlet weak var countryV: CustomInputView!
    @IBOutlet weak var areaV: CustomInputView!
    @IBOutlet weak var nameV: CustomInputView!
    @IBOutlet weak var phoneV: CustomInputView!
    @IBOutlet weak var postCodeV: CustomInputView!
    @IBOutlet weak var addressTypeV: UIView!
    @IBOutlet weak var detailAddressV: CustomTextView!
    @IBOutlet weak var idCardV: CustomInputView!
    @IBOutlet weak var mailV: CustomInputView!
    
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
        countryV.titleLb.text = "收件国家/地区-r".localized
        countryV.textF.placeholder = "请选择收件国家/地区-r".localized
        countryV.setupConten(isRequired: true, showSwitch: false, prefixStr: "", optionImgName: "addShelf")
        
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
        addressTypeOptionCV.setupCell = {[weak self] cell, idx in
            guard let `self` = self else { return }
            let width = (kScreenWidth - 30 - 30) / 3
            cell.titleV.snp.updateConstraints { make in
                make.width.equalTo(width - 10)
            }
        }
        addressTypeV.addSubview(addressTypeOptionCV)
        addressTypeOptionCV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        idCardV.titleLb.text = "身份证/护照-r".localized
        idCardV.textF.placeholder = "请输入-r".localized
        idCardV.setupConten(isRequired: false, showSwitch: false, prefixStr: "", optionImgName: "addShelf")
        
        mailV.titleLb.text = "邮箱-r".localized
        mailV.textF.placeholder = "请输入-r".localized
        mailV.setupConten(isRequired: false, showSwitch: false, prefixStr: "", optionImgName: "addShelf")
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setContent(model: JTBaseDataTableViewCell.D) {
        
    }
}
