//
//  ImageShowViewController.swift
//  Runner
//
//  Created by yl on 2024/9/29.
//

import UIKit

class ImageShowViewController: BaseViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myCollectionV)
        
        myCollectionV.snp.makeConstraints { make in
            make.edges.size.equalToSuperview()
        }
        
        myCollectionV.cellSelected = { [weak self] cell, idx in
            guard let `self` = self else { return }
            
            self.dismiss(animated: true)
            
        }
    }
    
    static func showList(_ imgList: [Any]) {
        let vc = ImageShowViewController()
        vc.myCollectionV.dataList = imgList
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCellUI()
    }
    
    func createCellUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(imageV)
        imageV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(kScreenHeight)
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
