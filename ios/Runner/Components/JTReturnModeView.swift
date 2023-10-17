//
//  JTReturnModeView.swift
//  Runner
//
//  Created by yl on 2023/10/16.
//

import UIKit

class JTReturnModeView: UIView {

    @IBOutlet weak var firstCode: UILabel!
    @IBOutlet weak var scondCode: UILabel!
    @IBOutlet weak var barcodeImgV: UIImageView!
    @IBOutlet weak var barcode: UILabel!
    @IBOutlet weak var recipientInfo: UILabel!
    @IBOutlet weak var senderInfo: UILabel!
    @IBOutlet weak var qrcodeImgV: UIImageView!
    @IBOutlet weak var typeInfo: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var dateInfo: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let contentV = Bundle.main.loadNibNamed("JTReturnModeView", owner: self)?.last as? UIView else {
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
    
    func setData()  {
        
    }
    
}
