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
    var duration = 2.0
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
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        toViewController.view.frame = CGRect(x: 0, y: -5000, width: 100, height: 100)
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            fromViewController.view.alpha = 0.5
            toViewController.view.frame = finalFrameForVC
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        })
    }
    
    /*func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transitionMode == .present {
            let containerView = transitionContext.containerView
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startinngPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startinngPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startinngPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                presentedView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: { (success: Bool) in
                    transitionContext.completeTransition(success)
                })
            } else {
                let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
                if let returningView = transitionContext.view(forKey: transitionModeKey) {
                    let viewCenter = returningView.center
                    let viewSize = returningView.frame.size
                    circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startinngPoint)
                    circle.layer.cornerRadius = circle.frame.size.height / 2
                    circle.center = startinngPoint
                    UIView.animate(withDuration: duration, animations: {
                        self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                        returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                        returningView.center = self.startinngPoint
                        returningView.alpha = 0
                        if self.transitionMode == .pop {
                            containerView.insertSubview(returningView, belowSubview: returningView)
                            containerView.insertSubview(self.circle, belowSubview: returningView)
                        }
                    }, completion: { (success: Bool) in
                        returningView.center = viewCenter
                        returningView.removeFromSuperview()
                        self.circle.removeFromSuperview()
                        transitionContext.completeTransition(success)
                    })
                }
            }
        }
    }*/
    
    func frameForCircle(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.y, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        let offSetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offSetVector, height: offSetVector)
        return CGRect(origin: CGPoint.zero, size: size)
    }
}

