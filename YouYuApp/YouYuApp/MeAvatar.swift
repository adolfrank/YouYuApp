//
//  MeAvatar.swift
//  YouYuApp
//
//  Created by Hongbo Yu on 16/3/29.
//  Copyright © 2016年 Frank. All rights reserved.
//

import UIKit

class MeAvatar: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 40
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 2
        self.clipsToBounds = true
    }

}
