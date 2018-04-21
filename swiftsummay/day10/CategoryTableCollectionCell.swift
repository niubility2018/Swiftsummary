//
//  CategoryTableCollectionCell.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/20.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class CategoryTableCollectionCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.layer.cornerRadius = 20
        self.titleLabel.layer.masksToBounds = true
        self.titleLabel.font = UIFont.systemFont(ofSize: 13)
        self.titleLabel.backgroundColor = UIColor.randomColor()
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .white
    }

}
