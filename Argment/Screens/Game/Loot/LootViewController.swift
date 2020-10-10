//
//  StatsViewController.swift
//  Argment
//
//  Created by hladek on 17/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LootViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let noDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .astronaut
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let viewModel = LootViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintViews()
        bindTableView()
    }
    
    func constraintViews() {
        view.addSubview(noDataImageView)
        NSLayoutConstraint.activate([
            noDataImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            noDataImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            noDataImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            noDataImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        viewModel.update()
    }
    
    func bindTableView(){
        tableView.register(LootCell.self, forCellReuseIdentifier: "cellId")
        
        AppState.shared.loot.subscribe(onNext: { [weak self] chests in
            self?.noDataImageView.isHidden = !chests.isEmpty
        }).disposed(by: viewModel.disposeBag)
        
        AppState.shared.loot.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: LootCell.self)) { [] (row,item,cell) in
            cell.load(data: item)
        }.disposed(by: viewModel.disposeBag)
        
        tableView.rx.modelSelected(Chest.self).subscribe(onNext: { [weak self] item in
            let alert = SSYDialogController(title: "You are about to open chest", message: "\(item.description)", animation: "chest_opening")
            alert.addAction(SSYDialogAction(title: "OK", style: .basic, action: {
                AppState.shared.loot.accept(AppState.shared.loot.value.filter{ $0 != item})
            }))
            alert.addAction(SSYDialogAction(title: "Cancel", style: .destructive))
            self?.present(alert, animated: true)
        }).disposed(by: viewModel.disposeBag)
        
        
    }
}

