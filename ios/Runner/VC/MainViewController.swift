//
//  MainViewController.swift
//  Runner
//
//  Created by yl on 2023/10/16.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "main start"
        // Do any additional setup after loading the view.
        let content = JTReturnModeView(frame: CGRect(x: 10, y: 100, width: 304, height: 400))
        view.addSubview(content)
        
        let content1 = BalanceAlertView(frame:.zero)
        view.addSubview(content1)
        
        content1.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        content1.cv.dataList.insert(contentsOf: (1...20).map { item in
            let model = JTBalanceModel()
            model.title = "\((1...Int.random(in: 3...15)).map({_ in return "6"}).joined(separator: ""))"
            return model
        }, at: 0)
        
        content1.cv.snp.updateConstraints { make in
            make.height.equalTo(content1.cv.contentSize.height)
        }
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1) {
            content1.snp.makeConstraints { make in
                make.top.equalTo(self.view.snp.bottom).inset(content1.cv.contentSize.height + 50 + 20)
            }
            self.view.layoutIfNeeded()
        }
    }
}

class BalanceAlertView:UIView {
    
    var cv: JTBaseDataCollectionView<JTBalanceModel, JTBalanceItemCell> = {
        let flowlayout = UICollectionViewLeftFlowLayout.init()
        flowlayout.scrollDirection = .vertical
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10
        
        let value = JTBaseDataCollectionView<JTBalanceModel, JTBalanceItemCell>.init(frame: .zero, collectionViewLayout: flowlayout)
        value.cellID = "JTBalanceItemCellID"
        return value
    }()
    
    var otherV: UIView = {
        let value = UIView()
        value.backgroundColor = .red
        return value
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        self.layer.cornerRadius = 10
        
        setupSubviews()
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(cv)
        addSubview(otherV)
        cv.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        
        otherV.snp.makeConstraints { make in
            make.top.equalTo(cv.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
