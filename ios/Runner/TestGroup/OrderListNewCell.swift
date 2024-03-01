//
//  OrderListNewCell.swift
//  Runner
//
//  Created by yl on 2024/2/28.
//

import UIKit

class OrderListNewCell: JTBaseDataTableViewCell {

    @IBOutlet weak var codeLb: UILabel!
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var senderCityLb: UILabel!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var statusLb: UILabel!
    @IBOutlet weak var receiveCityLb: UILabel!
    @IBOutlet weak var receiveName: UILabel!
    @IBOutlet weak var weightLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var tagLb: UILabel!
    @IBOutlet weak var optionsV: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .lightGray
        
        contentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 6
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setContent(model: JTBaseDataTableViewCell.D) {
        
        let optV = OptionsView(["附件上传", "编辑", "取消"])
        optV.actionCall = {[weak self] index in
            guard let `self` = self else { return }
            print("点击了 \(index)")
        }
        optionsV.addSubview(optV)
        optV.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
        }
    }
    
}


class DashedLineView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 2))
        UIColor.lightGray.setStroke()
        let dashes: [CGFloat] = [4, 4] // 设置虚线的样式，[实线长度, 间隔长度]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        path.stroke()
    }
}
