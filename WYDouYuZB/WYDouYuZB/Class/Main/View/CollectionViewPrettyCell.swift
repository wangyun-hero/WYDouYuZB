//
//  CollectionViewPrettyCell.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/26.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit

class CollectionViewPrettyCell: UICollectionViewCell {
    @IBOutlet weak var backImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backImageView.layer.cornerRadius = 10
        backImageView.layer.masksToBounds = true
    }

}
