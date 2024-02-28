//
//  ToolsViewController.swift
//  Runner
//
//  Created by yl on 2023/12/21.
//

import UIKit


class ToolsViewController: BaseViewController, XMLParserDelegate {
    
    lazy var titleV: UILabel = {
        let value = UILabel()
        value.textColor = .black
        value.font = UIFont.systemFont(ofSize: 14)
        value.backgroundColor = .lightGray
        return value
    }()
    
    lazy var inpView: CustomInputView = {
        let value = CustomInputView()
        value.setupConten(isRequired: true, showSwitch: true, prefixStr: "", optionImgName: "addShelf")
        value.titleLb.text = "地址信息信息信息"
        value.textF.placeholder = "请输入"
        return value
    }()
    
    lazy var desV: DesensitizationView = {
        let value = DesensitizationView()
        
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textF = UITextField(frame: CGRect(x: 10, y: 100, width: 200, height: 30))
        textF.backgroundColor = .lightGray
        textF.didEndEditing { text in
            print("textF \(text ?? "")")
        }
        textF.keyboardType = .numbersAndPunctuation
        view.addSubview(textF)
        
        view.addSubview(titleV)
        titleV.snp.makeConstraints { make in
            make.top.equalTo(textF.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        
        
        let textF1 = UITextField(frame: CGRect(x: 10, y: 200, width: 200, height: 30))
        textF1.backgroundColor = .lightGray
        textF1.didEndEditing { text in
            print("textF1 \(text ?? "")")
        }
        textF1.keyboardType = .numbersAndPunctuation
        view.addSubview(textF1)
        
//        inpView.layer.borderWidth = 1
//        inpView.layer.borderColor = UIColor.green.cgColor
        view.addSubview(inpView)
        inpView.snp.makeConstraints { make in
            make.top.equalTo(textF1.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(150)
        }
        
        let autodecode = AutoDecodeReceivingView()
        view.addSubview(autodecode)
        autodecode.snp.makeConstraints { make in
            make.top.equalTo(inpView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(desV)
        desV.configContent("130****3213") {
            return "13065463213"
        }
        desV.snp.makeConstraints { make in
            make.top.equalTo(autodecode.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(50)
        }
        
        
        
    }

}

extension ToolsViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        titleV.text = textField.text?.moneyAbbreviation
    }
}


