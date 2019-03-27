//
//  SwfitPart1.swift
//  kotlin-ios-benchmarks
//
//  Created by oboenikui on 2019/03/26.
//  Copyright © 2019 oboenikui.com. All rights reserved.
//

import Foundation

func runLocalFunctionCapturingLocalVariable(_ a: Int) -> Int {
    return someMath(a)
}

func runLocalFunctionWithoutCapturingLocalVariable(_ a: Int) -> Int {
    return someMath2(a)
}

func someMath(_ a: Int) -> Int {
    func sumSquare(b: Int) -> Int{
        return (a + b) * (a + b)
    }
    
    return sumSquare(b: 1) + sumSquare(b: 2)
}

func someMath2(_ a: Int) -> Int {
    func sumSquare(a: Int, b: Int) -> Int {
        return (a + b) * (a + b)
    }
    
    return sumSquare(a: a, b: 1) + sumSquare(a: a, b: 2)
}

func sayHello(who: String, blackHole: BlackHole) -> Int {
    return who.count
}

func runPrintDouble(_ blackHole: BlackHole, values: [Int]) {
    printDouble(blackHole, values: values)
}

func printDouble(_ blackHole: BlackHole, values: [Int]) {
    for value in values {
        blackHole.consume(value)
    }
}
