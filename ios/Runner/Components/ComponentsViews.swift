//
//  ComponentsViews.swift
//  Runner
//
//  Created by yl on 2024/1/28.
//

import Foundation
import UIKit

class CustomInputView: UIView {
    
    var isRequired: Bool = false
    lazy var requiredLb: UILabel = {
        let value = UILabel()
        value.text = "*"
        value.font = UIFont.systemFont(ofSize: 14)
        value.textColor = .red
        value.isHidden = true
        return value
    }()
    
    lazy var titleLb: UILabel = {
        let value = UILabel()
        value.font = UIFont.systemFont(ofSize: 12)
        value.textColor = .black
        return value
    }()
    
    var isShowSwitch: Bool = false
    lazy var switchBtn: UISwitch = {
        let value = UISwitch()
        value.onTintColor = .red
        value.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        value.isHidden = true
        return value
    }()
    
    lazy var inputBgView: UIView = {
        let value = UIView()
        value.backgroundColor = .white
        value.addBorder(color: .lightGray, radius: 5)
        return value
    }()
    
    var hasPrefix: Bool = false
    lazy var prefixLB: UILabel = {
        let value = UILabel()
        value.font = UIFont.systemFont(ofSize: 15)
        value.isHidden = true
        return value
    }()
    
    lazy var textF: UITextField = {
        let value = UITextField()
        value.font = UIFont.systemFont(ofSize: 15)
        return value
    }()
    
    var isShowOption: Bool = false
    lazy var optionBtn: UIButton  = {
        let value = UIButton()
        value.isHidden = true
        return value
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCellUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCellUI()
    }
    
    func createCellUI() {
        addSubview(requiredLb)
        addSubview(titleLb)
        addSubview(switchBtn)
        inputBgView.addSubview(prefixLB)
        inputBgView.addSubview(textF)
        inputBgView.addSubview(optionBtn)
        addSubview(inputBgView)
        
        requiredLb.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(isRequired ? 7 : 0)
        }
        titleLb.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(requiredLb.snp.right)
            make.right.lessThanOrEqualToSuperview().offset(isShowSwitch ? -53 : -3)
        }
        switchBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLb)
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(10)
        }
        
        inputBgView.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
        
        prefixLB.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.lessThanOrEqualTo(30)
        }
        
        textF.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalTo(prefixLB.snp.right).offset(hasPrefix ? 5 : 0)
            make.right.equalToSuperview().inset(isShowOption ? 28 : 10)
            make.width.greaterThanOrEqualTo(50)
        }
        optionBtn.snp.makeConstraints { make in
            make.centerY.equalTo(textF)
            make.right.equalToSuperview().inset(5)
            make.height.width.equalTo(20)
        }
    }
    
    func setupConten(isRequired: Bool = false, showSwitch: Bool = false, prefixStr: String = "", optionImgName: String = "") {
        self.isRequired = isRequired
        self.requiredLb.isHidden = !isRequired
        
        self.isShowSwitch = showSwitch
        self.switchBtn.isHidden = !showSwitch
        
        self.hasPrefix = !prefixStr.isEmpty
        self.prefixLB.isHidden = prefixStr.isEmpty
        self.prefixLB.text = prefixStr
        self.prefixLB.sizeToFit()
        
        self.isShowOption = !optionImgName.isEmpty
        self.optionBtn.isHidden = optionImgName.isEmpty
        if !optionImgName.isEmpty {
            self.optionBtn.setImage(UIImage(named: optionImgName), for: .normal)
        }
        
        requiredLb.snp.updateConstraints { make in
            make.width.equalTo(isRequired ? 7 : 0)
        }
        
        titleLb.snp.updateConstraints { make in
            make.right.lessThanOrEqualToSuperview().offset(isShowSwitch ? -53 : -3)
        }
        
        textF.snp.updateConstraints { make in
            make.left.equalTo(prefixLB.snp.right).offset(hasPrefix ? 5 : 0)
            make.right.equalToSuperview().inset(isShowOption ? 28 : 10)
            make.width.greaterThanOrEqualTo(50)
        }
    }
}

class AutoDecodeReceivingView: UIView {
    
    lazy var icon: UIImageView = {
        let value = UIImageView()
        value.image = UIImage(named: "addShelf")
        return value
    }()
    
    lazy var title: UILabel = {
        let value = UILabel()
        value.text = "智能解析-r".localized
        value.font = UIFont.systemFont(ofSize: 12)
        return value
    }()
    
    lazy var textV: UITextView = {
        let value = UITextView()
        value.font = UIFont.systemFont(ofSize: 12)
        return value
    }()
    
    lazy var placeholderLb: UILabel = {
        let value = UILabel()
        value.numberOfLines = 0
        value.font = UIFont.systemFont(ofSize: 12)
        value.text = "复制及粘贴个人资料,系统会尝试解析信息,比如:\nCalvin\n012-34567XX\nNo 1, Jalan XXX, Taman XXXX, 81100 Johor Bahru, Johor-r".localized
        value.textColor = .lightGray
        return value
    }()
    
    lazy var clearBtn: UIButton = {
        let value = UIButton()
        value.setTitle("清除-r".localized, for: .normal)
        value.setTitleColor(.lightGray, for: .normal)
        value.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        value.addBorder(color: .lightGray,radius: 15)
        return value
    }()
    
