import Foundation
import RealityKit
import UIKit

class CustomBox: Entity, HasModel, HasCollision, HasAnchoring {
    required init(color: UIColor) {
        super.init()
        self.model = ModelComponent(
            mesh: .generateBox(size: [1, 0.2, 1]),
            materials: [SimpleMaterial(
                color: color,
                isMetallic: false)
            ]
        )
        self.generateCollisionShapes(recursive: true)
    }
    convenience init(color: UIColor, position: SIMD3<Float>) {
        self.init(color: color)
        self.position = position
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
