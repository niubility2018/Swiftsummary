//
//  RealmViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/11.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController {

    var imageView: UIImageView!
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        self.imageView = UIImageView(frame: CGRect(x: 50, y: 200, width: 100, height: 100))
        self.imageView.backgroundColor = .orange
        view.addSubview(self.imageView)
        
        
        let saveBtn = UIButton(type: .custom)
        saveBtn.frame = CGRect(x: 50, y: 64, width: 60, height: 50)
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.backgroundColor = .purple
        saveBtn.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
        view.addSubview(saveBtn)
        
        
        let readBtn = UIButton(type: .custom)
        readBtn.frame = CGRect(x: 150, y: 64, width: 60, height: 50)
        readBtn.setTitle("读取", for: .normal)
        readBtn.backgroundColor = .purple
        readBtn.addTarget(self, action: #selector(readBtnClick), for: .touchUpInside)
        view.addSubview(readBtn)
        
        
        //去除空格
        //原始字符串
        let str1 = "   欢迎访问 hangge.com   "
        let str2 = str1.trimmingCharacters(in: .whitespaces)
        
        print(str1)
        print(str2)
        
        //原始字符串
        let str3 = "欢迎🆚访问💓😄👌😆🙃:)(￣▽￣)hangge.com"
        //判断表情的正则表达式
        let pattern = "[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]"
        //替换后的字符串
        let str4 = str3.pregReplace(pattern: pattern, with: "")
        //打印结果
        print("原字符串：\(str3)")
        print("新字符串：\(str4)")
    }
    
    @objc func saveBtnClick() {
        let imageUrl = Bundle.main.url(forResource: "swift", withExtension: "png")
        let imageData = try! Data(contentsOf: imageUrl!)
        let portrait = HeadPortrait()
        portrait.data = imageData
        
        try! realm.write {
            realm.add(portrait)
        }
        
        print("数据保存完毕!")
    }
    
    @objc func readBtnClick() {
        
        let portraits = realm.objects(HeadPortrait.self).sorted(byKeyPath: "date", ascending: false)
        if portraits.count > 0 {
            if let imageDta = portraits[0].data{
                self.imageView.image = UIImage(data: imageDta)
            }
        }
        print("数据读取完毕!")
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
