//
//  MainViewController.swift
//  Runner
//
//  Created by yl on 2023/10/16.
//

import UIKit
import JTLocation_iOS

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "main start"
        // Do any additional setup after loading the view.
        let content = JTReturnModeView(frame: CGRect(x: 10, y: 100, width: 304, height: 400))
        view.addSubview(content)
    }
}
