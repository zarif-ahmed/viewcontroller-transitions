//
//  TransitionDelegate.swift
//  DebX
//
//  Created by Zarif Ahmed on 9/23/16.
//  Copyright © 2016 Nataraj. All rights reserved.
//

import UIKit


/**
 Set your navigation controller delegate to an instance of this class.
 Provide 2 parameters while init :
 -isPush : to differentiate between push and pop
 -direction : Push/Pop direction.
 */
class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    let direction : AnimationDirection
    let isPush : Bool
    
    init(isPush : Bool, direction: AnimationDirection) {
        
        self.isPush = isPush
        self.direction = direction
        
        super.init()
    }
    
    
    
//MARK: UINavigationControllerDelegate
    
/**
     Whenever a view controller pushes or pops a controller this delegate method is called. If an animator pbject is returned by this delegate then push/pop occurs with your custom animation. Else push/pop occurs with a default animation.
*/
func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController ) -> UIViewControllerAnimatedTransitioning? {
        
        return PushPopAnimator(isPush : self.isPush, direction : self.direction)
    }
}
