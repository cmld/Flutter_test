//
//  Tools.swift
//  Runner
//
//  Created by yl on 2023/11/1.
//

import Foundation
import UIKit

typealias CallbackVoid = ()->Void
typealias Callback1Value<T> = (T)->Void
typealias Callback2Value<T, B> = (T, B)->Void

class Tools {
    static func addWater(content: UIImage, text: String) {

    }
}

let HORIZONTAL_SPACE = 200.0 //水平间距
let VERTICAL_SPACE = 200.0 //竖直间距
extension UIImage {
    // 31.220655,121.209302\n2023-11-01 11:34:47 (GMT+08:00)\nYoyi Station 黄萱UAT 驿站测试1(ID30000001)
    func addW(text: String) -> UIImage {

        let waterContent = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
        waterContent.text = text
        waterContent.backgroundColor = .black.withAlphaComponent(0.3)
        
        // 开始给图片添加文字水印
        let bgSize = self.size
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRectMake(0, 0, bgSize.width, bgSize.height))
        
        let size = bgSize.width/720 * 20
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.backgroundColor: UIColor.black.withAlphaComponent(0.3)
        ]
        var textFrame = NSString(string: text).boundingRect(with: CGSize(width: bgSize.width - 100,height: bgSize.height), options: .usesLineFragmentOrigin,attributes: attributes, context: nil)
        
        print("textFrame: w: \(textFrame.width) h: \(textFrame.height)")
        
        NSString(string: text).draw(in: CGRect(x: 0, y: 300, width: textFrame.width, height: textFrame.height),withAttributes: attributes)
        
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkedImage ?? UIImage()
    }
    
    
    /// 添加水印
    /// - Parameters:
    ///   - markText: 水印文字
    ///   - attributes: 水印富文本
    func addWaterMark(markText: String, attributes: [NSAttributedString.Key: Any]) -> UIImage {
        autoreleasepool {
            let viewWidth = size.width
            let viewHeight = size.height
            let sqrtLength = sqrt(viewWidth + viewHeight)
            
            // 1.开启上下文
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            //2.绘制图片
            draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            //添加水印文字
            let attrStr: NSMutableAttributedString = NSMutableAttributedString(string: markText, attributes: attributes)
            //绘制文字的宽高
            let strWidth = attrStr.size().width
            let strHeight = attrStr.size().height
            //开始旋转上下文矩阵，绘制水印文字
            guard let context = UIGraphicsGetCurrentContext() else { return self }
            
            //将绘制原点（0，0）调整到原image的中心
            context.concatenate(CGAffineTransform(translationX: 0, y: 0))
        
            //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
            let space: CGFloat = 10
            let originY: CGFloat = self.size.height - strHeight - space
            
            //在每行绘制时Y坐标叠加
            let bgColorH = strHeight + space * 2
            context.setFillColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor)
            context.fill(CGRectMake(0, size.height - bgColorH, size.width, bgColorH))
            
            markText.draw(in: CGRect(x: (self.size.width - strWidth)/2, y: originY, width: strWidth, height: strHeight), withAttributes: attributes)
            
            //3.从上下文中获取新图片
            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? self

            //4.关闭上下文
            UIGraphicsEndImageContext()
            //context.restoreGState()

            return newImage
        }
    }
    
    
    // 斜边水印
    func obliqueWaterMark(markText: String, attributes: [NSAttributedString.Key: Any]) -> UIImage {
        autoreleasepool {
            let viewWidth = size.width
            let viewHeight = size.height
            let sqrtLength = sqrt(viewWidth * viewWidth + viewHeight * viewHeight)
            
            // 1.开启上下文
            UIGraphicsBeginImageContextWithOptions(size, true, 1)
            //2.绘制图片
            draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            //添加水印文字
            let attrStr: NSMutableAttributedString = NSMutableAttributedString(string: markText, attributes: attributes)
            //绘制文字的宽高
            let strWidth = attrStr.size().width
            let strHeight = attrStr.size().height
            //开始旋转上下文矩阵，绘制水印文字
            guard let context = UIGraphicsGetCurrentContext() else { return self }
            
            //将绘制原点（0，0）调整到原image的中心
            context.concatenate(CGAffineTransform(translationX: viewWidth/2, y: viewHeight/2))
            context.concatenate(CGAffineTransformMakeRotation(-Double.pi / 3))
            context.concatenate(CGAffineTransform(translationX: -viewWidth/2, y: -viewHeight/2))
            
            let hourCount: Int = Int(sqrtLength / (strWidth + CGFloat(HORIZONTAL_SPACE)) + 1)
            let verCount: Int = Int(sqrtLength / (strHeight + CGFloat(VERTICAL_SPACE)) + 1)
            
            let originX = -(sqrtLength-viewWidth)/2
            let originY = -(sqrtLength-viewHeight)/2
            
            var tempOrignX = originX
            var tempOriginY = originY
            
            for index in 0..<hourCount * verCount {
                markText.draw(in: CGRect(x: tempOrignX, y: tempOriginY, width: strWidth, height: strHeight), withAttributes: attributes)
                if index % hourCount == 0 && index != 0 {
                    tempOrignX = originX
                    tempOriginY += strHeight + VERTICAL_SPACE
                } else {
                    tempOrignX += strWidth + HORIZONTAL_SPACE
                }
            }
            
            //3.从上下文中获取新图片
            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? self

            //4.关闭上下文
            UIGraphicsEndImageContext()
            //context.restoreGState()

            return newImage
        }
    }
    
    func waterMarkMerge(markText: String, attributes: [NSAttributedString.Key: Any], content: String, contentAttr: [NSAttributedString.Key: Any]) -> UIImage {
        autoreleasepool {
            let viewWidth = size.width
            let viewHeight = size.height
            let sqrtLength = sqrt(viewWidth * viewWidth + viewHeight * viewHeight)
            let factor = viewHeight/720
            
            let rotation = Double.pi / 6 // 旋转角度 pi为180度 正数为顺时针
            
            // 1.开启上下文
            UIGraphicsBeginImageContextWithOptions(size, true, 1)
            //2.绘制图片
            draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            //添加水印文字
            let attrStr: NSMutableAttributedString = NSMutableAttributedString(string: markText, attributes: attributes)
            //绘制文字的宽高
            let strWidth = attrStr.size().width
            let strHeight = attrStr.size().height
            //开始旋转上下文矩阵，绘制水印文字
            guard let context = UIGraphicsGetCurrentContext() else { return self }
            
            //将绘制原点（0，0）调整到原image的中心
            context.concatenate(CGAffineTransform(translationX: viewWidth/2, y: viewHeight/2))
            context.concatenate(CGAffineTransformMakeRotation(-rotation))
            context.concatenate(CGAffineTransform(translationX: -viewWidth/2, y: -viewHeight/2))
            
            let hourCount: Int = Int(sqrtLength / (strWidth + CGFloat(HORIZONTAL_SPACE * factor)) + 1)
            let verCount: Int = Int(sqrtLength / (strHeight + CGFloat(VERTICAL_SPACE * factor)) + 1)
            
            let originX = -(sqrtLength-viewWidth)/2
            let originY = -(sqrtLength-viewHeight)/2
            
            var tempOrignX = originX
            var tempOriginY = originY
            
            // 斜水印
            for index in 0..<hourCount * verCount {
                markText.draw(in: CGRect(x: tempOrignX, y: tempOriginY, width: strWidth, height: strHeight), withAttributes: attributes)
                if index % hourCount == 0 && index != 0 {
                    tempOrignX = originX
                    tempOriginY += strHeight + VERTICAL_SPACE * factor
                } else {
                    tempOrignX += strWidth + HORIZONTAL_SPACE * factor
                }
            }
            
            // 添加内容水印
            //添加水印文字
            let contentStr: NSMutableAttributedString = NSMutableAttributedString(string: content, attributes: contentAttr)
            //绘制文字的宽高
            let contentStrWidth = contentStr.size().width
            let contentStrHeight = contentStr.size().height
            
            context.concatenate(CGAffineTransform(translationX: viewWidth/2, y: viewHeight/2))
            context.concatenate(CGAffineTransformMakeRotation(rotation))
            context.concatenate(CGAffineTransform(translationX: -viewWidth/2, y: -viewHeight/2))
            //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
            let space: CGFloat = 10
            let contentOriginY: CGFloat = self.size.height - contentStrHeight - space
            
            //在每行绘制时Y坐标叠加
            let bgColorH = contentStrHeight + space * 2
            context.setFillColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor)
            context.fill(CGRectMake(0, size.height - bgColorH, size.width, bgColorH))
            
            content.draw(in: CGRect(x: (self.size.width - contentStrWidth)/2, y: contentOriginY, width: contentStrWidth, height: contentStrHeight), withAttributes: contentAttr)
            
            //3.从上下文中获取新图片
            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
            
            //4.关闭上下文
            UIGraphicsEndImageContext()
            //context.restoreGState()

            return newImage
            
        }
    }
    
    
    /// 压缩图片
    /// - Return: 压缩后的图片data
    func compressData(_ quality: CGFloat) -> Data? {
        autoreleasepool {
            /** 算法 **/
            var tempImage = self
            let width:Int = Int(self.size.width)
            let height:Int = Int(self.size.height)
            var updateWidth = width
            var updateHeight = height
            let longSide = max(width, height)
            let shortSide = min(width, height)
            let scale:CGFloat = CGFloat(CGFloat(shortSide) / CGFloat(longSide))
            
            // 大小压缩
            if shortSide < 720 || longSide < 720 { // 如果宽高任何一边都小于 720
                updateWidth = width
                updateHeight = height
            } else { // 如果宽高都大于 1080
                if width < height { // 说明短边是宽
                    updateWidth = 720
                    updateHeight = Int(720 / scale)
                } else { // 说明短边是高
                    updateWidth = Int(720 / scale)
                    updateHeight = 720
                }
            }
            
            let size: CGSize = CGSize(width: updateWidth, height: updateHeight)
            UIGraphicsBeginImageContext(size)
            tempImage.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
            if let image:UIImage = UIGraphicsGetImageFromCurrentImageContext(){
                tempImage = image
            }
            UIGraphicsEndImageContext()
            var resultData:Data? = tempImage.jpegData(compressionQuality:quality)
            if let data = resultData {
                if data.count > 512 * 1024 && data.count < 1024 * 1024 {
                    resultData = UIImage(data: data)?.jpegData(compressionQuality: 0.9)
                } else if data.count >= 1024 * 1024 && data.count < 2 * 1024 * 1024 {
                    resultData = UIImage(data: data)?.jpegData(compressionQuality: 0.8)
                } else if data.count >= 2 * 1024 * 1024 && data.count < 5 * 1024 * 1024 {
                    resultData = UIImage(data: data)?.jpegData(compressionQuality: 0.7)
                } else if data.count >= 5 * 1024 * 1024 && data.count < 10 * 1024 * 1024 {
                    resultData = UIImage(data: data)?.jpegData(compressionQuality: 0.6)
                } else {
                    resultData = UIImage(data: data)?.jpegData(compressionQuality: 0.5)
                }
            }
            if ((resultData?.count ?? 0) > 512 * 1024) {
                resultData = UIImage(data: resultData ?? Data())?.jpegData(compressionQuality: 0.8)
            }
            
            print("clmd-image: compressData.count: \(resultData?.count ?? 0)")
            return resultData
        }
    }
}

