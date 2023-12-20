//
//  TestModel.swift
//  Runner
//
//  Created by yl on 2023/12/5.
//

import Foundation
import HandyJSON

class JTBalanceModel: HandyJSON {
    var title: String?

    required init() {}
}

class JTBalanceItemCell: JTBaseDataCollectionCell<JTBalanceModel> {
    
    var titleV: UILabel = {
        let value = UILabel()
        value.textColor = .black
        value.font = UIFont.systemFont(ofSize: 14)
        value.textAlignment = .center
        value.backgroundColor = .white
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
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        addSubview(titleV)
        titleV.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(5)
            make.height.equalTo(25)
            make.width.greaterThanOrEqualTo(25)
        }
    }
    
    override func setContent(model: JTBalanceModel) {
        cellModel = model
        
        titleV.text = model.title ?? "empty"
    }
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.black.cgColor
        }
    }
}

class JTAutoScrollView: UIView {
    
    lazy var icon: UIImageView = {
        let value = UIImageView()
        value.image = UIImage(named: "home_send_set")
        return value
    }()
    
    lazy var scrollV: JTBaseDataTableView<JTBalanceModel, JTNoticeCell> = {
        let value = JTBaseDataTableView<JTBalanceModel, JTNoticeCell>()
        value.cellID = "JTNoticeCellID"
        value.separatorStyle = .none
        value.isScrollEnabled = false
        return value
    }()
    
    lazy var cancelIcon: UIImageView = {
        let value = UIImageView()
        value.image = UIImage(named: "addShelf")
        return value
    }()
    
    var timer: Timer?
    var currentIdx = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCellUI()
        
        timerFire()
    }
    
    func createCellUI() {
        
        addSubview(icon)
        addSubview(scrollV)
        addSubview(cancelIcon)
        
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.width.height.equalTo(12)
        }
        
        scrollV.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(5)
            make.height.equalTo(35)
        }
        
        cancelIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scrollV.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.width.height.equalTo(20)
        }
        
    }
    
    func timerFire()  {
        if (timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerAction() {
        currentIdx += 1
        scrollV.scrollToRow(at: IndexPath(row: currentIdx, section: 0), at: .top, animated: true)
        if currentIdx == scrollV.dataList.count-1 {
            currentIdx = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.scrollV.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    
    deinit {
        self.timer?.invalidate()
    }
}

class JTNoticeCell: JTBaseDataTableViewCell<JTBalanceModel> {
    lazy var contnetLb: UILabel = {
        let value = UILabel()
        value.textColor = .black
        value.font = UIFont.systemFont(ofSize: 16)
        return value
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        addSubview(contnetLb)
        contnetLb.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    override func setContent(model: JTBalanceModel) {
        contnetLb.text = model.title
    }
    
    
}
