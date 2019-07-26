//
//  ViewController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let controlList = ["Button", "Date Picker", "Image View", "Label", "Page Control",  "Picker View", "Scroll View", "Segment Control", "Slider", "Stack View", "Stepper", "Switch", "Table View", "Text Field", "Text View", "View", "Web View"]
    let controlPage = [ButtonPage(), DatePickerPage(), ImageViewPage(), LabelPage(), PageControlPage(), PickerViewPage(), ScrollViewPage(), SegmentControlPage(), SliderPage(), StackViewPage(), StepperPage(), SwitchPage(),TableViewPage(),  TextFieldPage(), TextViewPage(), ViewPage(), WebViewPage()]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.makeConstraints(left: 0, top: kNavBarHeight, width: kScreenWidth, height: self.getSafeAreaHeight())
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kCellHeight*CGFloat(controlList.count))
        
        let viewContainer = UIView()
        scrollView.addSubview(viewContainer)
        viewContainer.makeConstraints(left: 0, top: 0, width: scrollView.width, height: CGFloat(56*controlList.count))

        let table = UITableView()
        viewContainer.addSubview(table)
        table.makeConstraints(left: 0, top: 0, width: kScreenWidth, height: CGFloat(56*controlList.count))
        table.dataSource = self
        table.delegate = self
        table.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        table.separatorColor = UIColor.hex("1A000820")
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.makeConstraints(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: controlList[indexPath.row])
        cellTitle.makeConstraints(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "discovery_next")
        next.makeConstraints(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controlList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: controlPage[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

