//
//  BlackHole.swift
//  SwiftBenchmark
//
//  Created by oboenikui on 2019/03/26.
//  Copyright © 2019 oboenikui.com. All rights reserved.
//

import Foundation

class BlackHole {
    
    private var obj: String? = nil
    private var iter: Int = 0
    
    func consume(str: String) {
        iter += (self.obj == str) ? 1 : 0
        self.obj = str
    }
    
    func consume(_ value: Int) {
        self.iter += (value % 2 == 0) ? 1 : 0
    }
}
