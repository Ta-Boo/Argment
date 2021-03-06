import Foundation
import RealityKit
import ARKit

extension ARView: ARCoachingOverlayViewDelegate{
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.center = CGPoint(x: frame.size.width  / 2,
                                         y: frame.size.height / 2)
        coachingOverlay.setActive(true, animated: true)
        
        coachingOverlay.goal = .anyPlane
        self.addSubview(coachingOverlay)
    }
}

final class MyArView: ARView {
    var detectionCompletedClosure: (() -> Void)?
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        detectionCompletedClosure?()
    }
}
