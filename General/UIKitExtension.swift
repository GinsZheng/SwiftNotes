//
//  AddStyleAttribute.swift
//  MySwift
//
//  Created by GinsMac on 2019/6/2.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func set(superview: UIView) {
        superview.addSubview(self)
    }
    
    func set(superview: UIView, backgroundColor: String) {
        superview.addSubview(self)
        self.setBackgroundColor(color: backgroundColor)
    }
    
    func setShadow(color: String, x: CGFloat, y: CGFloat, radius: CGFloat) {
        self.layer.shadowColor = UIColor.hex(color).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = radius
    }
    
    func setBorder(color: String, borderWidth: CGFloat) {
        self.layer.borderColor = UIColor.hex(color).cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setCornerRadiusWithoutMask(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func setCornerRadius(radius: CGFloat, corners: UIRectCorner) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
    }

    func setBackgroundColor(color: String) {
        self.backgroundColor = UIColor.hex(color)
    }
    
    func setSeparator(leftInset: CGFloat, rightInset: CGFloat, color: String = "1A000820") {
        let separator = UIView()
        self.addSubview(separator)
        separator.setFrame(left: leftInset, bottom: 0, width: kScreenWidth - leftInset - rightInset, height: kSeparatorHeight)
        separator.backgroundColor = UIColor.hex(color)
    }
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set {
            self.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set {
            self.frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        } set {
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        } set {
            self.frame.size.height = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        } set {
            self.center.x = newValue
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y
        } set {
            self.center.y = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
    }
    
    var bottom: CGFloat {
        get {
            return y + height
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        } set {
            self.frame.size = newValue
        }
    }
    
    var point: CGPoint {
        get {
            return self.frame.origin
        } set {
            self.frame.origin = newValue
        }
    }
}




extension UILabel {
    
    func set(superview: UIView, text: String) {
        self.text = text
        superview.addSubview(self)
    }
    
    func setFontStyle(size: CGFloat, color: String, weight: UIFont.Weight = UIFont.Weight.regular) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = UIColor.hex(color)
    }
    
//    func setLineHeight(multiple: CGFloat = 1.4) {
    func setLineHeight() {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = 1.4 / 1.2
        paragraph.lineSpacing = self.font.pointSize * 0.2
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraph]
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: attributes)
    }
    
    func getLabelWidth() -> CGFloat {
        let labelText = self.text! as NSString
        let size = CGSize(width: CGFloat(MAXFLOAT), height: self.frame.size.height)
        let textSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font!], context: nil).size
        return CGFloat(Int(textSize.width) + 1)
    }
    
    func getLabelWidth(withMaxWidth maxWidth: CGFloat) -> CGFloat {
        let labelText = self.text! as NSString
        let size = CGSize(width: CGFloat(MAXFLOAT), height: self.frame.size.height)
        let textSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font!], context: nil).size
        var labelWidth = CGFloat(Int(textSize.width) + 1)
        if labelWidth > maxWidth {
            labelWidth = maxWidth
        }
        return labelWidth
    }
    
    func getLabelHeight(withWidth width: CGFloat) -> CGFloat {
        _ = self.text! as NSString
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let height = self.sizeThatFits(size).height
        return CGFloat(Int(height) + 1)
    }
    
    func getDefaultLineheight() -> CGFloat {
        return round(self.font.pointSize * 1.4)
    }
}



extension UITextView {
    
    func set(superview: UIView, text: String) {
        self.text = text
        superview.addSubview(self)
    }
    
    func setFontStyle(size: CGFloat, color: String, weight: UIFont.Weight = UIFont.Weight.regular) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = UIColor.hex(color)
    }
    
    func setLineHeight(lineHeight: CGFloat = 1.4, text: String) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = lineHeight / 1.2
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraph]
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }

}



extension UITextField {
    
    func set(superview: UIView, placeholder: String) {
        self.placeholder = placeholder
        superview.addSubview(self)
    }
    
    var placeholderColor:UIColor {
        get{
            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
            if(color == nil){
                return UIColor.white;
            }
            return color as! UIColor;
        } set{
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    func setTextLeftPadding(left: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.height))
        self.leftViewMode = .always
    }
    
    func setTextRightPadding(right: CGFloat) {
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.height))
        self.rightViewMode = .always
    }
    
    func setTextPadding(left: CGFloat, right: CGFloat) {
        self.setTextLeftPadding(left: left)
        self.setTextRightPadding(right: right)
    }
}



extension UIImageView {
    
    func set(superview: UIView, imageName: String) {
        self.image = UIImage(named: imageName)
        superview.addSubview(self)
    }
}


extension UIImage {
    
    func changeColor(color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: self.cgImage!);
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

    
extension UIButton {
    func set(superview: UIView, target: Any?, action: Selector, forEvent: UIControl.Event = UIControl.Event.touchUpInside) {
        superview.addSubview(self)
        self.addTarget(target, action: action, for: forEvent)
    }
}


extension UIViewController {
    // depreciated ➤ push指从右向左滑入页面
    func pushFromRootPage(toTarget: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(toTarget, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    // depreciated ➤ push from secondary or deeper page
    func pushFromSecondaryPage(toTarget: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(toTarget, animated: true)
    }
    
    func push(toTarget: UIViewController) {
        self.navigationController?.pushViewController(toTarget, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // present()为从下向上滑入页面，dismiss()为从向上向下滑出页面
    func present(toTarget: UIViewController, completion: @escaping () -> Void = {}) {
        self.present(toTarget, animated: true, completion: completion)
    }
    
    func unpresent(completion: @escaping () -> Void = {}) {
        self.dismiss(animated: true, completion: completion)
    }
    
    func hideNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getTabBarHeight() -> CGFloat {
        return self.tabBarController?.tabBar.bounds.size.height ?? 0
    }
    
    func getSafeAreaHeight() -> CGFloat {
        return kScreenHeight - kNavBarHeight - self.getTabBarHeight()
    }
}


extension String {
    func removeFirstCharacter() -> String {
        return String(self[self.index(after: self.startIndex)...])
    }
    
    func removeFrontCharacters(length: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: length-1)])
    }
    
}


extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
