//
//  BasicTheoryController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/3/30.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit


//通过重载加号运算符，使自定义的两个坐标结构体对象实现相加
struct CenterPointer {
    var x = 0,y = 0
    
}

func + (left: CenterPointer,right: CenterPointer) -> CenterPointer {
    return CenterPointer(x: left.x+right.x, y: left.y+right.y)
}

//重载判断运算符，实现判断自定义类型是否相等
func == (left: CenterPointer,right: CenterPointer) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

func != (left: CenterPointer,right: CenterPointer) -> Bool {
    return !(left==right)
}

//组合运算符，即将其他运算符和赋值运算符组合在一起，注意要把运算符左参数设置成inout类型
func += (left: inout CenterPointer,right: CenterPointer){
    left = left + right
}

enum Direction {
    case up
    case down
    
    func description() -> String {
        switch self {
        case .up:
            return "向上"
        case .down:
            return "向下"
        }
    }
}

/**
 static 与 class 的区别:
 
 static 可以在类、结构体、或者枚举中使用。而 class 只能在类中使用。
 static 可以修饰存储属性，static 修饰的存储属性称为静态变量(常量)。而 class 不能修饰存储属性。
 static 修饰的计算属性不能被重写。而 class 修饰的可以被重写。
 static 修饰的静态方法不能被重写。而 class 修饰的类方法可以被重写。
 class 修饰的计算属性被重写时，可以使用 static 让其变为静态属性。
 class 修饰的类方法被重写时，可以使用 static 让方法变为静态方法。
 
 */

//类 Class 的静态属性，静态方法也可以使用 static 关键字
class Account {
    var amount : Double = 0.0                 //账户金额
    var owner : String = ""                   //账户名
    
    static var interestRate : Double = 0.668  //利率
    
    static func interestBy(amount : Double) -> Double {
        return interestRate * amount
    }
    
    class var staticProp : Double {
        return 0.668
    }
    
//    class func interestBy(amount : Double) -> Double {
//        return 0.8886 * amount
//    }
}


class Calcuator {
    var a:Int = 1
    var b:Int = 1
    
    //vargetset 生成方法
//    var sum: Int {
//        get {
//            return a + b
//        }
//        set {
//            b = newValue - a
//        }
//    }
    
    //varget 只生成get方法
    var sum: Int {
        return a + b
    }
}


class A {
    fileprivate func test(){
        print("这是private")
    }
}

class B: A {
    func show() {
//        fileprivate不会报错   private会报错
        test()
    }
}

extension String{
    
}


class BasicTheoryController: UIViewController,UIScrollViewDelegate {
    var imageView:UIImageView!
   var scrollView:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        
        //获取1到100的随机数
        let temp = Int(arc4random()%100)+1
        print("-----------------\(temp)")
        let temp1 = Int(arc4random_uniform(100))+1
        print("-----------------\(temp1)")
        
        //倒序打印
        for icount in (1..<100).reversed() {
            print(icount)
        }
        
        //倒序打印字符串
        let str = "hello"
        print(String(str.reversed()))
        
        
        
        //使用区间运算符,字符串截取
        let words = "Hangge.com"
        let rangeStr = words[words.index(words.startIndex, offsetBy: 4)..<words.index(words.startIndex, offsetBy: 6)]
        print(rangeStr)
        
        
        let interval = "a"..."z"
        for c in words {
            if !interval.contains(String(c)){
                print("\(c)不是小写字母")
            }
        }
        
        
        
        var pointer = CenterPointer(x: 2, y: 3)
        let pointer1 = CenterPointer(x: 4, y: 5)
        //(1)
//        let pointer2 = pointer + pointer1
//        print("结果是----------------",pointer2.x,pointer2.y)
        //(2)
        pointer += pointer1
        print("结果是----------------",pointer.x,pointer.y)
        
        
        let types = ["none","warning","error"]  //省略类型的数组声明
        //数组
        var member = [String]()
        
        member.append("six") //添加元素
        member += ["seven"] //添加元素
        member.insert("one", at: 0) //指定位置添加元素
        print(member)
        
        member[0...2] = ["two", "three", "forth"];//通过小标区间替换数据（前3个数据）
        print(member)
        
        
        member.swapAt(1, 2)
        print(member)
        
//        member.removeAll()
//        print(member)
        
        let addStringArr = types + member //数组组合
        print(addStringArr)
        
        for (k, v) in member.enumerated() {
            print("第\(k)个元素是\(v)")
        }
        
        //过滤数组元素
        //$0 第一个元素   $0.count第一个元素的长度
        let newTypes = types.filter { $0.count < 5 }
        print(newTypes)
        
        //只有键序列、或者值序列创建字典
        let array = ["Monday", "Tuesday", "Wednesday"]
        
        let dict1 = Dictionary(uniqueKeysWithValues: zip(1..., array))
        let dict2 = Dictionary(uniqueKeysWithValues: zip(array, 1...))
        let dict = Dictionary(uniqueKeysWithValues: zip(array, 1...))
        
        print("dict1：\(dict1)")
        print("dict2：\(dict2)")
        print("dict：\(dict)")
        
        
        //字典分组（比如下面生成一个以首字母分组的字典）
        let names = ["Apple", "Pear", "Grape", "Peach"]
        
        let dict3 = Dictionary(grouping: names) { $0.first! }
        print(dict3)
        
