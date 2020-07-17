//
//  ViewController.swift
//  Argment
//
//  Created by hladek on 15/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
//        arView.scene.addAnchor(<#T##anchor: HasAnchoring##HasAnchoring#>)
    }
}
