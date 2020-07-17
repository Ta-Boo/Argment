//
//  MainTabBarController.swift
//  Argment
//
//  Created by hladek on 17/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import UIKit

enum TabItem: String {
    case stats = "stats"
    case game = "game"
    
    var viewController: UIViewController {
        switch self {
        case .stats:
            return StoryboardScene.Stats.initialScene.instantiate()
        case .game:
            return StoryboardScene.ArFragment.initialScene.instantiate()
        }
    }
    
    var title: String {
        self.rawValue.capitalized
    }
    
    var image: UIImage {
        switch self {
        case .game:
            return .checkmark
        case .stats:
            return .remove
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .game:
            return .strokedCheckmark
        case .stats:
            return .remove
        }
    }
    
    
    
    
}

class MainTabBarController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupTabs()
    }
    
    func setupButton(){
        let button = UIButton()
        button.layer.cornerRadius = 32
        button.backgroundColor = .green
        view.insertSubview(button, aboveSubview: view)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -72),
            button.widthAnchor.constraint(equalToConstant: 64),
            button.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    
    func setupTabs() {
        let tabItems: [TabItem] = [.stats, .game, .stats, .game]
        let controllers: [UIViewController] = tabItems.map({ item in
            let controller = item.viewController
            controller.tabBarItem = UITabBarItem(title: item.title, image: item.image , selectedImage: item.selectedImage)
            return controller
        })
        self.viewControllers = controllers
        guard let items = tabBar.items else { return }
        for (index, item) in items.enumerated() {
            let direction: CGFloat = (index > (controllers.count / 2) - 1) ? 1 : -1
            let offset: CGFloat = ((0...1).contains(controllers.count / 2 - index)) ? 20 : 0
            item.titlePositionAdjustment = UIOffset(horizontal: direction * offset, vertical: 0)
//            self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        }
    }
}
