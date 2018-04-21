//
//  CategoryDetailViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/18.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import GTMRefresh
class CategoryDetailViewController: UIViewController {
    //显示分类列表的tableView
    var tableView: UITableView!
    var categoryListModel: CategoryListModel!
    var gushiwens:Array<GuShiWen>? = []
    var currentPage: Int = 0
    
    
    let cellIndetifier = "categoryDetailListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        //创建表视图
        self.currentPage = 1
        loadData(page: self.currentPage)
        creatTableView()
    }
    
    func loadData(page:Int) {
        print("---------当前是页码--------",page)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Network.requestTool(Httpbin.shiwenlist(n: "1949558840", tstr: self.title!, page: page, pwd: "", id: 0, token: "gswapi"), success: { (dict) in
            MBProgressHUD.hide(for: self.view, animated: false)
            print("=================:",dict)
            if let categoryListModel = CategoryListModel.deserialize(from: dict) {
                self.categoryListModel = categoryListModel
                self.gushiwens = self.gushiwens! + categoryListModel.gushiwens!
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, error: { (statusCode) in
            MBProgressHUD.hide(for: self.view, animated: false)
            //服务器报错等问题
            print("请求错误！错误码：\(statusCode)")
        }) { (error) in
            //没有网络等问题
            MBProgressHUD.hide(for: self.view, animated: false)
            print("请求失败！错误信息：\(error.errorDescription ?? "")")
        }
    }
    
    func creatTableView() {
        self.tableView = UITableView(frame:self.view.bounds, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        
        let nib = UINib.init(nibName: "CategoryDetailListCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIndetifier)
        self.view.addSubview(self.tableView!)
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRereshing))
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshing))
        
    }
    
    @objc func headerRereshing()  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            DispatchQueue.main.async {
            self.currentPage = 1
            self.loadData(page: self.currentPage)
            self.tableView.mj_header.endRefreshing()
//            }
        }
        
    }
    
    @objc func footerRefreshing() {
        self.currentPage += 1
        self.loadData(page: self.currentPage)
        self.tableView.mj_footer.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CategoryDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gushiwens!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath) as! CategoryDetailListCell
        let gushiwen = self.gushiwens![indexPath.row]
        cell.renderCell(gushiwen: gushiwen)
        return cell
    }
}
extension CategoryDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gushiwen = self.gushiwens![indexPath.row]
        let shiwendvc = ShiWenDetailViewController()
        shiwendvc.idStr = gushiwen.idnew
        self.navigationController?.pushViewController(shiwendvc, animated: true)
        
    }
}

