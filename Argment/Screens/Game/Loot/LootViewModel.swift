//
//  StatsViewModel.swift
//  Argment
//
//  Created by hladek on 19/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LootViewModel{
    let disposeBag = DisposeBag()
    let items: BehaviorRelay<[Chest]> = BehaviorRelay(value: [])
    
    func fetchData() {
        items.accept(AppState.shared.loot.value)
    }
    
    func update() {
        fetchData()
    }
}
