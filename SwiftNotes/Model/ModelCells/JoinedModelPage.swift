//
//  SQLiteJoinTablesPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import SQLite

class CSJoinedModelPage: UIViewController {
    
    let basicTable = CSBasicTable()
    let joinedTable = CSJoinedTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        

        // 示例值
        let exampleId = 3
        let exampleCurrentProgress = 20
        let exampleStartTime = ""
        let exampleEndTime = ""
        let exampleItemId = 1
        
        let insertRow: [String: Any] = [
            "id": exampleId,
             "currentProgress": exampleCurrentProgress,
             "startTime": exampleStartTime,
             "endTime": exampleEndTime,
             "itemId": exampleItemId
        ]
        let insertJSON = JSON(insertRow)
        
        joinedTable.insert(item: insertJSON)
        
        
        
    }
    
    
}

