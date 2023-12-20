//
//  JTHandoverModeView.swift
//  Runner
//
//  Created by yl on 2023/12/14.
//

import UIKit

class JTHandoverModeView: UIView {
    @IBOutlet weak var tilteLB: UILabel!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var optionDateTime: UILabel!
    @IBOutlet weak var optionerName: UILabel!
    
    @IBOutlet weak var payType: UILabel!
    @IBOutlet weak var numLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    
    @IBOutlet weak var cashType: UILabel!
    @IBOutlet weak var cashNum: UILabel!
    @IBOutlet weak var cashPrice: UILabel!
    
    @IBOutlet weak var pmType: UILabel!
    @IBOutlet weak var pmNum: UILabel!
    @IBOutlet weak var pmPrice: UILabel!
    
    @IBOutlet weak var ccCashType: UILabel!
    @IBOutlet weak var ccCashNum: UILabel!
    @IBOutlet weak var ccCashPrice: UILabel!
    
    @IBOutlet weak var totalLb: UILabel!
    @IBOutlet weak var totalNum: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var qrImageV: UIImageView!
    
    @IBOutlet weak var signTitle: UILabel!
    @IBOutlet weak var signTips: UILabel!
    
    @IBOutlet weak var tipsLb: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let contentV = Bundle.main.loadNibNamed("JTHandoverModeView", owner: self)?.last as? UIView else {
            return
        }
        contentV.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        contentV.layer.borderWidth = 1
        contentV.layer.borderColor = UIColor.black.cgColor
        self.addSubview(contentV)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent() {
        tilteLB.text = "交接单"
        
        stationName.text = "驿站名称：" + "Yoyi Station SUPERMALL KARAWACI"
        optionDateTime.text = "打印时间："+"2023-11-12  08:12:12"
        optionerName.text = "操作员："+"HONG HUIQING（62123456789）"
        
        payType.text = "结算方式"
        numLb.text = "数量"
        priceLb.text = "金额(IDR)"
        
        cashType.text = "PP_CASH"
        cashNum.text = "99"
        cashPrice.text = "7,988,6333.564"
        
        pmType.text = "PP_PM"
        pmNum.text = "92"
        pmPrice.text = "7,988,111.564"
        
        ccCashType.text = "PP_PM"
        ccCashNum.text = "444"
        ccCashPrice.text = "7,982,622.564"
        
        totalLb.text = "合计"
        totalNum.text = "4422"
        totalPrice.text = "7,982,622.222"
        
        qrImageV.image = UIImage(named: "home_send_set")
        
        signTitle.text = "收派员签名区"
        signTips.text = "请签名"
        
        tipsLb.text = "驿站APP扫码可查看交接明细"
    }
    
}

class DashedLineLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        addDashedLine()
    }

    func addDashedLine() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = textColor.cgColor // 使用文本颜色作为虚线颜色
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4, 2]  // 设置虚线的样式

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.size.height))
        path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))

        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
    }
}

class DashedBorderView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        addDashedBorder()
    }

    func addDashedBorder() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4, 2, 2, 2]  // 设置虚线的样式

        let path = UIBezierPath(rect: bounds)
        shapeLayer.path = path.cgPath

        layer.addSublayer(shapeLayer)
    }
}
