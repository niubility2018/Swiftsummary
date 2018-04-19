//
//  ShiWenSectionHeadView.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/18.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class ShiWenSectionHeadView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        label.text = "标题";
        self.addSubview(label);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
}
