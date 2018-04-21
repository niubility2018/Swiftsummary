//
//  ShiWenDetailViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/19.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import HandyJSON
import YYText
class ShiWenDetailViewController: UIViewController,CategoryTableAndCollectionTableCellDelegate {
    var tableView: UITableView!
    var idStr: String?
    var shiWenDetailModel: ShiWenDetailModel?

    let cellIndetifier = "commonTextCell"
    var selectTitleStr: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.selectTitleStr = "翻译"
        creatTableView()
        loadData(idNew: idStr!)
        
    }
    
    func loadData(idNew:String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Network.requestTool(Httpbin.shiwenDetail(idNew: idNew, token: "gswapi", random: 1626855374), success: { (dict) in
            MBProgressHUD.hide(for: self.view, animated: false)
            print(dict)
            if let shiWenDetailModel = ShiWenDetailModel.deserialize(from: dict) {
                print(shiWenDetailModel)
                self.shiWenDetailModel = shiWenDetailModel
                do{
                    let attrStr = try NSMutableAttributedString(data: (shiWenDetailModel.tb_gushiwen?.cont?.data(using: String.Encoding.unicode, allowLossyConversion: true)!)!,options: [.documentType: NSAttributedString.DocumentType.html] ,documentAttributes: nil)
                    attrStr.yy_lineSpacing = 10
                    attrStr.yy_font = UIFont.systemFont(ofSize: 15)
                    attrStr.yy_alignment = .center
                    let maxSize = CGSize(width: UIScreen.main.bounds.size.width-40, height: CGFloat(MAXFLOAT))
                    //计算文本尺寸
                    let layout = YYTextLayout.init(containerSize: maxSize, text: attrStr)
                    let introHeight = layout?.textBoundingSize.height
                    print(CGFloat(introHeight!))
                    self.shiWenDetailModel?.tb_gushiwen?.cellHeight = introHeight
            
                    for item in (self.shiWenDetailModel?.tb_fanyis?.fanyis)! {
                        let attrStr = try NSMutableAttributedString(data: (item.cont.data(using: String.Encoding.unicode, allowLossyConversion: true)!),options: [.documentType: NSAttributedString.DocumentType.html] ,documentAttributes: nil)
                        attrStr.yy_lineSpacing = 10
                        attrStr.yy_font = UIFont.systemFont(ofSize: 15)
                        attrStr.yy_alignment = .left
                        let maxSize = CGSize(width: UIScreen.main.bounds.size.width-40, height: CGFloat(MAXFLOAT))
                        //计算文本尺寸
                        let layout = YYTextLayout.init(containerSize: maxSize, text: attrStr)
                        let introHeight = layout?.textBoundingSize.height
                        print(CGFloat(introHeight!))
                        item.cellHeight = introHeight
                    }
                    
                    for item in (self.shiWenDetailModel?.tb_shangxis?.shangxis)! {
                        let attrStr = try NSMutableAttributedString(data: (item.cont.data(using: String.Encoding.unicode, allowLossyConversion: true)!),options: [.documentType: NSAttributedString.DocumentType.html] ,documentAttributes: nil)
                        attrStr.yy_lineSpacing = 10
                        attrStr.yy_font = UIFont.systemFont(ofSize: 15)
                        attrStr.yy_alignment = .left
                        let maxSize = CGSize(width: UIScreen.main.bounds.size.width-40, height: CGFloat(MAXFLOAT))
                        //计算文本尺寸
                        let layout = YYTextLayout.init(containerSize: maxSize, text: attrStr)
                        let introHeight = layout?.textBoundingSize.height
                        print(CGFloat(introHeight!))
                        item.cellHeight = introHeight
                    }
                    
                    
                    
                }catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            self.tableView.reloadData()
        }, error: { (statusCode) in
            MBProgressHUD.hide(for: self.view, animated: false)
            //服务器报错等问题
            print("请求错误！错误码：\(statusCode)")
        }) { (error) in
            MBProgressHUD.hide(for: self.view, animated: false)
            //没有网络等问题
            print("请求失败！错误信息：\(error.errorDescription ?? "")")
        }
    }
    
    func creatTableView() {
        self.tableView = UITableView(frame:self.view.bounds, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        let nib = UINib.init(nibName: "CommonTextCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIndetifier)
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ShiWenDetailViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1 {
            return 1
        }else if section == 2 {
            if selectTitleStr == "翻译" {
                if self.shiWenDetailModel != nil {
                    return (self.shiWenDetailModel?.tb_fanyis?.fanyis?.count)!
                }else{
                    return 0
                }
            }else if selectTitleStr == "赏析" {
                if self.shiWenDetailModel != nil {
                    return (self.shiWenDetailModel?.tb_shangxis?.shangxis?.count)!
                }else{
                    return 0
                }
            }
            else {
                return 1
            }
        }
        else {
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath) as! CommonTextCell
                cell.selectionStyle = .none
                if self.shiWenDetailModel != nil {
                    cell.commonTextLabel.text = self.shiWenDetailModel?.tb_gushiwen?.nameStr
                    cell.commonTextLabel.textAlignment = .center
                    cell.commonTextLabel.font = UIFont.systemFont(ofSize: 20)
                }
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath) as! CommonTextCell
                cell.selectionStyle = .none
                if self.shiWenDetailModel != nil {
                    cell.commonTextLabel.text = "【" + (self.shiWenDetailModel?.tb_gushiwen?.chaodai)! + "】" + (self.shiWenDetailModel?.tb_gushiwen?.author)!
                    cell.commonTextLabel.textAlignment = .center
                    cell.commonTextLabel.font = UIFont.systemFont(ofSize: 13)
                }
                
                return cell
            }else{
                let yycommonCellIdentifier = "YYCommonCell"
                var cell = tableView.dequeueReusableCell(withIdentifier: yycommonCellIdentifier)  as? YYCommonCell
                cell?.selectionStyle = .none
                if cell == nil {
                    cell = YYCommonCell.init(style: .default, reuseIdentifier: yycommonCellIdentifier)
                }
                if self.shiWenDetailModel != nil {
                    cell?.renderYYCommonCell(shiwenModel: (self.shiWenDetailModel?.tb_gushiwen)!)
                }
                return cell!
            }
        }else if indexPath.section == 1 {
            let categoryTableAndCollectionTableCellIdentifier = "CategoryTableAndCollectionTableCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: categoryTableAndCollectionTableCellIdentifier)  as? CategoryTableAndCollectionTableCell
            cell?.selectionStyle = .none
            cell?.delegate = self
            if cell == nil {
                cell = CategoryTableAndCollectionTableCell.init(style: .default, reuseIdentifier: categoryTableAndCollectionTableCellIdentifier)
            }
            return cell!
        }else if indexPath.section == 2 {
            let yycommonCellIdentifier = "YYCommonCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: yycommonCellIdentifier)  as? YYCommonCell
            cell?.selectionStyle = .none
            if cell == nil {
                cell = YYCommonCell.init(style: .default, reuseIdentifier: yycommonCellIdentifier)
            }
            if selectTitleStr == "翻译" {
                if self.shiWenDetailModel != nil {
                    let fanyiModel = self.shiWenDetailModel?.tb_fanyis?.fanyis![indexPath.row]
                    
                    cell?.renderYYCommonCellWithFanYiAndShangXi(translationModel: fanyiModel!)
                }
            }else if selectTitleStr == "赏析" {
                if self.shiWenDetailModel != nil {
                    let shangxiModel = self.shiWenDetailModel?.tb_shangxis?.shangxis![indexPath.row]
                    cell?.renderYYCommonCellWithFanYiAndShangXi(translationModel: shangxiModel!)
                }
            }
            else {
                if self.shiWenDetailModel != nil {
                    
                }
            }
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath) as! CommonTextCell
            cell.selectionStyle = .none
            return cell
        }
    }
}
extension ShiWenDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 50
            }else if indexPath.row == 2 {
                if self.shiWenDetailModel != nil {
                    return (self.shiWenDetailModel?.tb_gushiwen?.cellHeight)! + 20
                }else{
                    return 0
                }
            }else{
                return 20
            }
        }else if indexPath.section == 1 {
            return 50
        }else if indexPath.section == 2 {
            if selectTitleStr == "翻译" {
                if self.shiWenDetailModel != nil {
                     let fanyiModel = self.shiWenDetailModel?.tb_fanyis?.fanyis![indexPath.row]
                    return (fanyiModel?.cellHeight)! + 20
                }else{
                    return 0
                }
            }else if selectTitleStr == "赏析" {
                if self.shiWenDetailModel != nil {
                    let shangxiModel = self.shiWenDetailModel?.tb_shangxis?.shangxis![indexPath.row]
                    return (shangxiModel?.cellHeight)! + 20
                }else{
                    return 0
                }
            }else{
                return 100
            }
        }
        else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let gushiwen = self.gushiwens![indexPath.row]
//        let shiwendvc = ShiWenDetailViewController()
//        shiwendvc.idStr = gushiwen.idnew
//        self.navigationController?.pushViewController(shiwendvc, animated: true)
        
    }
    
    func didSelectIndexPath(item: NSInteger, title: String) {
        print("点击了第\(item)个------\(title)")
        selectTitleStr = title
        let indexSet = IndexSet.init(integer: 2)
        self.tableView.reloadSections(indexSet, with: .none)
//        self.tableView.reloadData()
    }

}

