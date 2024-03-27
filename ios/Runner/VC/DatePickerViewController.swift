//
//  DatePickerViewController.swift
//  Runner
//
//  Created by yl on 2024/3/15.
//

import UIKit
import SwiftDate

class DatePickerViewController: BaseViewController {
    
    lazy var picker: CMDatePickerView = {
        let value = CMDatePickerView(startD: Date() - 6.days, endD: Date(), formatStr: "YYYY-MM-dd", color: UIColor.red)
        value.minLimit = Date() - 6.months
        value.maxLimit = Date()
        return value
    }()
    
    lazy var contentTV: UILabel = {
        let value = UILabel()
        value.numberOfLines = 0
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews([picker, contentTV])
        picker.snp.makeConstraints { make in
            make.centerY.left.right.equalToSuperview().inset(15)
        }
        
        contentTV.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
//            make.height.equalTo(100)
        }
        
        let orginStr = "lskjflkajldf#<好好>#，阿斯利康放假、，？！@￥……啦会计法#<水电费都是>#\n阿斯利康放假啦会计法#<高亮了>#\n阿斯利康放假啦会计法#<沙发上了>#\nThis is a #<sample># text with #<highlighted># words.lskjflkajldf#<好好>#，阿斯利康放假、，？！@￥……啦会计法#<水电费都是>#\n阿斯利康放假啦会计法#<高亮了>#\n阿斯利康放假啦会计法#<沙发上了>#\nThis is a #<sample># text with #<highlighted># words."
        contentTV.attributedText = heightLightString(orginStr)
    }
    
    // 高亮处理
    func heightLightString(_ orginString: String) -> NSMutableAttributedString {
        // 要提取的原始文本
        var inputText = orginString
        
        var result = NSMutableAttributedString(string: "")
        
        let contentFormet = "<p style=\"font-size: 15px;\">%@</p>"
        let heightLightFormet = "<span style=\"color: #0366ff; font-weight: bold; font-size: 15px;\">%@</span>"
        let patternStr = "#<([^>]+)>#"
        
        // 创建正则表达式对象
        if let regex = try? NSRegularExpression(pattern: patternStr) {
            var lables:[String] = []
            
            // 在文本中查找匹配项
            let matches = regex.matches(in: inputText, range: NSRange(inputText.startIndex..., in: inputText))
            // 高亮显示匹配的文本
            for match in matches {
                // 获取匹配项的范围
                let range = match.range(at: 0)
                if let swiftRange = Range(range, in: inputText) {
                    // 提取匹配项的文本
                    let extractedText = inputText[swiftRange]
                    
                    lables.append(String(extractedText))
                }
            }
            
            lables.forEach { item in
                let hlStr = item[item.index(item.startIndex, offsetBy: 2)..<item.index(item.startIndex, offsetBy: item.count - 2)]
                let repStr = String(format: heightLightFormet, String(hlStr))
                inputText = inputText.replacingOccurrences(of: item, with: repStr)
            }
            inputText = inputText.replacingOccurrences(of: "\n", with: "<br>") // 换行符
            let htmlText = String(format: contentFormet, inputText)
            if let attributedString = try? NSAttributedString(data: htmlText.data(using: .utf16)!,
                                                              options: [.documentType: NSAttributedString.DocumentType.html],
                                                              documentAttributes: nil) {
                result = NSMutableAttributedString(attributedString: attributedString)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 7 // 设置行间距为 10
                result.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: result.length))
            }
            
        }
        result.mutableString.replaceOccurrences(of: "\n", with: "", range: NSRange(location: 0, length: result.mutableString.length))
        return result
    }
    
}
