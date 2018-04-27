//
//  MinneapolisViewController.swift
//  CustomViewControllerTransitionsTask
//
//  Created by Robert Berry on 4/26/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit

class MinneapolisViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Properties

    @IBOutlet weak var returnHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Action Method

    @IBAction func tappedReturnHomeButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
