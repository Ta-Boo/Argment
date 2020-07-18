//
//  ViewController.swift
//  Argment
//
//  Created by hladek on 15/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import UIKit
import RealityKit
import RxSwift
import RxCocoa

class CustomBox: Entity, HasModel, HasAnchoring, HasCollision {
    
    required init(color: UIColor) {
        super.init()
        self.components[ModelComponent] = ModelComponent(
            mesh: .generateBox(size: 0.1),
            materials: [SimpleMaterial(
                color: color,
                isMetallic: false)
            ]
        )
    }
    
    convenience init(color: UIColor, position: SIMD3<Float>) {
        self.init(color: color)
        self.position = position
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}

class ArViewController: UIViewController {
    

    @IBOutlet var arView: MyArView!
    @IBOutlet weak var countdown: UILabel!
    
    let viewModel = ArViewModel()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdown.isHidden = true
        let boxAnchor = try! Experience.loadBox()
        arView.scene.addAnchor(boxAnchor)
        arView.detectionCompletedClosure = { [weak self] in
            self?.setupCountdown()
        }
        arView.addCoaching()
    }
    
    func setupCountdown() {
        let time = 9
        countdown.isHidden = false
        viewModel.timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .map { time in
                "\(10 - (time + 1)) s" }
            .bind(to: countdown.rx.text)
            .dispose(by: viewModel.disposeBag)
    }
}
