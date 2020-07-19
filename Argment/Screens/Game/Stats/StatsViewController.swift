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

class StatsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = StatsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        bindTableView()
    }
    
    func bindTableView(){
        tableView.register(TreasureCell.self, forCellReuseIdentifier: "cellId")
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: TreasureCell.self)) { (row,item,cell) in
            cell.load(data: item)
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.fetchData()
    }
    
}

extension StatsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
