//
//  CollectionController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/13.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class LoopCollectionController: UIViewController {
    
    //普通的flow流式布局
    var flowLayout:UICollectionViewFlowLayout!
//    //自定义的环形布局
//    var loopLayput:LoopCollectionViewLayout!
    
    //自定义的环形布局
    var linearLayput:LinearCollectionViewLayout!
    
    var collectionView:UICollectionView!
    
    //重用的单元格的Identifier
    let CellIdentifier = "myCell"
    
    //所有书籍数据
    var images = ["c#.png", "html.png", "java.png", "js.png", "php.png",
                  "react.png", "ruby.png", "swift.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化Collection View
        initCollectionView()
        
        //注册tap点击事件
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(handleTap(_:)))
        collectionView.addGestureRecognizer(tapRecognizer)
    }
    
    private func initCollectionView() {
        //初始化flow布局
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 60, height: 60)
        flowLayout.sectionInset = UIEdgeInsets(top: 74, left: 0, bottom: 0, right: 0)
        
        //初始化自定义布局
//        loopLayput = LoopCollectionViewLayout()
        
        //初始化自定义布局
        linearLayput = LinearCollectionViewLayout()
        
        //初始化Collection View
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: linearLayput)
        
        //Collection View代理设置
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        //注册重用的单元格
        let cellXIB = UINib.init(nibName: "MyCollectionViewCell", bundle: Bundle.main)
        collectionView.register(cellXIB, forCellWithReuseIdentifier: CellIdentifier)
        
        //将Collection View添加到主视图中
        view.addSubview(collectionView)
    }
    
    //点击手势响应
    @objc func handleTap(_ sender:UITapGestureRecognizer){
        if sender.state == UIGestureRecognizerState.ended{
            let tapPoint = sender.location(in: self.collectionView)
            //点击的是单元格元素
            if let  indexPath = self.collectionView.indexPathForItem(at: tapPoint) {
                //通过performBatchUpdates对collectionView中的元素进行批量的插入，删除，移动等操作
                //同时该方法触发collectionView所对应的layout的对应的动画。
                print("------")
                self.collectionView.performBatchUpdates({ () -> Void in
                    self.collectionView.deleteItems(at: [indexPath])
                    self.images.remove(at: indexPath.row)
                }, completion: nil)
                
            }
                //点击的是空白位置
            else{
                //新元素插入的位置（随机）
                let index = Int(arc4random_uniform(UInt32(images.count)))
                images.insert("xcode.png", at: index)
                self.collectionView.insertItems(at: [IndexPath(item: index, section: 0)])
            }
        }
    }
    
    //切换布局样式
    @IBAction func changeLayout(_ sender: Any) {
        self.collectionView.collectionViewLayout.invalidateLayout()
        //交替切换新布局
//        let newLayout = collectionView.collectionViewLayout
//            .isKind(of: LoopCollectionViewLayout.self) ? flowLayout : loopLayput
//        collectionView.setCollectionViewLayout(newLayout, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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



//Collection View数据源协议相关方法
extension LoopCollectionController: UICollectionViewDataSource {
    //获取分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //获取每个分区里单元格数量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //返回每个单元格视图
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //环形
//        //获取重用的单元格
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
//            CellIdentifier, for: indexPath) as! MyCollectionViewCell
//        //设置内部显示的图片
//        cell.imageView.image = UIImage(named: images[indexPath.item])
//        //设置遮罩
//        cell.imageView.layer.masksToBounds = true
//        //设置圆角半径(宽度的一半)，显示成圆形。
//        cell.imageView.layer.cornerRadius = cell.bounds.width/2
//        return cell
        
        //线性
        //获取重用的单元格
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            CellIdentifier, for: indexPath) as! MyCollectionViewCell
        //设置内部显示的图片
        cell.imageView.image = UIImage(named: images[indexPath.item])
        return cell
        
    }
}

//Collection View样式布局协议相关方法
extension LoopCollectionController: UICollectionViewDelegate {
    
}

