//
//  CustomPopupWindow.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/5.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSCustomPopupWindow: UIViewController {
    
    var bgImage = UIImage()
    
    let bgImageView = UIImageView()
    
    let maskView = UIView()
    let bgView = UIView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let addingButton = UIButton()
    let cancelButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bgImageView.set(superview: view, image: bgImage)
        bgImageView.setFrame(left: 0, top: kNavBarHeight, width: bgImage.size.width, height: bgImage.size.height)
        
        maskView.set(superview: view, backgroundColor: c04040F_40_mask)
        maskView.setFrame(allEdges: 0)

        bgView.set(superview: maskView, backgroundColor: cFFF)
        bgView.setCornerRadius(radius: 8)
        bgView.setFrame(center: maskView, width: 270, height: 184)

        titleLabel.set(superview: bgView, text: "添加上次")
        titleLabel.setStyle20pt222MedCenter()
        titleLabel.setFrame(centerX: bgView.centerX - bgView.x, top: 20)

        messageLabel.set(superview: bgView, text: "说明内容")
        messageLabel.setStyle14pt666Center()
        messageLabel.setFrame(centerX: titleLabel.centerX, top: titleLabel.bottom + 8)
        
        addingButton.set(superview: bgView, target: self, action: #selector(confirm))
        addingButton.setStyleSolidAddingBtn(title: "添加")
        addingButton.setFrame(left: 20, top: messageLabel.bottom + 16, right: 20, height: 48)
        
        cancelButton.set(superview: bgView, target: self, action: #selector(cancel))
        cancelButton.setStyleCutsomCancelBtn(title: "放弃")
        cancelButton.setFrame(centerX: bgView.centerX - bgView.x, top: addingButton.bottom + 12, width: 44, height: 20)
        cancelButton.extendTouchArea()
    }
    
    @objc func confirm() {
        print("heheda")
        self.present(toTarget: CSGeneralSubpage())
    }
    
    @objc func cancel() {
        print("cancel")
        self.dismiss()
    }
}
