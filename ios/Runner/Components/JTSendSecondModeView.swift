//
//  JTSendSecondModeView.swift
//  Runner
//
//  Created by yl on 2023/12/14.
//

import UIKit

class JTSendSecondModeView: UIView {

    @IBOutlet weak var barcodeImgV: UIImageView!
    @IBOutlet weak var waycodeLb: UILabel!
    @IBOutlet weak var senderLb: UILabel!
    @IBOutlet weak var recipientLb: UILabel!
    
    @IBOutlet weak var addressLb: UILabel!
    
    @IBOutlet weak var payType: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var expressType: UILabel!
    @IBOutlet weak var settleType: UILabel!
    @IBOutlet weak var shipLb: UILabel!
    @IBOutlet weak var expLb: UILabel!
    
    @IBOutlet weak var costTitle: UILabel!
    @IBOutlet weak var costNum: UILabel!
    @IBOutlet weak var costTips: UILabel!
    
    @IBOutlet weak var infoLb: UILabel!
    @IBOutlet weak var noteLb: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let contentV = Bundle.main.loadNibNamed("JTSendSecondModeView", owner: self)?.last as? UIView else {
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
        
        barcodeImgV.image = UIImage(named: "")
        waycodeLb.text = "JP6792895040"
        
        senderLb.text = "Pengirim: Carpax Store,6287886617714"
        recipientLb.text = "Penerima: Edy gumawan, 3281255589173"
        addressLb.text = "MURUNG RAYA, LAUNG TUHUP,JI Isran as rt 006 kel muara tuhuUP"
        addressLb.sizeToFit()
        
        payType.text = "COD：1,888,223.90"
        weight.text = "99.3KG"
        expressType.text = "EZ"
        settleType.text = "BULANAN"
        shipLb.text = "Ship: 15-04-2022"
        expLb.text = "Exp:22-09-2020"
        
        costTitle.text = "TOTAL Biaya"
        costNum.text = "IDR 1,827,982.00"
        costTips.text = "Sudah Termasuk PPN"
        
        infoLb.text = "Qty:14 pcs, Barang:Tissue Super Magic Man isi 6 sachet"
        noteLb.text = "Note:LCS16499808736458685"
    }
}
