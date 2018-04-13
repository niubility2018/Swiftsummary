//
//  ViewFactory.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/3.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class ViewFactory: NSObject {

    /**
     * 控件默认尺寸
     */
    class func getDefaultFrame() -> CGRect
    {
        let defaultFrame = CGRect(x: 0, y: 0, width: 100, height: 30)
        return defaultFrame
    }
    
    class func createControl(type:String, title:[String], action:Selector, sender:AnyObject)
        -> UIView {
            switch(type)
            {
            case "label":
                return ViewFactory.createLabel(title: title[0])
            case "button":
                return ViewFactory.createButton(title: title[0],
                                                sender: sender as! UIViewController)
            case "text":
                return ViewFactory.createTextField(value: title[0],
                                                   sender: sender as! UITextFieldDelegate)
            case "segment":
                return ViewFactory.createSegment(items: title, action: action, sender:
                    sender as! UIViewController)
            default:
                return ViewFactory.createLabel(title: title[0])
            }
    }
    
    /**
     * 创建按钮控件
     */
    class func createButton(title:String,sender:UIViewController)
        -> UIButton {
            let button = UIButton(frame:ViewFactory.getDefaultFrame())
            button.backgroundColor = UIColor.orange
            button.setTitle(title, for: .normal)
            button.titleLabel!.textColor = UIColor.white
            button.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            return button
    }
    
    /**
     * 创建文本输入框控件
     */
    class func createTextField(value:String, sender:UITextFieldDelegate)
        -> UITextField
    {
        let textField = UITextField(frame:ViewFactory.getDefaultFrame())
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.black
        textField.text = value
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = sender
        
        return textField
    }
    
    /**
     * 创建分段单选控件
     */
    class func createSegment(items: [String], action:Selector, sender:UIViewController)
        ->UISegmentedControl
    {
        let segment = UISegmentedControl(items:items)
        segment.frame = ViewFactory.getDefaultFrame()
        //segment.segmentedControlStyle = UISegmentedControlStyle.Bordered
        segment.isMomentary = false
        return segment
    }
    
    /**
     * 创建文本标签控件
     */
    class func createLabel(title:String) -> UILabel
    {
        let label = UILabel()
        label.textColor = UIColor.black;
        label.backgroundColor = UIColor.white;
        label.text = title;
        label.frame = ViewFactory.getDefaultFrame()
        label.font =  UIFont(name: "HelveticaNeue-Bold", size: 16)
        return label
    }
}
