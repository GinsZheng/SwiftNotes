//
//  popPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/1.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSPopToSpecificPage: UIViewController {
    
    public var textStr = "Pop to specific page"
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: textStr)
        label.setFontStyle(size: 34, color: "222")
        label.setFrame(centerX: view.centerX, top: 200)
        
        button.set(superview: view, target: self, action: #selector(test))
        button.setStyleWordButton(title: "pop to root")
        button.setFrame(centerX: view.centerX, top: label.bottom, width: 200, height: 44)
    }
    
    @objc func test() {
        self.popToControllerListVC()
    }
    
}


// pop回到指定页面
extension UIViewController {
    
    func popToControllerListVC() {
        self.navigationController?.popToRootViewController(animated: true)
        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let tabBarController = delegate.window?.rootViewController as? UITabBarController, let viewControllers = tabBarController.viewControllers  else {
            return
        }
        
        for item in viewControllers {
            guard let navController = item as? UINavigationController, let rootViewController = navController.viewControllers.first else { continue }
            if rootViewController is CSControllerListVC {
                tabBarController.selectedViewController = navController
                break
            }
        }
    }

}