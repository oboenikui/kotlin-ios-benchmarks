//
// Created by oboenikui on 2019-03-25.
// Copyright (c) 2019 oboenikui.com. All rights reserved.
//

import Foundation

public class SwiftBenchmark {

    public static func run() {
        let helper = BenchmarkHelper()
        
        // Part 1
        
        helper.run("Swift Part1 empty", mode: .SingleShortTime) {
            let _ = empty()
        }
        
        let db = SwiftDatabase()
        
        helper.run("Swift Part1 lambda", mode: .SingleShortTime) {
            let _ = runSwiftLambda(db)
        }
        
        helper.run("Swift Part1 inline function", mode: .SingleShortTime) {
            let _ = runSwiftInlinedFunction(db)
        }
        
        helper.run("Swift Part1 Static call to private constructor", mode: .SingleShortTime) {
            let _ = runStaticCallToPrivateConstructor()
        }
        
        // Part 2
        
        let testSuite = helper.newTestSuite()
        let blackHole = helper.newBlackHole()
        
        helper.run("Swift Part2 Local function capturing local variable", mode: .SingleShortTime) {
            let _ = runLocalFunctionCapturingLocalVariable(testSuite.a)
        }
        
        helper.run("Swift Part2 Local function without capturing local variable", mode: .SingleShortTime) {
            let _ = runLocalFunctionWithoutCapturingLocalVariable(testSuite.a)
        }
        
        helper.run("Swift Part2 null check cost", mode: .SingleShortTime) {
            let _ = sayHello(who: testSuite.who, blackHole: blackHole)
        }
        
        helper.run("Swift Part2 vararg spread cost", mode: .SingleShortTime) {
            let _ = runPrintDouble(blackHole, values: testSuite.intArray)
        }
        
        // Part 3
        
        helper.run("Swift Part3 String delegate", mode: .SingleShortTime) {
            runStringDelegateExample(blackHole)
        }
        
        helper.run("Swift Part3 Is in 1..10 (local)", mode: .SingleShortTime) {
            let _ = runIsInOneToTenWithLocalRange(testSuite.a)
        }
        
        helper.run("Swift Part3 Is in 1..10 (indirect)", mode: .SingleShortTime) {
            let _ = runIsInOneToTenWithIndirectRange(testSuite.a)
        }
        
        helper.run("Swift Part3 Is in Alfred..Alicia (local)", mode: .SingleShortTime) {
            let _ = isBetweenNamesWithLocalRange(testSuite.who)
        }
        
        helper.run("Swift Part3 Is in Alfred..Alicia (constant)", mode: .SingleShortTime) {
            let _ = isBetweenNamesWithConstantRange(testSuite.who)
        }
        
        helper.run("Swift Part3 Range forEach method", mode: .SingleShortTime) {
            rangeForEachMethod(blackHole)
        }
        
        helper.run("Swift Part3 Range for in loop", mode: .SingleShortTime) {
            rangeForEachLoop(blackHole)
        }
        
        helper.run("Swift Part3 Range for in loop with step 1", mode: .SingleShortTime) {
            rangeForEachLoopWithStep1(blackHole)
        }
        
        helper.run("Swift Part3 Print value using indices", mode: .SingleShortTime) {
            printValuesUsingIndices(testSuite.sparseArray, blackHole: blackHole)
        }
        
        helper.run("Swift Part3 Print value using last index range", mode: .SingleShortTime) {
            printValuesUsingLastIndexRange(testSuite.sparseArray, blackHole: blackHole)
        }
        
    }
}
