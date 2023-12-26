//
//  ToolsViewController.swift
//  Runner
//
//  Created by yl on 2023/12/21.
//

import UIKit

class ToolsViewController: UIViewController {
    
    lazy var titleV: UILabel = {
        let value = UILabel()
        value.textColor = .black
        value.font = UIFont.systemFont(ofSize: 14)
        value.backgroundColor = .lightGray
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textF = UITextField(frame: CGRect(x: 10, y: 100, width: 200, height: 30))
        textF.backgroundColor = .lightGray
        textF.delegate = self
        textF.keyboardType = .numbersAndPunctuation
        view.addSubview(textF)
        
        view.addSubview(titleV)
        titleV.snp.makeConstraints { make in
            make.top.equalTo(textF.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
    }

}

extension ToolsViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        titleV.text = textField.text?.moneyAbbreviation
    }
}
