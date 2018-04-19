//
//  ShiWenViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/18.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit


class ShiWenViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //普通的flow流式布局
    var flowLayout:UICollectionViewFlowLayout!
    
    var collectionView:UICollectionView!
    
    //重用的单元格的Identifier
    let CELL_ID = "cell_id";
    let HEAD_ID = "head_id";
    
    let titArray = ["写景","咏物","春天","夏天","秋天","冬天","写雨","写雪","写风","写花","梅花","荷花","菊花","柳树","月亮","山水","写山","写水","长江","黄河","儿童","写鸟","写马","田园","边塞","地名","抒情","爱国","离别","送别","思乡","思念","爱情","励志","哲理","闺怨","悼亡","写人","老师","母亲","友情","战争","读书","惜时","婉约","豪放","诗经","楚辞","乐府","民谣","节日","春节","元宵节","寒食节","清明节","端午节","七夕节","中秋节","重阳节","忧国忧民","咏史怀古","宋词精选","小学古诗","初中古诗","高中古诗","小学文言文","初中文言文","高中文言文","古诗十九首","唐诗三百首","古诗三百首","宋词三百首","古文观止"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "分类"
        // Do any additional setup after loading the view.
        
        createCollectionView()
    }
    
    func createCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout();
      flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWitdh, height: UIScreen.main.bounds.height), collectionViewLayout: flowLayout)
        collectionView!.backgroundColor = .white;
        collectionView!.delegate = self;
        collectionView!.dataSource = self;
        
        collectionView!.register(ShiWenCollectionCell.self, forCellWithReuseIdentifier: CELL_ID);
        collectionView!.register(ShiWenSectionHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HEAD_ID);
        
        self.view.addSubview(collectionView!);
    }
    
    //MARK: - UICollectionView 代理
    
    //分区数
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3;
//    }
    
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titArray.count;
    }
    
    //返回 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath) as! ShiWenCollectionCell;
        cell.titleLabel.text = titArray[indexPath.item]
        return cell;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:kScreenWitdh / 4.0 ,height: kScreenWitdh / 4.0 );
    }
    
    //每个分区区头尺寸
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: kScreenWitdh, height: 40)
//    }
    
//    //返回区头、区尾实例
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        var headview = ShiWenSectionHeadView();
//
//        if kind == UICollectionElementKindSectionHeader {
//
//            headview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEAD_ID, for: indexPath as IndexPath) as! ShiWenSectionHeadView;
//
//        }
//
//        return headview;
//
//    }
    
    //item 对应的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index is \(titArray[indexPath.row])");
        let categoryvc = CategoryDetailViewController()
        categoryvc.title = titArray[indexPath.row]
        self.navigationController?.pushViewController(categoryvc, animated: true)
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
