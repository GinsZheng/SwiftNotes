//
//  Model.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite
import SwiftyJSON

class CSBasicTable: SQLiteManager {
    // 模型只需修改字段名、数据类型，及表名
    let tableName = "items"
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let resume = Expression<String>("resume")
    let totalProgress = Expression<Int>("totalProgress")
    let color = Expression<Int>("color")
    
    func getTable() -> Table {
        let table = super.getTable(tableName: tableName) { (t) in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(resume)
            t.column(totalProgress)
            t.column(color)
        }
        return table
    }
    
    
    // 增
    func insert(item: JSON) {
        
        let values = getTable().insert(
            id <- item["id"].intValue,
            name <- item["name"].stringValue,
            resume <- item["resume"].stringValue,
            totalProgress <- item["totalProgress"].intValue,
            color <- item["color"].intValue
            
        )
        super.insert(values)
    }
    
    
    // 删单条
    func delete(id rowid: Int) {
        delete(filter: id == rowid)
    }
    
    
    // 按条件删除
    func delete(filter: Expression<Bool>? = nil) {
        var deletedData = getTable()
        if let f = filter {
            deletedData = deletedData.filter(f)
        }
        let deleteRows = deletedData.delete()
        super.delete(deleteRows)
        // filter为nil时，全部删除
    }
    
    
    // 改
    func update(id rowid: Int, item: JSON) {
        
        let updatedData = getTable().filter(id == rowid)
        let values = updatedData.update(
            name <- item["name"].stringValue,
            resume <- item["resume"].stringValue,
            totalProgress <- item["totalProgress"].intValue,
            color <- item["color"].intValue
        )
        super.update(values)
    }
    
    
    // 查
    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [
        Expression<Int>("id"),
        Expression<String>("name"),
        Expression<String>("resume"),
        Expression<Int>("totalProgress"),
        Expression<Int>("color")
        ], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        let query = getTable().select(select).order(order)
        return super.search(query, filter: filter, select: select, order: order, limit: limit, offset: offset)
    }
    
    
    // SQL语句查询
    func searchInSQL() {
        let stmt = try! getDB().prepare("SELECT id, name, totalProgress FROM items")
        for row in stmt {
            for (index, columnName) in stmt.columnNames.enumerated() {
                print ("\(columnName):\(row[index]!)")
            }
        }
    }
    
}


extension CSBasicTable {
    
    func printId() {
        var idList: [Int] = []
        let result = self.search()
        for item in result {
            idList.append(item[self.id])
        }
        print("id列表：\(idList)")
    }
    
    // 获取一个值(scalar)
    func getCount() -> Binding {
        let result = try! getDB().scalar("SELECT count(*) FROM \(tableName)")
        return result ?? 0
    }
    
    // 获取数组+字典
    func getJSON() -> JSON {
        let result = try! getDB().prepare("SELECT * FROM \(tableName)")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            let rowDict: [String: Any] = [
                "id": jsonRow[0],
                "name": jsonRow[1],
                "resume": jsonRow[2],
                "totalProgress": jsonRow[3],
                "color": jsonRow[4]
            ]
            let jsonDict = JSON(rowDict)
            jsonArray.append(jsonDict)
        }
        return JSON(jsonArray)
    }
    
    // 获取字典
    func getJSONOneRow(id: Int) -> JSON {
        let result = try! getDB().prepare("SELECT * FROM \(tableName) WHERE id = \(id)")
        var rowDict: [String: Any] = [:]
        
        for row in result {
            let jsonRow = JSON(row)
            rowDict = [
                "id": jsonRow[0],
                "name": jsonRow[1],
                "resume": jsonRow[2],
                "totalProgress": jsonRow[3],
                "color": jsonRow[4]
            ]
        }
        return JSON(rowDict)
    }
    
    // 获取数组
    func getArray() -> JSON {
        let result = try! getDB().prepare("SELECT name FROM \(tableName)")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            jsonArray.append(jsonRow[0])
        }
        return JSON(jsonArray)
    }
    
    // 获取数组2：计算
    func getCalArray() -> JSON {
        let result = try! getDB().prepare("SELECT ")
    }

    func getNextId() -> Int64 {
        let result = try! getDB().scalar("SELECT MAX(id) FROM \(tableName)")
        if result == nil {
            return 0
        }
        return result as! Int64 + 1
    }
    
    func getFirstName() -> Binding {
        let result = try! getDB().scalar("SELECT name FROM items, progress ORDER BY progress.createTime DESC LIMIT 1")
        return result ?? ""
    }
    
    
    func getJoinedTablesJSON() -> JSON {
        // 联结表时，如果两个表的字段一致(如id，需要指明表名，如：items.id)
        let result = try! getDB().prepare("SELECT items.id, name, createTime FROM items, progress WHERE items.id = progress.id ORDER BY progress.createTime DESC")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            let rowDict: [String: Any] = [
                "id": jsonRow[0],
                "name": jsonRow[1],
                "createTime": jsonRow[2],
            ]
            let jsonDict = JSON(rowDict)
            jsonArray.append(jsonDict)
        }
        return JSON(jsonArray)
    }
    
    func getJoinedTablesJSONOneLine() -> JSON {
        
        let result = try! getDB().prepare("SELECT items.id, name, createTime FROM items, progress WHERE items.id = progress.id ORDER BY progress.createTime DESC LIMIT 1")
        
        var rowDict: [String: Any] = [:]
        
        for row in result {
            let jsonRow = JSON(row)
            rowDict = [
                "id": jsonRow[0],
                "name": jsonRow[1],
                "createTime": jsonRow[2],
            ]
        }
        return JSON(rowDict)
    }
    

}



// 建模
struct CSBasicModel {
    var id: [Int]
    var name: [String]
    var resume: [String]
    var totalProgress: [Int]
    var color: [Int]
    
    init(jsonData: JSON) {
        id = jsonData.arrayValue.map {$0["id"].intValue}
        name = jsonData.arrayValue.map {$0["name"].stringValue}
        resume = jsonData.arrayValue.map {$0["resume"].stringValue}
        totalProgress = jsonData.arrayValue.map {$0["totalProgress"].intValue}
        color = jsonData.arrayValue.map {$0["color"].intValue}
    }
}

/*
 新增字段后，可能出问题，尝试删除APP看看，后续再看处理
 */
