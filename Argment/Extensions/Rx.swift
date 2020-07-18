//
//  Rx.swift
//  Argment
//
//  Created by hladek on 18/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Disposable {
    func dispose(by bag: DisposeBag ) ->  Disposable {
        disposed(by: bag)
        return self
    }
}
