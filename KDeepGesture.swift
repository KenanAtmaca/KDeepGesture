//
//  KDeepGesture & KTaptic
//
//  Copyright © 2017 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//
//

import UIKit
import UIKit.UIGestureRecognizerSubclass


class KDeepGesture: UIGestureRecognizer {
   
    lazy var taptic:KTaptic = KTaptic()
    
    var target:AnyObject?
    var selector:Selector?
    var rootView:UIView!
    var threshold:CGFloat = 0.10
    var scale:CGFloat = 1.0
    var isThreshold:Bool = false
    var pressTime:TimeInterval = 0.0
    
    
    required init(target:AnyObject?,action:Selector,root view:UIView) {
        
        self.target = target
        self.selector = action
        self.rootView = view
        
        super.init(target: self.target, action: self.selector)
    }
    
    init(target:AnyObject?,action:Selector,root view:UIView,threshold:CGFloat) {
        
        self.target = target
        self.selector = action
        self.rootView = view
        self.threshold = threshold
        
        super.init(target: self.target, action: self.selector)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
          guard let touch = touches.first else {
                return
            }
        
          state = .began
        
        if rootView.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            let maxForce = touch.maximumPossibleForce
            
            let scalePoint = touch.force * 0.1
            scale = 1 + scalePoint
            
            if touch.force >= maxForce * threshold {
                self.isThreshold = true
            } else {
                self.isThreshold = false
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        pressTime = touch.timestamp
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        pressTime = touch.timestamp - pressTime
        
        endGesture()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        
        endGesture()
    }
    
    private func endGesture() {
        scale = 1
        isThreshold = false
        state = .ended
    }
    
}//


class KTaptic {
    
    private var notificationG:UINotificationFeedbackGenerator!
    private var impactG:UIImpactFeedbackGenerator!
    private var selectionG:UISelectionFeedbackGenerator!
    private var supportLevel:Int = UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int ?? 0

    func notificationTap(_ type:UINotificationFeedbackType) {
        
        guard supportLevel == 2 else {
            print("Device Not Supported taptic engine")
            return
        }
        
        notificationG = UINotificationFeedbackGenerator()
        notificationG.notificationOccurred(type)
    }
    
     func impactTap(_ style:UIImpactFeedbackStyle) {
        
        guard supportLevel == 2 else {
            print("Device Not Supported taptic engine")
            return
        }
        
        impactG = UIImpactFeedbackGenerator(style: style)
        impactG.prepare()
        impactG.impactOccurred()
    }
    
     func tap() {
        
        guard supportLevel == 2 else {
            print("Device Not Supported taptic engine")
            return
        }
        
        selectionG = UISelectionFeedbackGenerator()
        selectionG.selectionChanged()
    }
 
}//
