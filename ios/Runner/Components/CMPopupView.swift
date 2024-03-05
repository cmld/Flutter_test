//
//  CMPopupView.swift
//  Runner
//
//  Created by yl on 2024/2/27.
//

import Foundation
import UIKit

class CMPopupConfig {
    enum CMPopupPosition {
        case top
        case down
        case center
    }
    
    var position: CMPopupPosition = .top
    var yTopGap: CGFloat = 0
    var yDownGap: CGFloat = 0
    
    init(position: CMPopupPosition, yTopGap: CGFloat = 0, yDownGap: CGFloat = 0) {
        self.position = position
        self.yTopGap = yTopGap
        self.yDownGap = yDownGap
    }
}

class CMPopupView: UIView {
    
    lazy var maskV: UIView = {
        let value = UIView()
        value.backgroundColor = UIColor.black.withAlphaComponent(0)
        value.clipsToBounds = true
        return value
    }()
    
    lazy var content: UIView = {
        let value = UIView()
        value.clipsToBounds = true
        return value
    }()
    
    var contentView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCellUI()
    }
    
    func createCellUI() {
        self.addSubviews([maskV, content])
        
        maskV.addTap {
            CMPopupView.hiddenOnWindow()
        }
    }
    
    func showWithConfig(_ contentV: UIView, config: CMPopupConfig) {
        
        CMPopupView.hiddenOnWindow()
        
        getWindow().addSubview(self)
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        maskV.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(config.yTopGap)
            make.bottom.equalToSuperview().inset(config.yDownGap)
            make.left.right.equalToSuperview()
        }
        
        content.snp.makeConstraints { make in
            make.centerX.equalTo(maskV)
            make.left.greaterThanOrEqualTo(maskV)
            switch config.position {
                case .top:
                    make.top.equalTo(maskV)
                case .down:
                    make.bottom.equalTo(maskV)
                case .center:
                    make.centerY.equalTo(maskV)
            }
        }
        
        contentView = contentV
        content.addSubview(contentV)
        let contentH = max(contentV.bounds.size.height, (SCREEN_HEIGHT / 2))
        contentV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            switch config.position {
                case .top:
                    make.top.bottom.equalToSuperview().offset(-contentH)
                case .down:
                    make.top.bottom.equalToSuperview().offset(contentH)
                case .center:
                    make.top.bottom.equalToSuperview()
            }
        }
        
        contentV.alpha = (config.position == .center) ? 0 : 1
        self.layoutIfNeeded()
        
        showAnimate(config: config)
        
    }
    
    func showAnimate(config: CMPopupConfig) {
        UIView.animate(withDuration: 0.2) {
            self.maskV.backgroundColor = .black.withAlphaComponent(0.3)
            self.contentView?.alpha = 1
            
            self.contentView?.snp.updateConstraints { make in
                make.top.bottom.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
    }
    
    static func hiddenOnWindow() {
        for subV in getWindow().subviews {
            if subV.isKind(of: CMPopupView.self) {
                UIView.animate(withDuration: 0.2) {
                    subV.alpha = 0
                } completion: { isCom in
                    subV.removeFromSuperview()
                }
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let pointV = super.hitTest(point, with: event)
        if pointV == self {
            self.removeFromSuperview()
            return nil
        }
        return pointV
    }
    
}

func getWindow() -> UIWindow {
    var window = UIApplication.shared.keyWindow
    //是否为当前显示的window
    if window?.windowLevel != UIWindow.Level.normal{
        let windows = UIApplication.shared.windows
        for  windowTemp in windows{
            if windowTemp.windowLevel == UIWindow.Level.normal{
                window = windowTemp
                break
            }
        }
    }
    return window!
}
