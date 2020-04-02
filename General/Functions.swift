//
//  GlobalFunction.swift
//  MySwift
//
//  Created by GinsMac on 2019/6/4.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import Foundation
import UIKit

func getImageWithColor(color: String) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(UIColor.hex(color).cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}

func getImageFromView(view:UIView) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(view.size, false, kScale)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}


// 按比例布局的因子
func s(_ number: CGFloat) -> CGFloat {
    return number / 375 * kScreenWidth
}

func u(_ number: CGFloat) -> CGFloat {
    return number / kScreenWidth * 375
}


// 时间戳转成字符串
func getTimeStrWithTimeStamp(timeStamp:TimeInterval, dateFormat:String = "yyyy/M/d HH:mm:ss") -> String {
    let date:NSDate = NSDate.init(timeIntervalSince1970: timeStamp)
    let formatter = DateFormatter.init()
    formatter.dateFormat = dateFormat
    return formatter.string(from: date as Date)
}

// 字符串转时间戳
func getTimeStampWithTimeStr(timeStr: String, dateFormat:String) -> Double {
    let format = DateFormatter.init()
    format.dateStyle = .medium
    format.timeStyle = .short
    format.dateFormat = dateFormat
    let date = format.date(from: timeStr)
    return date!.timeIntervalSince1970
}

// date类型转时间戳
func getTimeStampWithDate(date: Date) -> Double {
    return date.timeIntervalSince1970
}

// 时长格式
func getDurationStrHHMMSS(secounds: TimeInterval) -> String {
    if secounds.isNaN {
        return "00:00"
    }
    var Min = Int(secounds / 60)
    let Sec = Int(secounds.truncatingRemainder(dividingBy: 60))
    var Hour = 0
    if Min >= 60 {
        Hour = Int(Min / 60)
        Min = Min - Hour*60
        return String(format: "%d:%02d:%02d", Hour, Min, Sec)
    }
    return String(format: "%02d:%02d", Min, Sec)
}

func round(_ value: Double, decimalPlaces: Int) -> Double {
    let divisor = pow(10.0, Double(decimalPlaces))
    return (value * divisor).rounded() / divisor
}

func floor(_ value: Double, decimalPlaces: Int = 0) -> Double {
    let divisor = pow(10.0, Double(decimalPlaces))
    return Double(Int(value * divisor)) / divisor
}
