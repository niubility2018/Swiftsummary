//
//  CollectionViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/2.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    var collectionView: UICollectionView!
    
    let courses = [
        ["name":"Swift","pic":"swift.png"],
        ["name":"Xcode","pic":"xcode.png"],
        ["name":"Java","pic":"java.png"],
        ["name":"PHP","pic":"php.png"],
        ["name":"JS","pic":"js.png"],
        ["name":"React","pic":"react.png"],
        ["name":"Ruby","pic":"ruby.png"],
        ["name":"HTML","pic":"html.png"],
        ["name":"C#","pic":"c#.png"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let layout = CustomLayout()
        let frame = CGRect(x:0, y:20, width: view.bounds.size.width,
                           height:view.bounds.height-20)
        
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //注册UICollectionViewCell
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ViewCell")
        
        //默认背景是黑色和label一致
        self.collectionView.backgroundColor = UIColor.white
        
        //设置collectionView的内边距
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5)
        
        self.view.addSubview(collectionView)
    }
    
    
    
    // CollectionView行数
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return courses.count;
    }
    
    // 获取单元格
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // storyboard里设计的单元格
        let identify:String = "ViewCell"
        // 获取设计的单元格，不需要再动态添加界面元素
        let cell = self.collectionView.dequeueReusableCell(
            withReuseIdentifier: identify, for: indexPath) as UICollectionViewCell
        //先清空内部原有的元素
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        // 添加图片
        let img = UIImageView(image: UIImage(named: courses[indexPath.item]["pic"]!))
        img.frame = cell.bounds
        img.contentMode = .scaleAspectFit
        // 图片上面显示课程名称，居中显示
        let lbl = UILabel(frame:CGRect(x:0, y:0, width:cell.bounds.size.width, height:20))
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        lbl.text = courses[indexPath.item]["name"]
        
        
        // 图片上面显示课程名称，居中显示
        let lbl1 = UILabel(frame:CGRect(x:0, y:50, width:cell.bounds.size.width, height:20))
        lbl1.textColor = UIColor.black
        lbl1.textAlignment = .center
        lbl1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        lbl1.text = String.init(format: "%d", indexPath.item)
        
        
        cell.addSubview(img)
        cell.addSubview(lbl)
        cell.addSubview(lbl1)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
