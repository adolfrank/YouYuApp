//
//  SelectedCell.swift
//  YouYuApp
//
//  Created by Adolfrank on 4/4/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

let width = UIScreen.mainScreen().bounds.width

class SelectedCell: UICollectionViewCell {
    
    @IBOutlet weak var selImage: UIImageView!
    
    @IBOutlet weak var selTitle: UILabel!
    
    @IBOutlet weak var selTag: UILabel!
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 4

    }
    
    
}
