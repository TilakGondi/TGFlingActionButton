//
//  ViewController.swift
//  TGFlingActionButton
//
//  Created by Tilakkumar Gondi on 23/05/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lbl_progressState: UILabel!
    @IBOutlet weak var fling_button: TGFlingActionButton!
    override func viewDidLoad() {
        lbl_progressState.text = ""
        super.viewDidLoad()
    }

    
    //Connect the IBAction method with the action type value changed from storyboard
    @IBAction func flingActionCallback(_ sender: TGFlingActionButton) {
        print(sender.swipe_direction)
        if sender.swipe_direction == .right {
            
            //TO DO: Add the code for actions to be performed once the user swipe the button to right.
            lbl_progressState.text = "Process Started..."
            self.activityIndicator.startAnimating()
        }
    }
    
    
    
}

