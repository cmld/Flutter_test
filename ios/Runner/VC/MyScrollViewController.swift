//
//  MyScrollViewController.swift
//  Runner
//
//  Created by yl on 2023/12/26.
//

import UIKit

class MyScrollViewController: UIViewController {
    
    lazy var myTableV: JTBaseDataTableView<JTNoticeCell> = {
        let value = JTBaseDataTableView<JTNoticeCell>()
        value.cellID = "myTableVID"
        value.layer.borderWidth = 2
        value.layer.borderColor = UIColor.lightGray.cgColor
        value.separatorStyle = .none
        return value
    }()
    
    lazy var myCollectionV: JTBaseDataCollectionView<JTBalanceItemCell> = {
        let flowlayout = UICollectionViewLeftFlowLayout.init()
        flowlayout.scrollDirection = .vertical
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10
        
        let value = JTBaseDataCollectionView<JTBalanceItemCell>.init(frame: .zero, collectionViewLayout: flowlayout)
        value.cellID = "myCollectionVID"
        value.layer.borderWidth = 2
        value.layer.borderColor = UIColor.red.cgColor
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
        view.addSubview(myCollectionV)
        
        myTableV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(200)
        }
        
        myCollectionV.snp.makeConstraints { make in
            make.top.equalTo(myTableV.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
    }
    
    func setData() {
        myTableV.dataList.insert(contentsOf: (1...3).map { item in
            let model = JTBalanceModel()
            model.title = "\((1...Int.random(in: 1...15)).map({_ in return "6"}).joined(separator: ""))"
            return model
        }, at: 0)
        
        myCollectionV.dataList.insert(contentsOf: (1...10).map { item in
            let model = JTBalanceModel()
            model.title = "\((1...Int.random(in: 1...15)).map({_ in return "6"}).joined(separator: ""))"
            return model
        }, at: 0)
        
        print("myTableV: \(myTableV.contentSize)")
        print("myCollectionV: \(myCollectionV.contentSize)")
        
        myTableV.snp.updateConstraints { make in
            make.height.equalTo(myTableV.contentSize.height)
        }
        myCollectionV.snp.updateConstraints { make in
            make.height.equalTo(myCollectionV.contentSize.height)
        }
    }
        
}
