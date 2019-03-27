//
//  BenchmarkHelper.swift
//  kotlin-ios-benchmarks
//
//  Created by oboenikui on 2019/03/26.
//  Copyright © 2019 oboenikui.com. All rights reserved.
//

import Foundation


class BenchmarkHelper {
    
    private static let ITERATION_COUNT = 5_000_000
    
    enum Mode {
        case Throughput
        case SingleShortTime
    }
    
    @inline(__always)
    func run(_ label: String, mode: Mode, closure: () -> Void) {
        print("Start " + label)
        print("# Warmup")
        var iterateCount = BenchmarkHelper.ITERATION_COUNT
        for i in 0..<10 {
            switch mode {
            case .Throughput:
                print(String(format: "# Warmup Iteration %d: %f ops/ms",
                             i, Double(self.calculateThroughput(closure)) / 1000.0))
                break
            case .SingleShortTime:
                let result = self.calculateSingleShotTime(iterateCount, closure: closure)
                let ops = Double(iterateCount) * 1_000_000.0 / Double(result)
                print(String(format: "# Warmup Iteration %d: %f ops/ms", i, ops))
                if ops < 1000 {
                    iterateCount = BenchmarkHelper.ITERATION_COUNT / 10
                }
            }
            
        }
        var results: Array<Double> = []
        for i in 0..<10 {
            var result: Double
            switch mode {
            case .Throughput:
                result = Double(self.calculateThroughput(closure)) / 1000.0
            case .SingleShortTime:
                result = Double(iterateCount) * 1_000_000.0 / Double(self.calculateSingleShotTime(iterateCount, closure: closure))
            }
            
            results.append(result)
            print(String(format: "Iteration %d: %f ops/ms", i, result))
        }
        self.throughptSummary(results)
    }
    
    @inline(__always)
    private func calculateSingleShotTime(_ iterateCount: Int, closure: () -> Any) -> UInt64 {
        var i = 0
        let start = clock_gettime_nsec_np(CLOCK_REALTIME)
        while i < iterateCount {
            i += 1
            let _ = closure()
        }
        return clock_gettime_nsec_np(CLOCK_REALTIME) - start
    }
    
    @inline(__always)
    private func calculateThroughput(_ closure: () -> Any) -> Int64 {
        var count: Int64 = 0
        let start = clock_gettime_nsec_np(CLOCK_REALTIME)
        while true {
            let _ = closure()
            if clock_gettime_nsec_np(CLOCK_REALTIME) - start > 1_000_000_000 {
                break
            }
            count += 1
        }
        return count
    }
    
    @inline(__always)
    private func throughptSummary(_ results: Array<Double>) {
        var sum: Double = 0
        var max: Double = 0
        var min: Double = 0x7fffffff
        
        for result in results {
            if result > max {
                max = result
            } else if result < min {
                min = result
            }
            sum += result
        }
        let avg = sum / Double(exactly: results.count)!
        
        var powSum: Double = 0
        for result in results {
            powSum += pow(result - avg, 2)
        }
        let stdev = sqrt(powSum / Double(exactly: results.count - 1)!)
        print(String(format: "Statistics: (min, avg, max) = (%f, %f, %f), stdev = %f",
                     min, avg, max, stdev))
    }
    
    func newTestSuite() -> TestSuite {
        return TestSuite(
            a: 10,
            who: "John",
            intArray: [5, 0, 3, -1, -6, 7, -7, 4],
            sparseArray: SparseArray(["A", "B", "Hi", "ZZ", "FFF"])
        )
    }
    
    func newBlackHole() -> BlackHole {
        return BlackHole()
    }
}

class TestSuite {
    let a: Int
    let who: String
    let intArray: [Int]
    let sparseArray: SparseArray<String>
    
    init(a: Int, who: String, intArray: [Int], sparseArray: SparseArray<String>) {
        self.a = a
        self.who = who
        self.intArray = intArray
        self.sparseArray = sparseArray
    }
}

class Queue<T> {
    private var first: Value<T>? = nil
    private var last: Value<T>? = nil
    
    func enqueue(_ value: T) {
        let next = Value(value)
        if first == nil {
            first = next
            last = next
            return
        }
        
        last?.next = next
        last = next
    }
    
    func dequeue() -> T? {
        if let first = first {
            self.first = first.next
            return first.value
        }
        return nil
    }
    
    class Value<T> {
        var next: Value<T>? = nil
        let value: T
        
        init(_ value: T) {
            self.value = value
        }
    }
}
