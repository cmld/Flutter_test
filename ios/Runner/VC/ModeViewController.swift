//
//  ModeViewController.swift
//  Runner
//
//  Created by yl on 2023/12/14.
//

import UIKit

class ModeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        self.title = "面单"
        
//        let content = JTReturnModeView(frame: CGRect(x: 10, y: 100, width: 304, height: 400))
//        let content = JTHandoverModeView(frame: CGRect(x: 10, y: 100, width: 304, height: 400))
        let content = JTSendSecondModeView(frame: CGRect(x: 10, y: 100, width: 304, height: 200))
        content.setContent()
        view.addSubview(content)
        
        
    }
    
}
