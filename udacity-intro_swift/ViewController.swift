//
//  ViewController.swift
//  udacity-intro_swift
//
//  Created by Alexandro on 8/19/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var lblRecording: UILabel!
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func recordAudio(sender: UIButton) {
        println("recording")
        if !isRecording {
            isRecording = true
            UIView.animateWithDuration(1.5, delay: 0.5, options: UIViewAnimationOptions.Repeat, animations: { () -> Void in
                self.lblRecording.alpha = 1
            }, completion: nil)
            
        }
    }

}

