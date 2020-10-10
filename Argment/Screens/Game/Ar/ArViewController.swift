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
        }
        chestModel.actions.chestCollected.onAction = { [weak self] box in
            guard let self = self else{
                return
            }
            
            let alert = SSYDialogController(title: "You have found: \(self.viewModel.chest.title.lowercased()) ", message: "\(self.viewModel.chest.description)", animation: "chest_found")
            alert.addAction(SSYDialogAction(title: "OK", style: .basic, action: {
                self.viewModel.saveChest()
                self.dismiss(animated: true)
            }))
            self.present(alert, animated: true)

        }
    }
    
    func setupCountdown() {
        countdown.isHidden = false
        viewModel.timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .map { time in
                "\(10 - (time % 10 + 1)) s" }
            .bind(to: countdown.rx.text)
            .dispose(by: viewModel.disposeBag)
    }
}
