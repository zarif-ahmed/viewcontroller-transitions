# viewcontroller-transitions

Use the classes in the Transitions folder of the project to customize the direction of push and pop of your view controller.
You will be able to push a view controller with a present(modal) animation.


There are 2 main classses in the project where th magic happens :
- NavigationControllerDelegate:
    Set your UINavigationController instance delegate to an instance of this class.

    - Provide 2 parameters while init :
        - isPush : to differentiate between push and pop
        - direction : Push/Pop direction. This is an enum.

            Make the direction of push and pop are opposite to each other i.e if you are pushing from bottom then pop from top.
            enum AnimationDirection {

                case FromLeft
                case FromRight
                case FromTop
                case FromBottom
            }

    This class contains UINavigationControllerDelegate method that returns the custom animator object that will be used while push/pop of a view controller. If you return nil in this delegate method, the push/pop animation will occur with a default animation.

   
        @IBAction func pushAction(_ sender: AnyObject) {

            if let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as? SecondVC {
                let navigationControlDelegate = NavigationControllerDelegate(isPush: true, direction: .FromBottom)
                self.navigationController?.delegate = navigationControlDelegate
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
        }


- PushPopAnimator:
    Implements the cutom animation of the push and pop by implementing UIViewControllerAnimatedTransitioning protocol. 

        //MARK: UIViewControllerAnimatedTransitioning
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            /// duration of animation
        }

        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            /// custom animation
        }
