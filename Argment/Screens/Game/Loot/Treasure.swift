//
//  Treasure.swift
//  Argment
//
//  Created by hladek on 19/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import UIKit

enum Rarity: String{
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
            return #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
        case .rare:
            return #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        case .legendary:
            return #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
        }
    }
    
}

struct Treasure {
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
