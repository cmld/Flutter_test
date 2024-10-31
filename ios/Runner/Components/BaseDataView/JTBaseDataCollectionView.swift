//
//  JTBaseDataCollectionView.swift
//  Runner
//
//  Created by yl on 2023/12/5.
//

import UIKit
//import HandyJSON

open class JTBaseDataCollectionCell: UICollectionViewCell {
    public typealias D = Any
    open var cellModel: D?
    open func setContent(model: D) {}
}

open class JTBaseDataCollectionView<T: JTBaseDataCollectionCell>: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    open var cellID: String = "" {
        didSet {
            if cellID.contains("Nib") {
                self.register(UINib(nibName: "\(T.classForCoder())", bundle: nil), forCellWithReuseIdentifier: cellID)
            } else {
                self.register(T.classForCoder(), forCellWithReuseIdentifier: cellID)
            }
        }
    }
    open var dataList: [T.D] = [] {
        didSet {
            self.reloadData()
            self.layoutIfNeeded()
        }
    }
    
    open var setupCell:((_: T, _: IndexPath)->Void) = {_, _ in}
    
    open var cellSelected:((_: T, _: IndexPath)->Void) = {_, _ in}
    
    open var autoSetH: NSLayoutConstraint?
    open var maxH: CGFloat?
    open var autoSetW: NSLayoutConstraint?
    open var maxW: CGFloat?
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
//        let flowlayout = UICollectionViewFlowLayout.init()
//        flowlayout.scrollDirection = .vertical
//        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        flowlayout.minimumLineSpacing = 10;
//        flowlayout.minimumInteritemSpacing = 10
//        flowlayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 35)
        
        super.init(frame: frame, collectionViewLayout: layout)

        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
        
        autoSetH = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        autoSetH?.isActive = true
        autoSetW = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        autoSetW?.isActive = false
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:delegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? T {
            let model = dataList[indexPath.row]
            cell.cellModel = model
            cell.setContent(model: model)
            setupCell(cell, indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? T {
            cellSelected(cell, indexPath)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if let autoSetH, self.contentSize.height != autoSetH.constant {
            var willSetH = self.contentSize.height
            if let maxH {
                willSetH = min(maxH, willSetH)
            }
            autoSetH.constant = willSetH
        }
        if let autoSetW, self.contentSize.width != autoSetW.constant {
            var willSetW = self.contentSize.width
            if let maxW {
                willSetW = min(maxW, willSetW)
            }
            autoSetW.constant = willSetW
        }
    }
}

// MARK: 自定义布局约束 左对齐
open class UICollectionViewLeftFlowLayout: UICollectionViewFlowLayout {
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attrsArry = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        for i in 0..<attrsArry.count {
            if i != attrsArry.count-1 {
                let curAttr = attrsArry[i] //当前attr
                let nextAttr = attrsArry[i+1]  //下一个attr
                //如果下一个在同一行则调整，不在同一行则跳过
                if curAttr.frame.minY == nextAttr.frame.minY {
                    if nextAttr.frame.minX - curAttr.frame.maxX > minimumInteritemSpacing{
                        var frame = nextAttr.frame
                        let x = curAttr.frame.maxX + minimumInteritemSpacing
                        frame = CGRect(x: x, y: frame.minY, width: frame.width, height: frame.height)
                        nextAttr.frame = frame
                    }
                }
            } else if attrsArry.count == 1, let curAttr = attrsArry.first {
                var frame = curAttr.frame
                frame.origin.x = 0
                curAttr.frame = self.collectionView?.semanticContentAttribute == .forceRightToLeft ? frame.toRTL(self.collectionView?.bounds.width ?? 0) : frame
            }
        }
        
        return attrsArry
    }
    
}

extension CGRect {
    func toRTL(_ superW: CGFloat) -> CGRect {
        var result = self
        if superW > 0 {
            let transX = superW - self.maxX
            result = CGRect(x: transX, y: self.minY, width: self.width, height: self.height)
        }
        return result
    }
}
