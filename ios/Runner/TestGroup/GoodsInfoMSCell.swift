//
//  GoodsInfoMSCell.swift
//  Runner
//
//  Created by yl on 2024/1/31.
//

import UIKit

class GoodsInfoMSCell: JTBaseDataTableViewCell {
    @IBOutlet weak var goodsTypeV: UIView!
    @IBOutlet weak var goodsNameV: CustomInputView!
    @IBOutlet weak var realWeightV: CustomInputView!
    @IBOutlet weak var priceWeightV: CustomInputView!
    @IBOutlet weak var volumeWeightV: CustomInputView!
    @IBOutlet weak var lengthV: CustomInputView!
    @IBOutlet weak var widthV: CustomInputView!
    @IBOutlet weak var heightV: CustomInputView!
    @IBOutlet weak var itemValueV: CustomInputView!
    @IBOutlet weak var insuranceV: CustomInputView!
    @IBOutlet weak var remarkV: CustomTextView!
    
    lazy var goodsTypeOptionCV: JTBaseDataCollectionView<OptionCollectionViewCell> = {
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
        goodsTypeOptionCV.dataList = ["PARCEL-r".localized, "DOCUMENT-r".localized].map({ item in
            let model = JTBalanceModel()
            model.title = item
            return model
        })
        goodsTypeOptionCV.setupCell = {cell, idx in
            let width = (kScreenWidth - 30 - 16) / 2
            cell.titleV.snp.updateConstraints { make in
                make.width.equalTo(width - 10)
            }
        }
        goodsTypeV.addSubview(goodsTypeOptionCV)
        goodsTypeOptionCV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        goodsNameV.titleLb.text = "物品名称-r".localized
        goodsNameV.textF.placeholder = "请输入物品名称-r".localized
        
        realWeightV.titleLb.text = "实际重量-r".localized
        realWeightV.setupConten(isRequired: true, showSwitch: false, prefixStr: "", optionImgName: "")
        
        priceWeightV.titleLb.text = "计费重量-r".localized
        priceWeightV.setupConten(isRequired: true, showSwitch: false, prefixStr: "", optionImgName: "")
        
        volumeWeightV.titleLb.text = "体积重重量-r".localized
        
        lengthV.titleLb.text = "长-r".localized
        
        widthV.titleLb.text = "宽-r".localized
        
        heightV.titleLb.text = "高-r".localized
        
        itemValueV.titleLb.text = "物品价值-r".localized
        itemValueV.textF.placeholder = "请输入物品价值-r".localized
        
        
        insuranceV.titleLb.text = "保价费-r".localized
        insuranceV.textF.placeholder = "请输入-r".localized
        insuranceV.setupConten(isRequired: true, showSwitch: true, prefixStr: "", optionImgName: "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
