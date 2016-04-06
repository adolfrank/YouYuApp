//
//  AvatarImage.swift
//  11-day
//
//  Created by Hongbo Yu on 16/3/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

import UIKit

class AvatarImage: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        // self.layer.borderColor = UIColor.whiteColor().CGColor
        // self.layer.borderWidth = 0
        
    }

}
