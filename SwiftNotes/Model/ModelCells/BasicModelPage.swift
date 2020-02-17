//
//  SQLite.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SQLite
import SwiftyJSON


class BasicModelPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let model = BasicModel()
    
    var name = [String]()
    lazy var result = model.search() // Select * From table
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.set(superview: view, delegate: self, dataSource: self)
        tableView.setFrame(left: 0, top: 0, right: 0, bottom: 0)
        
        // model的基本操作：增删改查
        // 示例值
        let exampleId = 4
        var exampleName = "name9"
        let exampleResume = ""
        let exampleTotalProgress = 100
        let exampleColor = 0
        
        let insertRow: [String: Any] = [
            "id": exampleId,
             "name": exampleName,
             "resume": exampleResume,
             "totalProgress": exampleTotalProgress,
             "color": exampleColor
        ]
        let insertJSON = JSON(insertRow)
        
        exampleName = "name4"
        let updataRow: [String: Any] = [
            "id": exampleId,
            "name": exampleName,
            "resume": exampleResume,
            "totalProgress": exampleTotalProgress,
            "color": exampleColor
        ]
        let updateJSON = JSON(updataRow)
        
        
        // insert
        model.insert(item: insertJSON)
        getNameArray(result: result)
        
        // update
        model.update(id: 4, item: updateJSON)
        getNameArray(result: result)
        
        // delete
        // model.delete(id: 4)
        model.delete(filter: model.id == 4)
        getNameArray(result: result)

        // search
        getNameArray(result: result)
        
        // 注：打印结果有错位，大概率是因为返回速度不同，
        // getNameArray的遍历数据库比delete等直接print慢一些
        
        // printId
        model.printId()
        
        // SQLite尝试
        print(model.getCount())
        
    }
    
    func getNameArray(result: [Row]) {
        name = []
        self.result = model.search()
        for item in result {
            name.append(item[model.name])
        }
        print(name)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(leftInset: 20, rightInset: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: name[indexPath.row])
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "discovery_next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: GeneralSubpage())
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}