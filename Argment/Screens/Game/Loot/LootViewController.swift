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
    
    let btn = UIButton()
    
    let viewModel = LootViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        bindTableView()
    }
    
    func bindTableView(){
        tableView.register(TreasureCell.self, forCellReuseIdentifier: "cellId")
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: TreasureCell.self)) { (row,item,cell) in
            cell.load(data: item)
        }.disposed(by: viewModel.disposeBag)
        
        tableView.rx.modelSelected(Treasure.self).subscribe(onNext: { [weak self] item in
            let alert = UIAlertController(title: "Open chest", message: item.description, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alert, animated: true)
        }).disposed(by: viewModel.disposeBag)
        
        viewModel.fetchData()
    }
}
