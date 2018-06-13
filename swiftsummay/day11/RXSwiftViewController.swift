//
//  RXSwiftViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/6/12.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class RXSwiftViewController: UIViewController {

    var tableView: UITableView!
    
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        createTableView()
//        loadData()
        createUI()
    }
    
    func createUI() {
        self.label = UILabel(frame: CGRect(x: 50, y: 100, width: 300, height: 100))
        self.label.font = UIFont.systemFont(ofSize: 14)
        self.label.textColor = .black
        self.label.text = "xubojoy"
        self.view.addSubview(self.label)
//
//        //Observable序列（每隔1秒钟发出一个索引数）
//        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//
//        observable
//            .map { "当前索引数：\($0)"}
//            .bind { [weak self](text) in
//                //收到发出的索引数后显示到label上
//                self?.label.text = text
//            }
//            .disposed(by: disposeBag)
        
//          UIButton
//        let button = UIButton(type: .custom)
//        button.frame = CGRect(x: 50, y: 100, width: 100, height: 50)
//        button.setTitle("按钮", for: .normal)
//        button.setTitleColor(UIColor.blue, for: .normal)
//        self.view.addSubview(button)
//
//        //Observable序列（每隔1秒钟发出一个索引数）
//        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        observable
//            .map { $0 % 2 == 0 }
//            .bind(to: button.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable
            .map { CGFloat($0) }
            .bind(to: label.fontSize) //根据索引数不断变放大字体
            .disposed(by: disposeBag)
    }
    
    
    
    func createTableView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        let nib = UINib(nibName: "RXMusicCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "musicCell")
        self.view.addSubview(self.tableView)
    }
    
    func loadData() {
//        简单版
        //将数据源数据绑定到tableView上
//        musicListViewModel.data
//            .bind(to: tableView.rx.items(cellIdentifier:"musicCell")) { row, music, cell in
//                cell.textLabel?.text = music.name
//                cell.detailTextLabel?.text = music.singer
//            }.disposed(by: disposeBag)
        
        
        
//        进阶版
        let dataSource = RxTableViewSectionedReloadDataSource<MusicModel>(configureCell: { (dataSource, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath)
            cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
            return cell
        },//设置分区头标题
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].model
        })
        
        //绑定单元格数据
        musicListViewModel.items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

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

extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

extension Reactive where Base: UIControl {
    
    /// Bindable sink for `enabled` property.
    public var isEnabled: Binder<Bool> {
        return Binder(self.base) { control, value in
            control.isEnabled = value
        }
    }
}
