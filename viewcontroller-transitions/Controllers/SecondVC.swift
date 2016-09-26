//
//  SecondVC.swift
//  viewcontroller-transitions
//
//  Created by Zarif Ahmed on 9/26/16.
//  Copyright © 2016 Zarif Ahmed. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func popAction(_ sender: AnyObject) {
        
        let navigationControlDelegate = NavigationControllerDelegate(isPush: false, direction: .FromTop)
        self.navigationController?.delegate = navigationControlDelegate
        let _ = self.navigationController?.popViewController(animated: true)
    }
   

}
