//
//  ShiWenDetailViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/19.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class ShiWenDetailViewController: UIViewController {
    var tableView: UITableView!
    var idStr: String?
    var shiWenDetailModel: ShiWenDetailModel?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        loadData(idNew: idStr!)
        creatTableView()
    }
    
    func loadData(idNew:String) {
        Network.requestTool(Httpbin.shiwenDetail(idNew: idNew, token: "gswapi", random: 1626855374), success: { (dict) in
            print(dict)
            
            if let shiWenDetailModel = ShiWenDetailModel.deserialize(from: dict) {
                print(shiWenDetailModel)
                self.shiWenDetailModel = shiWenDetailModel
            }
            self.tableView.reloadData()
        }, error: { (statusCode) in
            //服务器报错等问题
            print("请求错误！错误码：\(statusCode)")
        }) { (error) in
            //没有网络等问题
            print("请求失败！错误信息：\(error.errorDescription ?? "")")
        }
    }
    
    func creatTableView() {
        self.tableView = UITableView(frame:self.view.bounds, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        
        
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
        } else {
           return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cellIndetifier = "commonTextCell"
                let nib = UINib.init(nibName: "CommonTextCell", bundle: nil)
                self.tableView.register(nib, forCellReuseIdentifier: cellIndetifier)
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath) as! CommonTextCell
                cell.commonTextLabel.text = self.shiWenDetailModel?.tb_gushiwen?.nameStr
                return cell
            }else if indexPath.row == 1 {
                let cellIndetifier = "chaodaiTextCell"
                let nib = UINib.init(nibName: "CommonTextCell", bundle: nil)
                self.tableView.register(nib, forCellReuseIdentifier: cellIndetifier)
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath) as! CommonTextCell
//                cell.commonTextLabel.text = "【\(self.shiWenDetailModel?.tb_gushiwen?.chaodai! ?? "")】" + (self.shiWenDetailModel?.tb_gushiwen?.author)!
                return cell
            }else{
                let cellIndetifier = "commonTextCell"
                let nib = UINib.init(nibName: "CommonTextCell", bundle: nil)
                self.tableView.register(nib, forCellReuseIdentifier: cellIndetifier)
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath) as! CommonTextCell
                return cell
            }
        } else {
            let cellIndetifier = "commonTextCell"
            let nib = UINib.init(nibName: "CommonTextCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: cellIndetifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath) as! CommonTextCell
            return cell
        }
    }
}
extension ShiWenDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let gushiwen = self.gushiwens![indexPath.row]
//        let shiwendvc = ShiWenDetailViewController()
//        shiwendvc.idStr = gushiwen.idnew
//        self.navigationController?.pushViewController(shiwendvc, animated: true)
        
    }
}

