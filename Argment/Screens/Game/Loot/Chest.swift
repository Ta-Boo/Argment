//
//  Treasure.swift
//  Argment
//
//  Created by hladek on 19/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import UIKit

enum Rarity: String, CaseIterable{
    case common = "common"
    case rare = "rare"
    case legendary = "legendary"
    
    var description : String {
        switch self {
        case .common:
            return "Common food. Easy to find in nature."
        case .rare:
            return "Quite rare food. Takes time to find some"
        case .legendary:
            return "Legendary piece of food. Almost imposible to find one"
        }
    }
    
    var color: UIColor {
        switch self {
        case .common:
            return .common
        case .rare:
            return .rare
        case .legendary:
            return .legendary
        }
    }
    
}

struct Chest {
    let rarity: Rarity
    var image: UIImage {
        get {
            switch rarity {
            case .common:
                return UIImage.foodCommon!
            case .rare:
                return UIImage.foodRare!
            case .legendary:
                return UIImage.foodLegendary!
            }
        }
    }
    var description: String {
        get {
            return rarity.description
        }
    }
    
    var color: UIColor {
        get {
            return rarity.color
        }
    }
    
    
}
