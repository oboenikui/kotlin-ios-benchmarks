//
//  SwfitPart1.swift
//  kotlin-ios-benchmarks
//
//  Created by oboenikui on 2019/03/26.
//  Copyright © 2019 oboenikui.com. All rights reserved.
//

import Foundation

func someOperation() -> String {
    return "hello"
}

class Example {
    lazy var p: String = someOperation()
}

func runStringDelegateExample(_ blackHole: BlackHole) {
    let example = Example()
    blackHole.consume(str: example.p)
    blackHole.consume(str: example.p)
}

func runIsInOneToTenWithLocalRange(_ a: Int) -> Bool {
    return isInOneToTenWithLocalRange(a)
}

func isInOneToTenWithLocalRange(_ i: Int) -> Bool {
    return 1...10 ~= i
}

func isInOneToTenWithLocalRangeAndStep1(_ i: Int) -> Bool {
    return stride(from: 1, through: 10, by: 1).contains(i)
}

func runIsInOneToTenWithIndirectRange(_ a: Int) -> Bool {
    return isInOneToTenWithIndirectRange(a)
}

private var myRange: ClosedRange<Int> {
    get {
        return 1...10
    }
}

func isInOneToTenWithIndirectRange(_ i: Int) -> Bool {
    return myRange ~= i
}

func isBetweenNamesWithLocalRange(_ name: String) -> Bool {
    return "Alfred"..."Alicia" ~= name
}

private let NAMES = "Alfred"..."Alicia"

func isBetweenNamesWithConstantRange(_ name: String) -> Bool {
    return NAMES ~= name
}

func rangeForEachMethod(_ blackHole: BlackHole) {
    (1...10).forEach {
        blackHole.consume($0)
    }
}

func rangeForEachLoop(_ blackHole: BlackHole) {
    for it in 1...10 {
        blackHole.consume(it)
    }
}

func rangeForEachLoopWithStep1(_ blackHole: BlackHole) {
    for it in stride(from: 1, through: 10, by: 1) {
        blackHole.consume(it)
    }
}

/**
 * SparseArray fake implementation.
 */
class SparseArray<T> {
    private let collection: [T]
    
    init(_ collection: [T]) {
        self.collection = collection
    }
    
    func size() -> Int {
        return collection.count
    }
    
    func valueAt(_ index: Int) -> T {
        return collection[index]
    }
}

extension SparseArray {
    var indices: ClosedRange<Int> {
        get {
            return 0...size() - 1
        }
    }
    
    var lastIndex: Int {
        get {
            return size() - 1
        }
    }
}

func printValuesUsingIndices(_ map: SparseArray<String>, blackHole: BlackHole) {
    for i in map.indices {
        blackHole.consume(str: map.valueAt(i))
    }
}

func printValuesUsingLastIndexRange(_ map: SparseArray<String>, blackHole: BlackHole) {
    for i in 0...map.lastIndex {
        blackHole.consume(str: map.valueAt(i))
    }
}
