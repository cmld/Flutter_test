//
//  JTTableViewCell.swift
//  JTOSSUploader-iOS_Example
//
//  Created by yl on 2023/11/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class JTTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var ossImageV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
