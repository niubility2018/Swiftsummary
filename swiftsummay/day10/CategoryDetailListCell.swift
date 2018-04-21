//
//  CategoryDetailListCell.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/18.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class CategoryDetailListCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var authorLabel: UILabel!
    
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.titleLabel.textAlignment = .left
        self.authorLabel.font = UIFont.systemFont(ofSize: 13)
        self.authorLabel.textColor = UIColor.withHex(hexString: "999999")
        self.authorLabel.textAlignment = .left
        self.contentLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentLabel.textColor = UIColor.withHex(hexString: "999999")
        self.contentLabel.textAlignment = .left
    }
    
    func renderCell(gushiwen: GuShiWen) {
        self.titleLabel.text = gushiwen.nameStr
        self.authorLabel.text = "【\(gushiwen.chaodai!)】" + gushiwen.author!
        let contentStr = gushiwen.cont!.pregReplace(pattern: "<[^>]*>", with: "")

        self.contentLabel.text = contentStr
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
