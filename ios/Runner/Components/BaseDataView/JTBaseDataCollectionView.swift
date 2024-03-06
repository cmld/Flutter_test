//
//  JTBaseDataCollectionView.swift
//  Runner
//
//  Created by yl on 2023/12/5.
//

import UIKit
import HandyJSON

class JTBaseDataCollectionCell: UICollectionViewCell {
    typealias D = HandyJSON
    var cellModel: D?
    func setContent(model: D) {}
}

class JTBaseDataCollectionView<T: JTBaseDataCollectionCell>: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var cellID: String = "" {
        didSet {
            self.register(T.classForCoder(), forCellWithReuseIdentifier: cellID)
        }
    }
    var dataList: [T.D] = [] {
        didSet {
            self.reloadData()
            self.layoutIfNeeded()
        }
    }
    
    var setupCell:((_: T, _: IndexPath)->Void) = {_, _ in}
    
    var cellSelected:((_: T, _: IndexPath)->Void) = {_, _ in}
    
    var autoSetH: NSLayoutConstraint?
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
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
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? T {
            let model = dataList[indexPath.row]
            cell.cellModel = model
            cell.setContent(model: model)
            setupCell(cell, indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? T {
            cellSelected(cell, indexPath)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let needSetH = autoSetH, self.contentSize.height != needSetH.constant {
            needSetH.constant = self.contentSize.height
        }
    }
}

// MARK: 自定义布局约束 左对齐
class UICollectionViewLeftFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
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
                curAttr.frame = frame
            }
        }
        return attrsArry
    }
    
}
