//
//  Any.swift
//  Argment
//
//  Created by hladek on 23/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation


extension NSObject {
    func apply(blockOfCode: (Self) -> Void) -> Self {
        blockOfCode(self)
        return self
    }
}
