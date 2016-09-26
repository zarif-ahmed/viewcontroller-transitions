//
//  CustomTransition.swift
//  DebX
//
//  Created by Zarif Ahmed on 9/23/16.
//  Copyright © 2016 Nataraj. All rights reserved.
//


import UIKit



/** Supported directions for push and pop.
    Make the direction of push and pop are opposite to each other i.e if you are pushing from bottom then pop from top.
 */
enum AnimationDirection {
    
    case FromLeft
    case FromRight
    case FromTop
    case FromBottom
}


class PushPopAnimator : NSObject, UIViewControllerAnimatedTransitioning  {
    
    let isPush : Bool
    let direction : AnimationDirection
    let duration: TimeInterval = 0.5
    
    private var initialToVCView = UIView()
    private var finalToVCView = UIView()
    
    private var initialFromVCView = UIView()
    private var finalFromVCView = UIView()
    
    init(isPush : Bool, direction : AnimationDirection) {
        self.isPush = isPush
        self.direction = direction
        
        super.init()
    }
    
    
    //MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        if fromVC == nil || toVC == nil {
            return
        }
        
        containerView.addSubview(toVC!.view)
        
        self.getInitialFinalAnimationView()
        
        if self.isPush {
            self.pushAnimation(fromVC : fromVC!, toVC : toVC!, transitionContext: transitionContext)
        }
        else {
            self.popAnimation(fromVC : fromVC!, toVC : toVC!, transitionContext: transitionContext)
        }
    }
    
    
    //MARK : User Defined
    func pushAnimation(fromVC : UIViewController, toVC : UIViewController, transitionContext : UIViewControllerContextTransitioning) {
        
        toVC.view.frame = self.initialToVCView.frame
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        UIView.animate(withDuration: self.duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            toVC.view.frame = self.finalToVCView.frame
            
            }) { (flag) in
                
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let cancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!cancelled)
        }
        
    }
    
    
    func popAnimation(fromVC : UIViewController, toVC : UIViewController, transitionContext : UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        toVC.view.frame = self.finalToVCView.frame
        fromVC.view.frame = self.initialFromVCView.frame
        
        containerView.addSubview(toVC.view)
        containerView.sendSubview(toBack: toVC.view)
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        UIView.animate(withDuration: self.duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            fromVC.view.frame = self.finalFromVCView.frame
            
            }) { (flag) in
                
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let cancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!cancelled)
        }
    
    }
    
    
    
    func getInitialFinalAnimationView() {
        
        switch self.direction {
            
        case .FromLeft :
            self.initialToVCView.frame = CGRect.init(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.finalToVCView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            self.initialFromVCView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.finalFromVCView.frame = CGRect.init(x: UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
        case .FromRight :
            self.initialToVCView.frame = CGRect.init(x: UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.finalToVCView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            self.initialFromVCView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.finalFromVCView.frame = CGRect.init(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            
        case .FromTop :
            self.initialToVCView.frame = CGRect.init(x: 0, y: -UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.finalToVCView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            self.initialFromVCView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.finalFromVCView.frame = CGRect.init(x: 0, y:  UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
        case .FromBottom :
            
            self.initialToVCView.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.finalToVCView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            self.initialFromVCView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.finalFromVCView.frame = CGRect.init(x: 0, y: -UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
        }
    }
    
}

