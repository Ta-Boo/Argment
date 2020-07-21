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
//    let items = PublishSubject<[Treasure]>()
    let items: BehaviorRelay<[Treasure]> = BehaviorRelay(value: [])
    
    func fetchData() {
        let data = [
            Treasure(rarity: .common),
            Treasure(rarity: .common),
            Treasure(rarity: .rare),
            Treasure(rarity: .common),
            Treasure(rarity: .rare),
            Treasure(rarity: .common),
            Treasure(rarity: .common),
            Treasure(rarity: .legendary),
            Treasure(rarity: .common),
        ]
        items.accept(data)
//        items.onNext(data)
//        items.onCompldaeted()
    }
}