    lazy var decodeBtn: UIButton = {
        let value = UIButton()
        value.setTitle("解析-r".localized, for: .normal)
        value.setTitleColor(.red, for: .normal)
        value.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        value.addBorder(color: .red,radius: 15)
        return value
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCellUI()
        setActions()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCellUI()
        
        setActions()
    }
    
    func createCellUI() {
        let inputView = UIView()
        inputView.backgroundColor = .white
        inputView.addBorder(color: .lightGray)
        inputView.addSubviews([textV, placeholderLb])
        addSubviews([icon, title, inputView, clearBtn, decodeBtn])
        
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.width.equalTo(15)
        }
        title.snp.makeConstraints { make in
            make.centerY.equalTo(icon)
            make.left.equalTo(icon.snp.right).offset(5)
        }
        
        
        inputView.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(90)
        }
        
        textV.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(12)
        }
        placeholderLb.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(12)
        }
        
        clearBtn.snp.makeConstraints { make in
            make.top.equalTo(inputView.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.width.equalTo(65)
        }
        
        decodeBtn.snp.makeConstraints { make in
            make.top.equalTo(inputView.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.width.equalTo(65)
            make.right.equalTo(inputView)
            make.left.equalTo(clearBtn.snp.right).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    func setActions() {
        textV.beginEditing { [weak self] text in
            guard let `self` = self else { return }
            placeholderLb.isHidden = true
        }
        
        textV.didEndEditing {[weak self] text in
            guard let `self` = self else { return }
            placeholderLb.isHidden = !(text ?? "").isEmpty
        }
    }
    
}


class CustomTextView: UIView {
    
    lazy var textV: UITextView = {
        let value = UITextView()
        value.font = UIFont.systemFont(ofSize: 15)
        return value
    }()
    
    lazy var placeholderLb: UILabel = {
        let value = UILabel()
        value.numberOfLines = 0
        value.font = UIFont.systemFont(ofSize: 15)
        value.textColor = .lightGray
        value.text = "请输入-r".localized
        return value
    }()
    
    lazy var optionBtn: UIButton  = {
        let value = UIButton()
        value.setImage(UIImage(named: "addShelf"), for: .normal)
        return value
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addBorder(color: .lightGray, radius: 5)
        createCellUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func createCellUI() {
        addSubviews([textV, placeholderLb, optionBtn])
        
        textV.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(10)
            make.right.equalTo(optionBtn.snp.left).inset(5)
        }
        placeholderLb.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(12)
            make.bottom.lessThanOrEqualToSuperview().offset(0)
        }
        optionBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(5)
        }
    }
}


class DesensitizationView: UIView {
    lazy var contentLb: UILabel = {
        let value = UILabel()
        
        return value
    }()
    
    lazy var showIcon: UIButton = {
        let value = UIButton()
        value.setImage(UIImage(named: "addShelf"), for: .normal)
        value.setImage(UIImage(named: "home_send_set"), for: .selected)
//        value.image = UIImage(named: "addShelf")
        return value
    }()
    
    var sourceStr = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCellUI()
    }
    
    func createCellUI() {
        self.addSubviews([contentLb, showIcon])
        contentLb.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        showIcon.snp.makeConstraints { make in
            make.centerY.equalTo(contentLb)
            make.left.equalTo(contentLb.snp.right).offset(5)
            make.right.equalToSuperview()
        }
    }
    
    func configContent(_ string: String, callback:@escaping ()->String) {
        sourceStr = string
        contentLb.text = string
        showIcon.addTap { [weak self]  in
            guard let `self` = self else { return }
            contentLb.text = showIcon.isSelected ? string : callback()
            showIcon.isSelected = !showIcon.isSelected
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let pointView = super.hitTest(point, with: event)
        if pointView != self.showIcon {
            contentLb.text = sourceStr
            showIcon.isSelected = false
        }
        return pointView
    }
}

// 边框虚线
class DashedBorderView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        addDashedBorder()
    }

    func addDashedBorder() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4, 2, 2, 2]  // 设置虚线的样式

        let path = UIBezierPath(rect: bounds)
        shapeLayer.path = path.cgPath

        layer.addSublayer(shapeLayer)
    }
}

class OptionsView: UIView {
    
    var actionCall:((Int)->Void)?
    
    var creatBtn = {
        let value = UIButton()
        value.layer.borderWidth = 1
        value.layer.borderColor = UIColor.lightGray.cgColor
        value.setTitleColor(.black, for: .normal)
        value.backgroundColor = .white
        return value
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        createCellUI()
    }
    
    init(_ opts: [String]) {
        super.init(frame: .zero)
        createCellUI(opts)
    }
    
    func createCellUI(_ opts: [String]) {
        var lastV: UIButton!
        for (index, titleStr) in opts.enumerated() {
            let btn = creatBtn()
            btn.setTitle(titleStr, for: .normal)
            self.addSubview(btn)
            btn.addTap {[weak self]  in
                guard let `self` = self else { return }
                actionCall?(index)
            }
            
            let isLast = index == (opts.count - 1)
            
            btn.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                
                if let lv = lastV {
                    make.left.equalTo(lv.snp.right).offset(10)
                } else {
                    make.left.equalToSuperview()
                }
                if isLast {
                    make.right.equalToSuperview()
                }
            }
            
            lastV = btn
        }
    }
    
    
}

