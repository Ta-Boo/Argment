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
    case settings = "settings"
    case info = "info"
    
    var viewController: UIViewController {
        switch self {
        case .stats:
            return StoryboardScene.Stats.initialScene.instantiate()
        case .game:
            return StoryboardScene.ArFragment.initialScene.instantiate()
        case .settings:
            return StoryboardScene.Stats.initialScene.instantiate()
        case .info:
            return StoryboardScene.Stats.initialScene.instantiate()
        }
    }
    
    var title: String {
        self.rawValue.capitalized
    }
    
    var image: UIImage {
        switch self {
        case .game:
            return Asset.camera.image
        case .stats:
            return Asset.stats.image
        case .settings:
            return Asset.settings.image
        case .info:
            return Asset.info.image
        }
    }
    
    
}

class MainTabBarController: UITabBarController {

    let tabItems: [TabItem] = [.stats, .info, .info, .settings]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupButton()
        setupTabs()
    }
    
    func setupTabBar(){
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }
    
    func setupButton(){
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 32
        button.backgroundColor = #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)
        view.insertSubview(button, aboveSubview: view)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -72),
            button.widthAnchor.constraint(equalToConstant: 64),
            button.heightAnchor.constraint(equalToConstant: 64)
        ])
        button.setImage(Asset.camera.image.withTintColor(#colorLiteral(red: 0.9210000038, green: 0.9210000038, blue: 0.9210000038, alpha: 1)), for: .normal)
//        button.image(for: .normal)?.colo = #colorLiteral(red: 0.9210000038, green: 0.9210000038, blue: 0.9210000038, alpha: 1)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        present(StoryboardScene.ArFragment.initialScene.instantiate(), animated: true)
    }
    
    
    func setupTabs() {
        let controllers: [UIViewController] = tabItems.map({ item in
            let controller = item.viewController
            controller.tabBarItem = UITabBarItem(title: item.title, image: item.image , selectedImage: nil)
            return controller
        })
        self.viewControllers = controllers
        guard let items = tabBar.items else { return }
        for (index, item) in items.enumerated() {
            let direction: CGFloat = (index > (controllers.count / 2) - 1) ? 1 : -1
            let offset: CGFloat = ((0...1).contains(controllers.count / 2 - index)) ? 20 : 0
            item.titlePositionAdjustment = UIOffset(horizontal: direction * offset, vertical: 0)
            self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        }
    }
}
