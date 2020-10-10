import Foundation
import RxSwift
import RxCocoa


class AppState {
    
    static let shared = AppState()
    let loot: BehaviorRelay<[Chest]> = BehaviorRelay(value: [])
    
    private init() {
        loadData()
    }
    
    func loadData() {
        let data = [
            Chest(rarity: .common),
            Chest(rarity: .rare),
            Chest(rarity: .common),
            Chest(rarity: .common),
            Chest(rarity: .legendary)
        ]
        loot.accept(data)
    }
}
