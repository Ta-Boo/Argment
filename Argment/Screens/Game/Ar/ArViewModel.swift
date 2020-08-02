//
//  ArViewModel.swift
//  Argment
//
//  Created by hladek on 18/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class ArViewModel {
    
    let disposeBag = DisposeBag()
    var timer: Disposable?
    var displayTime = PublishSubject<Int>()
    
    let chest = Chest(rarity: Rarity.allCases.randomElement() ?? .common)
    
    func saveChest() {
        let appState = AppState.shared
        appState.loot.accept([chest] + appState.loot.value)
    }
    
}
