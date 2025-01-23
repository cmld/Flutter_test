//
//  ImageShowViewController.swift
//  Runner
//
//  Created by yl on 2024/9/29.
//

import UIKit
//@_exported import JTTCScrollView

@objcMembers class ImageShowViewController: UIViewController {

    lazy var myCollectionV: JTBaseDataCollectionView<JTImageShowItemCell> = {
        let flowlayout = UICollectionViewLeftFlowLayout.init()
        flowlayout.scrollDirection = .horizontal
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowlayout.minimumLineSpacing = 0;
        flowlayout.minimumInteritemSpacing = 0
        
        let value = JTBaseDataCollectionView<JTImageShowItemCell>.init(frame: .zero, collectionViewLayout: flowlayout)
        value.cellID = "myCollectionVID"
        value.isPagingEnabled = true
        value.autoSetH?.isActive = false
        value.autoSetW?.isActive = false
        return value
    }()
    
    lazy var forwardImg: UIImageView = {
        let value = UIImageView()
        value.image = UIImage(named: "home_send_set")
        value.contentMode = .center
        value.layer.cornerRadius = 22
        value.backgroundColor = .black.withAlphaComponent(0.3)
        return value
    }()
    lazy var backwardImg: UIImageView = {
        let value = UIImageView()
        let img = UIImage(named: "home_send_set")
        value.image =  UIImage(cgImage: img!.cgImage!,
                               scale: img!.scale,
                               orientation: .upMirrored)
        value.contentMode = .center
        value.layer.cornerRadius = 22
        value.backgroundColor = .black.withAlphaComponent(0.3)
        return value
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews([myCollectionV, forwardImg, backwardImg])
        myCollectionV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        forwardImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
            make.leading.equalToSuperview().inset(12)
        }
        backwardImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
            make.trailing.equalToSuperview().inset(12)
        }
        
        actions()
    }
    
    func actions() {
        
        myCollectionV.cellSelected = { [weak self] cell, idx in
            guard let `self` = self else { return }
            self.dismiss(animated: true)
        }
        
        myCollectionV.setupCell = { [weak self] cell, idx in
            guard let `self` = self else { return }
            cell.pageCount.text = "\(idx.row + 1)/\(myCollectionV.dataList.count)"
        }
        
        forwardImg.addTap { [weak self]  in
            guard let `self` = self else { return }
            let forwardIndex = max(lrintf(Float(myCollectionV.contentOffset.x / kScreenWidth)) - 1, 0)
            myCollectionV.scrollToItem(at: IndexPath(row: forwardIndex, section: 0), at: .left, animated: true)
        }
        backwardImg.addTap { [weak self]  in
            guard let `self` = self else { return }
            let forwardIndex = min(lrintf(Float(myCollectionV.contentOffset.x / kScreenWidth)) + 1, myCollectionV.dataList.count - 1)
            myCollectionV.scrollToItem(at: IndexPath(row: forwardIndex, section: 0), at: .left, animated: true)
        }
    }
    
    static func showList(_ imgList: [Any]) {
        var list = imgList
        if let tempList = imgList as? [String] {
            list = tempList.map({ item in
                if let url = URL(string: item), let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                    return img
                } else {
                    return UIImage()
                }
            })
        }
        
        let vc = ImageShowViewController()
        vc.myCollectionV.dataList = list
        vc.modalPresentationStyle = .fullScreen
        if let currentWin = UIApplication.shared.delegate?.window {
            currentWin?.rootViewController?.present(vc, animated: true)
        }
    }
}

class JTImageShowItemCell: JTBaseDataCollectionCell {
    lazy var imageV: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFit
        return value
    }()
    
    
    lazy var pageCount: UILabel = {
        let value = UILabel()
        value.textColor = .white
        value.font = UIFont.systemFont(ofSize: 14)
        value.backgroundColor = .black.withAlphaComponent(0.5)
        value.layer.cornerRadius = 11
        value.textAlignment = .center
        value.layer.masksToBounds = true
        return value
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCellUI()
    }
    
    func createCellUI() {
        contentView.backgroundColor = .white
        contentView.addSubviews([imageV, pageCount])
        
        imageV.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(kScreenHeight-50)
        }
        
        pageCount.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
            make.width.equalTo(50)
            make.bottom.equalToSuperview().inset(14)
            make.top.equalTo(imageV.snp.bottom).offset(14)
        }
        
    }
    
    override func setContent(model: D) {
        if let  instance = model as? UIImage {
            imageV.image = instance
        }
        
        if let  instance = model as? String {
            if let url = URL(string: instance), let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                imageV.image = img
            }
        }
    }
    
}
