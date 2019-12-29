import Foundation
import SwiftUI
import UIKit

extension Color {
    static func hex(_ color: String) -> Color{
        var cstr = color.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString

        if cstr.hasPrefix("0X") {
            cstr = cstr.substring(from: 2) as NSString
        }
        if cstr.hasPrefix("#") {
            cstr = cstr.substring(from: 1) as NSString
        }
        if cstr.length != 3 && cstr.length != 6 && cstr.length != 8{
            return Color.clear;
        }
        
        var r: UInt64 = 0x0
        var g: UInt64 = 0x0
        var b: UInt64 = 0x0
        var a: UInt64 = 0x0
        var range = NSRange.init()
        
        if cstr.length == 3 {
            range.length = 1
            //r
            range.location = 0
            let rStr1 = cstr.substring(with: range)
            //g
            range.location = 1
            let gStr1 = cstr.substring(with: range)
            //b
            range.location = 2
            let bStr1 = cstr.substring(with: range)
            Scanner.init(string: rStr1).scanHexInt64(&r)
            Scanner.init(string: gStr1).scanHexInt64(&g)
            Scanner.init(string: bStr1).scanHexInt64(&b)
            return Color(red: Double(r * 16 + r) / 255, green: Double(g * 16 + g) / 255, blue: Double(b * 16 + b) / 255, opacity: 1)
        } else if cstr.length == 6 {
            range.length = 2
            //r
            range.location = 0
            let rStr = cstr.substring(with: range)
            //g
            range.location = 2
            let gStr = cstr.substring(with: range)
            //b
            range.location = 4
            let bStr = cstr.substring(with: range)
            Scanner.init(string: rStr).scanHexInt64(&r)
            Scanner.init(string: gStr).scanHexInt64(&g)
            Scanner.init(string: bStr).scanHexInt64(&b)
            return Color(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: 1)
        } else {
            range.length = 2
            //a
            range.location = 0
            let aStr = cstr.substring(with: range)
            //r
            range.location = 2
            let rStr = cstr.substring(with: range)
            //g
            range.location = 4
            let gStr = cstr.substring(with: range)
            //b
            range.location = 6
            let bStr = cstr.substring(with: range)

            Scanner.init(string: aStr).scanHexInt64(&a)
            Scanner.init(string: rStr).scanHexInt64(&r)
            Scanner.init(string: gStr).scanHexInt64(&g)
            Scanner.init(string: bStr).scanHexInt64(&b)
            return Color(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
        }
        
        
    }
}