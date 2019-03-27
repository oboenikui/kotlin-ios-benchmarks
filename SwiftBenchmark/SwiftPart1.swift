//
//  SwfitPart1.swift
//  kotlin-ios-benchmarks
//
//  Created by oboenikui on 2019/03/26.
//  Copyright © 2019 oboenikui.com. All rights reserved.
//

import Foundation


func empty() {}

public func runSwiftLambda(_ db: SwiftDatabase) -> Int32 {
    let deletedRows = transaction(db, body: { db in
        return db.delete(s: "Customers", var1: nil, var2: nil)
    })
    
    return deletedRows
}

public func runSwiftInlinedFunction(_ db: SwiftDatabase) -> Int32 {
    let deletedRows = inlineTransaction(db, body: { db in
        return db.delete(s: "Customers", var1: nil, var2: nil)
    })
    
    return deletedRows
}

func transaction(_ db: SwiftDatabase, body: ((SwiftDatabase) -> Int32)?) -> Int32 {
    if let body = body {
        db.beginTransaction()
        
        let result = body(db)
        db.setTransactionSuccessful()
        
        defer {
            db.endTransaction()
        }
        
        return result
    }
    return -1
}

func inlineTransaction(_ db: SwiftDatabase, body: (SwiftDatabase) -> Int32) -> Int32 {
    db.beginTransaction()
    
    let result = body(db)
    db.setTransactionSuccessful()
    
    defer {
        db.endTransaction()
    }
    
    return result
}

func runStaticCallToPrivateConstructor() -> String {
    let myClass = MyClass.newInstance()
    return myClass.helloWorld()
}

class MyClass {
    private static let TAG: String = "TAG"
    
    private init() {}
    
    func helloWorld() -> String {
        return MyClass.TAG
    }
    
    public static func newInstance() -> MyClass {
        return MyClass()
    }
}
