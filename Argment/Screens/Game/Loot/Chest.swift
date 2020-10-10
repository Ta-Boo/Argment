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
            return "Common chest. Easy to find, which make it cheap."
        case .rare:
            return "Rare chest. Takes time to find some. However it can contains valuable items"
        case .legendary:
            return "Legendary chest. Almost imposible to find one. Very high chance to obtain legendary piece of equipment for your pet."
        }
    }
    
    var color: UIColor {
        switch self {
        case .common:
            return .rare
        case .rare:
            return .legendary
        case .legendary:
            return .common
        }
    }
    
}

struct Chest : Equatable{
    
    let id = Int64(Date().timeIntervalSince1970) + Int64.random(in: 1...1000)
    let rarity: Rarity
    var image: UIImage {
        get {
            switch rarity {
            case .common:
                return UIImage.commonChest!
            case .rare:
                return UIImage.rareChest!
            case .legendary:
                return UIImage.legendaryChest!
            }
        }
    }
    
    var description: String {
        return rarity.description
    }
    
    var title: String {
        get {
            return "\(rarity.description.components(separatedBy: ".").first ?? " Unknown chest")."
        }
    }
    
    var color: UIColor {
        get {
            rarity.color
        }
    }
    
    static func != (lhs: Chest, rhs: Chest) -> Bool {
        return lhs.id != rhs.id
    }
    
    static func == (lhs: Chest, rhs: Chest) -> Bool {
        return lhs.id == rhs.id
    }
}
