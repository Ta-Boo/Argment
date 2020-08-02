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
    case animal = "animal"
    case settings = "settings"
    case loot = "info"
    
    var viewController: UIViewController {
        switch self {
        case .stats:
            let controller = UIViewController()
            controller.view.backgroundColor = UIColor.init(named: "Rare")
            return controller
        case .animal:
            let controller = UIViewController()
            controller.view.backgroundColor = #colorLiteral(red: 0.5559999943, green: 0.9789999723, blue: 0, alpha: 1)
            return controller
        case .settings:
            let controller = UIViewController()
            controller.view.backgroundColor = #colorLiteral(red: 0.5809999704, green: 0.1289999932, blue: 0.5749999881, alpha: 1)
            return controller
        case .loot:
           return StoryboardScene.Stats.initialScene.instantiate()
        }
    }
    
    var title: String {
        self.rawValue.capitalized
    }
    
    var image: UIImage {
        switch self {
        case .animal:
            return UIImage.animal!
        case .stats:
            return UIImage.stats!
        case .settings:
            return UIImage.settings!
        case .loot:
            return UIImage.treasure!
        }
    }
    
    
}

class MainTabBarController: UITabBarController {
    
    let tabItems: [TabItem] = [.stats, .animal, .loot, .settings]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupButton()
        setupTabs()
    }
    
    func setupStatusBar() {
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.backgroundColor = .clear
        navigationController!.navigationBar.isTranslucent = true
        navigationController!.navigationBar.tintColor = .secondary
    }
    
    func setupTabBar(){
        tabBar.tintColor = .secondary
        tabBar.unselectedItemTintColor = .accent
    }
    
    func setupButton(){
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 32
        button.backgroundColor = .secondary
        view.insertSubview(button, aboveSubview: view)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 8),
            button.widthAnchor.constraint(equalToConstant: 64),
            button.heightAnchor.constraint(equalToConstant: 64)
        ])
        button.setImage(UIImage.camera!.withTintColor(.accent), for: .normal)
        button.onTapped { [weak self] _ in
            self?.present(StoryboardScene.ArFragment.initialScene.instantiate(), animated: true)
        }
    }
    
    func setupTabs() {
        let controllers: [UIViewController] = tabItems.map({ item in
            let controller = item.viewController
            controller.tabBarItem = UITabBarItem(title: "", image: item.image , selectedImage: nil)
            return controller
        })
        self.viewControllers = controllers
        guard let items = tabBar.items else { return }
        for (index, item) in items.enumerated() {
            let direction: CGFloat = (index > (controllers.count / 2) - 1) ? 1 : -1
            let offset: CGFloat = ((0...1).contains(controllers.count / 2 - index)) ? 20 : 0
            item.titlePositionAdjustment = UIOffset(horizontal: direction * offset, vertical: 0)
        }
    }
}
