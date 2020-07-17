//
//  ViewController.swift
//  Argment
//
//  Created by hladek on 15/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import UIKit
import RealityKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
//        arView.Holder.detectionCompleted
        let boxAnchor = try! Experience.loadBox()
               let box = MeshResource.generateBox(size: 0.3) // size in metres
               let material = SimpleMaterial(color: .lightGray, isMetallic: true)
               let entity = ModelEntity(mesh: box, materials: [material])
               let anchor = AnchorEntity(plane: .horizontal)
               anchor.addChild(entity)
        arView.detectionCompletedClosure = { [weak self] in
            print("done")
            print("done")
            print("done")
            print("done")
            print("done")
            print("done")
            print("done")
            print("done")
            self?.arView.scene.addAnchor(boxAnchor)
        }
        arView.addCoaching()
       

        
        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
    }
}
