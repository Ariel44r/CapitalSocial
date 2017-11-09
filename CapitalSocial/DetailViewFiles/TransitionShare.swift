//
//  TransitionShare.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 07/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class TransitionShare: NSObject {

    var circle = UIView()
    var startinngPoint = CGPoint.zero {
        didSet {
            circle.center = startinngPoint
        }
    }
    
    var circleColor = UIColor.white
    var duration = 0.4
    enum CircularTransitionMode:Int {
        case present, dismiss, pop
    }
    var transitionMode: CircularTransitionMode = .present
}

extension TransitionShare: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                circle = UIView()
            } else {
                
            }
        }
    }
    
    func frameForCircle(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.y, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        let offSetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offSetVector, height: offSetVector)
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