        //zip配合速记+可以用来解决重复键的问题（相同的键值相加）
        let array1 = ["Apple", "Pear", "Pear", "Orange"]
        let dic = Dictionary(zip(array1, repeatElement(1, count: array1.count)), uniquingKeysWith: +)
        print(dic) // ["Pear": 2, "Orange": 1, "Apple": 1]
        
        
        //下面使用元组创建字典时，遇到相同的键则取较小的那个值
        let duplicatesArray = [("Monday", 30),  ("Tuesday", 25),  ("Wednesday", 27), ("Monday", 28)]
        let dic1 = Dictionary(duplicatesArray, uniquingKeysWith: min)
        print(dic1) // ["Monday": 28, "Tuesday": 25, "Wednesday": 27]
        
        
        var dic2 = ["one": 10, "two": 20]
        
        //merge方法合并
        let tuples = [("one", 5),  ("three", 30)]
        dic2.merge(tuples, uniquingKeysWith: min)
        print("dic2：\(dic2)")
        
        //merging方法合并
        let dic3 = ["one": 0, "four": 40]
        let dic4 = dic2.merging(dic3, uniquingKeysWith: min)
        print("dic4：\(dic4)")
        
        //我们可以直接指定一个默认值，如果不存在该键值时名，会直接返回这个值
        let dic5 = ["apple": 1, "banana": 2 ]
        let orange = dic5["orange",default:0]
        print(orange)
        
        //下面是统计一个字符串中所有单词出现的次数。可以看到了有了默认值，实现起来会简单许多。
        let str1 = "apple banana orange apple banana"
        var wordsCount: [String: Int] = [:]
        for word in str1.split(separator: " ") {
            wordsCount["\(word)", default:0] += 1
        }
        print(wordsCount)
        
        
        print(Direction.description(Direction.up)) //(Function)
        print(Direction.up.description()) //向上
        
        
        //Swift中不需要在case块中显示地使用break跳出switch。如果想要实现C风格的落入特性，可以给需要的case分支插入fallthrough语句
        let fruit = "apple"
        switch fruit{
        case "apple":
            print("good")
            fallthrough
        case "banana","orange":
            print("great")
        default:
            print("bad")
        }
        
        //case分支还可以进行区间匹配
        let age = 5
        switch age {
        case 0...11:
            print("正太")
        case 12...30:
            print("少年")
        default:
            print("大叔")
        }
        
        
        //case分支同样支持单侧区间匹配
        let num = 1
        switch num {
        case ..<0:
            print("负数")
        case 0:
            print("0")
        case 0...:
            print("正数")
        default:
            print("未知")
        }
        
        
        //使用元组匹配（判断属于哪个象限）
        let point = (2,2)
        switch point {
        case (0,0):
            print("坐标在原点")
        case (_,0):
            print("坐标在x轴上")
        case (0,_):
            print("坐标在y轴上")
        case (-3...3, -3...3):
            print("坐标在长宽为6的正方形内")
        default:
            print("在什么地方")
        }
        
        
        //case中还可以使用where关键字来做额外的判断条件
        let height = 1.72
        switch height{
        case 1...3 where height == 1.72:
            print("case 1")
        case 1...3 where height == 2:
            print("case 2")
        default:
            print("default")
        }
        
        
        //for-each循环
        (1...10).forEach {
            print($0)
        }
        
        var i = 0
        
//        while i<100 {
//            i+=1
//        }
        
        
        repeat{
            i += 1
            print(i)
        }while i<100
        
        
        //结构体 struct 和枚举 enum 的静态属性，静态方法使用 static 关键字
        struct Account {
            var amount : Double = 0.0                 //账户金额
            var owner : String = ""                   //账户名
            
            static var interestRate : Double = 0.668  //利率
            
            static func interestBy(amount : Double) -> Double {
                return interestRate * amount
            }
        }
        
        
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        
        let url = urlForDocument[0] as URL
        
        print(url)
        
        
        
        //创建一个ContactAdd类型的按钮
        let button:UIButton = UIButton(type:.contactAdd)
        //设置按钮位置和大小
        button.frame = CGRect(x:10, y:150, width:100, height:30)
        //设置按钮文字
        button.setTitle("按钮", for:.normal)
        self.view.addSubview(button)
        //不传递触摸对象（即点击的按钮）
//        button.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        
        //传递触摸对象（即点击的按钮），需要在定义action参数时，方法名称后面带上冒号
//        button.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
//        button.addTarget(self, action: #selector(BasicTheoryController.tapped(button:)), for: .touchUpInside)
        
        
//        imageView = UIImageView()
//        imageView.frame=CGRect(x:20, y:20, width:100, height:100)
//        //设置动画图片
//        imageView.animationImages = [UIImage(named:"face-2")!,UIImage(named:"face-3")!]
//        //设置每隔0.5秒变化一次
//        imageView.animationDuration=0.5
//        self.view.addSubview(imageView)
        
        scrollView = UIScrollView()
        //设置代理
        scrollView.delegate = self
        scrollView.frame = self.view.bounds
        let imageView = UIImageView(image:UIImage(named:"face-2"))
        scrollView.contentSize = imageView.bounds.size
        scrollView.addSubview(imageView)
        self.view.addSubview(scrollView)
        scrollView.minimumZoomScale = 0.1 //最小比例
        scrollView.maximumZoomScale = 3 //最大比例
        scrollView.delegate = self
        
    }
    
//    @objc func tapped() {
//
//    }
    
//    @objc func tapped(button:UIButton) {
//
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        imageView.startAnimating()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        imageView.stopAnimating()
//    }
    
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        for subview : AnyObject in scrollView.subviews {
            if subview.isKind(of: UIImageView.self) {
                return subview as? UIView
            }
        }
        return nil
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
