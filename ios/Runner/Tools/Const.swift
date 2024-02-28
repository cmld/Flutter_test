//
//  Const.swift
//  Runner
//
//  Created by yl on 2024/1/18.
//

import Foundation
import UIKit

// - MARK: 尺寸
let SCREEN_WIDTH = min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
let SCREEN_HEIGHT = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
/// -> 手机屏幕的宽度
let kScreenWidth = UIScreen.main.bounds.width
/// -> 手机屏幕的高度
let kScreenHeight = UIScreen.main.bounds.height
//宽度比例
let kScreenWidthScale  = kScreenWidth/375.0
let kBannerHeight = 959/1563 * SCREEN_WIDTH

/// 安全区域
var kSafeInset: UIEdgeInsets {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
    } else {
        // Fallback on earlier versions
        return .zero
    }
}

/// `iPhoneX`系列底部的安全边距
let BottomSafeArea :CGFloat = kSafeInset.bottom

/// App导航栏高度
let kNavigatioHeight: CGFloat = kSafeInset.top + 44
