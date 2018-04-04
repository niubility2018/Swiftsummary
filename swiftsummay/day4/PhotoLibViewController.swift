//
//  PhotoLibViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/4.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import AssetsLibrary
class PhotoLibViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    //资源库管理类
    var assetsLibrary =  ALAssetsLibrary()
    //保存照片集合
    var assets = [ALAsset]()
    
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width)/2, height: (UIScreen.main.bounds.size.width)/2)
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = .white
        self.collectionView?.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DesignViewCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        
        var countOne:Int = 0
        assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: { (group: ALAssetsGroup!, stop) in
            
            print("is goin")
            if group != nil
            {
                let assetBlock: ALAssetsGroupEnumerationResultsBlock = {(result: ALAsset!, index: Int, stop) in
                    if result != nil {
                        self.assets.append(result)
                        countOne += 1
                    }
                }
                group.enumerateAssets(assetBlock)
                
                print("assets:\(countOne)")
                //collectionView网格重载数据
                self.collectionView?.reloadData()
            }
            
        }) { (error: Error!) in
            print(error)
        }
       
    }
    
    
    // CollectionView行数
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return assets.count;
    }

    // 获取单元格
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // storyboard里设计的单元格
        let identify:String = "DesignViewCell"
        // 获取设计的单元格，不需要再动态添加界面元素
        let cell = (self.collectionView?.dequeueReusableCell(
            withReuseIdentifier: identify, for: indexPath as IndexPath))! as UICollectionViewCell
        
        //取缩略图
//        let myAsset = assets[indexPath.item]
//        let image = UIImage.init(cgImage: myAsset.thumbnail().takeUnretainedValue())
        
        //获取原图
//        let representation =  myAsset.defaultRepresentation()
//        let imageBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int((representation?.size())!))
//        let bufferSize = representation?.getBytes(imageBuffer,
//                                                  fromOffset: Int64(0),
//                                                  length: Int((representation?.size())!),
//                                                  error: nil)
//
//
//        let data =  NSData(bytesNoCopy:imageBuffer ,length:bufferSize!, freeWhenDone:true)
//
        
        
        
        let imgeView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.width/2))
//        imgeView.image = image
//        imgeView.image = UIImage(data: data as Data)
        cell.contentView.addSubview(imgeView)
        return cell
    }
    
    //每个分区区头尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 40)
    }
    
    //返回区头、区尾实
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headView", for: indexPath)
        return headview;
    }
    
    
    // 单元格点击响应
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myAsset = assets[indexPath.item]
        
        let vc = ImageDetailViewController()
        vc.myAsset = myAsset
        self.navigationController?.pushViewController(vc, animated: true)
        
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
