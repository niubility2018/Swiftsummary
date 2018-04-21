//
//  CategoryTableAndCollectionCell.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/20.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

@objc protocol CategoryTableAndCollectionTableCellDelegate {
    func didSelectIndexPath(item: NSInteger, title: String)
}

class CategoryTableAndCollectionTableCell: UITableViewCell {
    
    
    //普通的flow流式布局
    var flowLayout:UICollectionViewFlowLayout!
    
    var collectionView:UICollectionView!
    let CELL_ID = "collection_id"
    
    weak var delegate: CategoryTableAndCollectionTableCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWitdh, height: 50), collectionViewLayout: flowLayout)
        collectionView!.backgroundColor = .white;
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
//        collectionView!.register(CategoryTableCollectionCell.self, forCellWithReuseIdentifier: CELL_ID);
        
        let nib = UINib.init(nibName: "CategoryTableCollectionCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: CELL_ID)
    
        self.contentView.addSubview(collectionView!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CategoryTableAndCollectionTableCell: UICollectionViewDelegate {
    //item 对应的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index is \(indexPath.row)")
        let categoryTableCollectionCell = collectionView.cellForItem(at: indexPath) as! CategoryTableCollectionCell
        
        if let delegateOK = self.delegate {
            delegateOK.didSelectIndexPath(item: indexPath.row, title: categoryTableCollectionCell.titleLabel.text!)
        }
    }
}

extension CategoryTableAndCollectionTableCell: UICollectionViewDataSource {
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    //返回 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath) as! CategoryTableCollectionCell;
        if indexPath.item == 0 {
            cell.titleLabel.text = "翻译"
        }else if indexPath.item == 1 {
            cell.titleLabel.text = "赏析"
        }
        else {
            cell.titleLabel.text = "作者"
        }
        return cell
    }
}
extension CategoryTableAndCollectionTableCell: UICollectionViewDelegateFlowLayout {
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:kScreenWitdh / 3.0 ,height: 50 )
    }
}

