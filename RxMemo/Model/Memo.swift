//
//  Memo.swift
//  RxMemo
//
//  Created by OCUBE on 2023/01/27.
//

import Foundation

struct Memo:Equatable{
    var content:String
    var insertData:Date
    var identity:String
    
    init(content:String, insertData:Date = Date()) {
        self.content = content
        self.insertData = insertData
        self.identity = "\(insertData.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo,updatedContent: String){
        self = original
        self.content = updatedContent
    }
}
