//
//  MyScrollViewController.swift
//  Runner
//
//  Created by yl on 2023/12/26.
//

import UIKit

class MyScrollViewController: BaseViewController {
    
    lazy var myTableV: JTBaseDataTableView<JTNoticeCell> = {
        let value = JTBaseDataTableView<JTNoticeCell>()
        value.cellID = "myTableVID"
        value.layer.borderWidth = 2
        value.layer.borderColor = UIColor.lightGray.cgColor
        value.separatorStyle = .none
        value.autoSetH?.isActive = true
        return value
    }()
    
    // 横向布局，自动设置宽度，设置最大宽度，高度需固定
    lazy var horizontalCollectionV: JTBaseDataCollectionView<JTBalanceItemCell> = {
        let flowlayout = UICollectionViewLeftFlowLayout.init()
        flowlayout.scrollDirection = .horizontal
        flowlayout.estimatedItemSize = CGSize(width: 100, height: 25)
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10
        
        let value = JTBaseDataCollectionView<JTBalanceItemCell>.init(frame: .zero, collectionViewLayout: flowlayout)
        value.cellID = "myCollectionVID"
        value.layer.borderWidth = 2
        value.layer.borderColor = UIColor.red.cgColor
        value.autoSetW?.isActive = true
        value.autoSetH?.isActive = false
        value.maxW = 300
        return value
    }()
    
    // 纵向布局，默认自动设置高度，宽度需固定
    lazy var verticalCollectionV: JTBaseDataCollectionView<JTBalanceItemCell> = {
        let flowlayout = UICollectionViewLeftFlowLayout.init()
        flowlayout.scrollDirection = .vertical
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10
        
        let value = JTBaseDataCollectionView<JTBalanceItemCell>.init(frame: .zero, collectionViewLayout: flowlayout)
        value.cellID = "myCollectionVID"
        value.layer.borderWidth = 2
        value.layer.borderColor = UIColor.green.cgColor
        return value
    }()
    
    var btn: UIButton = {
        let value = UIButton()
        value.setTitle("setData", for: .normal)
        value.backgroundColor = .red
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        creatUI()
        
        setData()
    }
    
    func creatUI()  {
        view.addSubview(myTableV)
        view.addSubview(horizontalCollectionV)
        view.addSubview(verticalCollectionV)
        view.addSubview(btn)
        
        myTableV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview().inset(15)
//            make.height.equalTo(50)
        }
        
        horizontalCollectionV.snp.makeConstraints { make in
            make.top.equalTo(myTableV.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        verticalCollectionV.snp.makeConstraints { make in
            make.top.equalTo(horizontalCollectionV.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
        }
        
        btn.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        btn.addTap { [weak self] in
            guard let wSelf = self else {
                return
            }
            wSelf.setData()
        }
    }
    
    func setData() {
        let randomNum = (1...Int.random(in: 1...5))
        if myTableV.dataList.isEmpty {
            myTableV.dataList = randomNum.map { item in
                let model = JTBalanceModel()
                model.title = "\(randomNum.map({_ in return "6"}).joined(separator: ""))"
                return model
            }
            print("myTableV: \(self.myTableV.contentSize) | \(randomNum.count * 35)")
        }
        
        horizontalCollectionV.dataList = (1...Int.random(in: 1...2)).reversed().map { item in
            let model = JTBalanceModel()
            model.title = "\((1...Int.random(in: 1...15)).map({_ in return item.description}).joined(separator: ""))"
            return model
        }
        
        print("horizontalCollectionV contentSize: \(self.horizontalCollectionV.contentSize)")
        
        verticalCollectionV.dataList = (1...Int.random(in: 1...15)).reversed().map { item in
            let model = JTBalanceModel()
            model.title = "\((1...Int.random(in: 1...15)).map({_ in return item.description}).joined(separator: ""))"
            return model
        }
        
        print("verticalCollectionV contentSize: \(self.verticalCollectionV.contentSize)")
        
    }
        
}
