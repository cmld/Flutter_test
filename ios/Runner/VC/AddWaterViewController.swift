//
//  AddWaterViewController.swift
//  Runner
//
//  Created by yl on 2023/11/1.
//

import UIKit

class AddWaterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgV = UIImageView(frame: self.view.bounds)
        
//        let text = "31.220655,121.209302\n2023-11-01 11:34:47 (GMT+08:00)\nYoyi Station 黄萱UAT 驿站测试1(ID30000001)"
        let text = "31.220655,121.209302 2023-11-01 11:34:47 (GMT+08:00) Yoyi Station 黄萱UAT 驿站测试1(ID30000001)"
        imgV.image = UIImage(named: "sigimage")?.addW(text: text)
        self.view.addSubview(imgV)
        
        // Do any additional setup after loading the view.
    }
}
