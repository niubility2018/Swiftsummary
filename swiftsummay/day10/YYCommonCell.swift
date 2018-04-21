//
//  YYTextCell.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/20.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import YYText
import SnapKit
class YYCommonCell: UITableViewCell {
    
    var contentLabel: YYLabel!
    var htmlText: String?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupView()
        
    }
    
    func setupView() {
        self.contentLabel = YYLabel()
        self.contentView.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(10)
//            make.bottom.equalTo(-10)
            make.size.height.equalTo(10)
        }
       
        
    }
    
    func renderYYCommonCell(shiwenModel: GuShiWen) {
        self.htmlText = shiwenModel.cont
        do{
            let attrStr = try NSMutableAttributedString(data: (self.htmlText?.data(using: String.Encoding.unicode, allowLossyConversion: true)!)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            attrStr.yy_lineSpacing = 10
            attrStr.yy_font = UIFont.systemFont(ofSize: 15)
            attrStr.yy_alignment = .center
            self.contentLabel.attributedText = attrStr
//            var conStr = self.htmlText?.pregReplace(pattern: "<br />", with: "\n")
//            conStr = conStr?.pregReplace(pattern: "<p>", with: "")
//            self.contentLabel.text = conStr
            
            self.contentLabel.numberOfLines = 0
            self.contentLabel.snp.updateConstraints { (make) in
                make.size.height.equalTo(shiwenModel.cellHeight!)
            }
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func renderYYCommonCellWithFanYiAndShangXi(translationModel:TranslationModel) {
        do{
            let attrStr = try NSMutableAttributedString(data: (translationModel.cont.data(using: String.Encoding.unicode, allowLossyConversion: true)!), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            attrStr.yy_lineSpacing = 10
            attrStr.yy_font = UIFont.systemFont(ofSize: 15)
            attrStr.yy_alignment = .left
            self.contentLabel.attributedText = attrStr
            self.contentLabel.numberOfLines = 0
            self.contentLabel.snp.updateConstraints { (make) in
                make.size.height.equalTo(translationModel.cellHeight!)
            }
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func renderYYCommonCellWithAuthor(author:Author) {
        do{
            let attrStr = try NSMutableAttributedString(data: (author.cont!.data(using: String.Encoding.unicode, allowLossyConversion: true)!),options: [.documentType: NSAttributedString.DocumentType.html] ,documentAttributes: nil)
            attrStr.yy_lineSpacing = 10
            attrStr.yy_font = UIFont.systemFont(ofSize: 15)
            attrStr.yy_alignment = .left
            self.contentLabel.attributedText = attrStr
            self.contentLabel.numberOfLines = 0
            self.contentLabel.snp.updateConstraints { (make) in
                make.size.height.equalTo(author.cellHeight!)
            }
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
