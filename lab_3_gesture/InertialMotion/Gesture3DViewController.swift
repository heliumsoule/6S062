//
//  Gesture3DViewController.swift
//  InertialMotion
//
//  Created by Justin Anderson on 3/15/17.
//  Copyright © 2017 MIT. All rights reserved.
//

import UIKit
import CoreMotion
import GLKit

private func GLKQuaternionFromCMQuaternion(_ quat: CMQuaternion) -> GLKQuaternion {
    return GLKQuaternionMake(Float(quat.x), Float(quat.y), Float(quat.z), Float(quat.w))
}

private func GLKVector3FromCMAcceleration(_ acceleration: CMAcceleration) -> GLKVector3 {
    return GLKVector3Make(Float(acceleration.x), Float(acceleration.y), Float(acceleration.z))
}

class Gesture3DViewController: RibbonViewController, GestureProcessorDelegate {

    @IBOutlet weak var recognizedLabel: UILabel?
    
    var touchCount: Int = 0
    var motionManager: CMMotionManager = CMMotionManager()
    var samples: [Sample3D] = []
    var position: GLKVector3 = GLKVector3()
    var velocity: GLKVector3 = GLKVector3()

    override func viewDidLoad() {
        super.viewDidLoad()

        motionManager.deviceMotionUpdateInterval = 1e-2
        
        motionManager.startDeviceMotionUpdates(
            using: .xArbitraryCorrectedZVertical,
            to: OperationQueue.main) { [weak self] (motion, error) in
                self?.accumulateMotion(motion)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        becomeFirstResponder()
        samples.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gestureProcessor.delegate = self

        super.viewDidAppear(animated)
    }
    
    func updateTouches(_ event: UIEvent?) {
        let touches = event?.allTouches?.filter({
            switch $0.phase {
            case .began, .moved, .stationary:
                return true
            default:
                return false
            }
        })
        touchCount = touches?.count ?? 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouches(event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouches(event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouches(event)
    }
    
    func accumulateMotion(_ motion: CMDeviceMotion?) {
        guard let motion = motion else {
            return
        }
        
        let alpha = 0.5
        
        let dt = motionManager.deviceMotionUpdateInterval
        let attitudeQ = GLKQuaternionFromCMQuaternion(motion.attitude.quaternion)
        let m = motion.attitude.rotationMatrix
        let attitudeM = GLKMatrix3(m: (Float(m.m11), Float(m.m12), Float(m.m13),
                                       Float(m.m21), Float(m.m22), Float(m.m23),
                                       Float(m.m31), Float(m.m32), Float(m.m33)))
        let userAcceleration = GLKVector3FromCMAcceleration(motion.userAcceleration)
        
        // -- TASK 2A --
        var acceleration: GLKVector3 = userAcceleration
        // rotate acceleration from instantaneous coordinates into persistent coordinates
        acceleration = GLKVector3MultiplyScalar(acceleration, -1.0)

        // -- TASK 2B --
        // integrate acceleration into velocity and velocity into position
        self.velocity = GLKVector3Add(GLKVector3MultiplyScalar(self.velocity, Float(exp(-0.5*alpha*dt))), GLKVector3MultiplyScalar(acceleration, Float(0.5*dt)))
        self.position = GLKVector3Add(GLKVector3MultiplyScalar(self.position, Float(exp(-1*alpha*dt))), GLKVector3MultiplyScalar(self.velocity, Float(dt)))
        self.velocity = GLKVector3Add(GLKVector3MultiplyScalar(self.velocity, Float(exp(-0.5*alpha*dt))), GLKVector3MultiplyScalar(acceleration, Float(0.5*dt)))
        
        // -- TASK 2C --
        // apply your choice of braking to velocity and position to stabilize the integration loop
        
        // add the new data to the log
        
        appendPoint(position, attitudeQ: attitudeQ, attitudeM: attitudeM)
    }
    
    func appendPoint(_ point: GLKVector3, attitudeQ: GLKQuaternion, attitudeM: GLKMatrix3) {
        let draw: Bool = touchCount > 0
        if draw {
            // Why is the z axis flipped?
            let position = GLKVector3Make(point.x, point.y, -point.z)
            let s = Sample3D(location: position,
                             attitudeQ: attitudeQ,
                             attitudeM: attitudeM,
                             t: Date.timeIntervalSinceReferenceDate)
            samples.append(s)
        } else if (samples.count > 0) {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.gestureProcessor.processGesture3D(samples: samples,
                                                       minSize: 0.01)
            samples.removeAll()
        }
        super.appendPoint(point, attitude: attitudeQ, draw: draw)
    }
    
    func gestureProcessor(_ gestureProcessor: GestureProcessor, didRecognizeGesture label: String) {
        recognizedLabel?.text = recognizedLabel?.text?.appending(label)
    }
}