//MARK: - 按钮和UIView的事件
extension UIView { // 按钮和UIView的事件
    
    private static var blockKey: UInt8 = 0
    
    private var block: (()->())? {
        get{ return objc_getAssociatedObject(self, &UIView.blockKey) as? ()->() }
        set{ objc_setAssociatedObject(self, &UIView.blockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    func addTap(_ aBlock: @escaping ()->()) {
        block = aBlock
        isUserInteractionEnabled = true
        if let button = self as? UIButton {
            button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        } else {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
            addGestureRecognizer(tap)
        }
    }
    
    @objc func tapAction() {
        block?()
    }
    
    func addBorder(color: UIColor, radius: CGFloat = 6){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = radius
    }
    
    func addSubviews(_ sub: [UIView]){
        sub.forEach { item in
            self.addSubview(item)
        }
    }
}

extension CALayer {
    func setBorderColorWithUIColor(color: UIColor) {
        self.borderColor = color.cgColor
    }
}


extension String {
    var moneyAbbreviation: String {
        if let amount = Decimal(string: self) {
            var denominator = Decimal(1)
            var unit = ""
            if amount >= 10000 && amount < 1000000 {
                denominator = Decimal(1000)
                unit = "k"
            } else if amount >= 1000000 && amount < 1000000000 {
                denominator = Decimal(1000000)
                unit = "M"
            } else if amount >= 1000000000 {
                denominator = Decimal(1000000000)
                unit = "B"
            }
            let conversion = amount / denominator
            // 四舍五入用roundingMode: .plain
            let handler = NSDecimalNumberHandler(roundingMode: .down, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
            let roundedNum = NSDecimalNumber(decimal: conversion).rounding(accordingToBehavior: handler)
            print("amount: \(amount)    conversion: \(conversion)   roundedNum: \(roundedNum)")
            return String(format: "%0.2f", Double(truncating: roundedNum)) + unit
        }
        return self
    }
    
    func fileUrl() -> URL? {
        let parts = self.components(separatedBy: ".")
        if let path = Bundle.main.path(forResource: parts.first, ofType: parts.last) {
            return URL(fileURLWithPath: path)
        }
        return nil
    }
    
    /// 正则匹配
    func reMatch(reString: String) -> Bool {
        let pre = NSPredicate(format: "SELF MATCHES %@", reString)
        return pre.evaluate(with: self)
    }
    
    var localized: String {
        return self
    }
    func dflt(_ defStr: String = "") -> String {
        return self.count > 0 ? self : defStr
    }
}

extension String? {
    func dflt(_ defStr: String = "") -> String {
        let tranStr = self ?? defStr
        return tranStr.count > 0 ? tranStr : defStr
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


// MARK: UITextField 和 UITextView
extension UITextField {
    
    private static var tempDelegateKey: UInt8 = 0
    private var tempDelegate: UITFTools? {
        get{ return objc_getAssociatedObject(self, &UITextField.tempDelegateKey) as? UITFTools }
        set{ objc_setAssociatedObject(self, &UITextField.tempDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    func didEndEditing(_ call: @escaping (String?)->Void) {
        if tempDelegate == nil {
            tempDelegate = UITFTools()
            self.delegate = tempDelegate
        }
        tempDelegate?.callBack = call
    }
    func shouldChangeMatch(_ matchStr: String = ".*", _ call: ((String?)->Bool)? = nil) {
        if tempDelegate == nil {
            tempDelegate = UITFTools()
            self.delegate = tempDelegate
        }
        tempDelegate?.matchStr = matchStr
        tempDelegate?.change = call
    }
}

class UITFTools: NSObject, UITextFieldDelegate {
    var callBack: ((String?)->Void)?
    var change: ((String?)->Bool)?
    var matchStr: String = ".*"
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        callBack?(textField.text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = NSString(string: currentText).replacingCharacters(in: range, with: string)
        
        return change?(newText) ?? newText.reMatch(reString: matchStr)
    }
    
    // UITextFieldDelegate 方法，点击 Return 键时调用
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 在这里处理点击 Done 按钮的事件
        textField.resignFirstResponder() // 隐藏键盘
        return true
    }
}


class PaddingTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        // 设置文本的内边距（显示文本时的内边距）
        return bounds.insetBy(dx: 10, dy: 5)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        // 设置编辑文本时的内边距
        return bounds.insetBy(dx: 10, dy: 5)
    }
}


extension UITextView {
    private static var tempDelegateKey: UInt8 = 0
    private var tempDelegate: UITVTools? {
        get{ return objc_getAssociatedObject(self, &UITextView.tempDelegateKey) as? UITVTools }
        set{ objc_setAssociatedObject(self, &UITextView.tempDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    func didEndEditing(_ call: @escaping (String?)->Void) {
        if tempDelegate == nil {
            tempDelegate = UITVTools()
            self.delegate = tempDelegate
        }
        tempDelegate?.callBack = call
    }
    func shouldChangeMatch(_ matchStr: String = ".*", _ call: ((String?)->Bool)? = nil) {
        if tempDelegate == nil {
            tempDelegate = UITVTools()
            self.delegate = tempDelegate
        }
        tempDelegate?.matchStr = matchStr
        tempDelegate?.change = call
    }
    
    func beginEditing(_ call: ((String?)->Void)? = nil){
        if tempDelegate == nil {
            tempDelegate = UITVTools()
            self.delegate = tempDelegate
        }
        tempDelegate?.beginBack = call
    }
}
class UITVTools: NSObject, UITextViewDelegate {
    var callBack: ((String?)->Void)?
    var change: ((String?)->Bool)?
    var beginBack: ((String?)->Void)?
    var matchStr: String = ".*"
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        beginBack?(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text else { return true }
        let newText = NSString(string: currentText).replacingCharacters(in: range, with: text)
        
        return change?(newText) ?? newText.reMatch(reString: matchStr)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        callBack?(textView.text)
    }
}
