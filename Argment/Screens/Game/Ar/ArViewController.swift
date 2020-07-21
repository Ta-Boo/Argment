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

class ArViewController: UIViewController {
    

    @IBOutlet var arView: MyArView!
    @IBOutlet weak var countdown: UILabel!
    
    let viewModel = ArViewModel()
    let chestModel: ChestModel.Scene! = {
        let model = try! ChestModel.loadScene()
        model.generateCollisionShapes(recursive: true)
        return model
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdown.isHidden = true
        arView.detectionCompletedClosure = { [weak self] in
            self?.setupCountdown()
            
        }
        self.arView.scene.anchors.append(chestModel)

        arView.addCoaching()
        arView.onTapped { [weak self] sender in
            print("olaaa")
            guard let touchInView = sender?.location(in: self?.arView) else { return }
            guard let hitEntity = self?.arView.entity(
                at: touchInView
                ) else {
//                    self?.chestModel.actions.chestCollected
                    print("You missed")
                    return
            }
            print("You hit: ", hitEntity.anchor!.debugDescription.utf8CString)
        }
        chestModel.actions.chestCollected.onAction = { [weak self] box in
            self?.dismiss(animated: true)
        }
    }
    
    
    func setupCountdown() {
        countdown.isHidden = false
        viewModel.timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .map { time in
                "\(10 - (time + 1)) s" }
            .bind(to: countdown.rx.text)
            .dispose(by: viewModel.disposeBag)
    }
}
