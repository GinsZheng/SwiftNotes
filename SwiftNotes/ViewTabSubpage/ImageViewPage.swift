//
//  ImageViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ImageViewPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let image = UIImageView()
        view.addSubview(image)
        image.setFrame(left: 20, top: 100, right: 20, height: 300)
        image.image = UIImage(named: "iPhoneX")
        
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.setCornerRadius(radius: 8)
        
        image.setBorder(color: c2C9EFF, borderWidth: 1)

        
    }
    
    
}

