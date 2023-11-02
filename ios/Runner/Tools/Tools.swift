//
//  Tools.swift
//  Runner
//
//  Created by yl on 2023/11/1.
//

import Foundation
import UIKit

class Tools {
    static func addWater(content: UIImage, text: String) {

    }
}

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
}
