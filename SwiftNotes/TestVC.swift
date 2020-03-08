//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    let pickerView = UIPickerView()
    let myView = UIView()
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        self.title = "Test"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd E HH:mm:ss"
        let date = Date()
        let stringOfDate = dateFormatter.string(from: date)
        print(stringOfDate)
    }
}

