//
//  ViewController.swift
//  viewcontroller-transitions
//
//  Created by Zarif Ahmed on 9/26/16.
//  Copyright © 2016 Zarif Ahmed. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pushAction(_ sender: AnyObject) {
        
        if let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as? SecondVC {
            let navigationControlDelegate = NavigationControllerDelegate(isPush: true, direction: .FromBottom)
            self.navigationController?.delegate = navigationControlDelegate
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
}

