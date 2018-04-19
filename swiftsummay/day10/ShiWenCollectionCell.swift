//
//  ShiWenCollectionCell.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/18.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import SnapKit
class ShiWenCollectionCell: UICollectionViewCell {
    lazy var imageV = UIImageView()
    lazy var titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.contentView.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalTo(self.contentView.center.x)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        let image = UIImage(named: "33");
        imageV.layer.cornerRadius = 40
        imageV.layer.masksToBounds = true
        imageV.image = image
        
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageV.snp.bottom).offset(5)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-5)
        }
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.text = "李白"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
