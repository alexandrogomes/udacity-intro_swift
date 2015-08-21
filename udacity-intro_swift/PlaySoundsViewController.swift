//
//  PlaySoundsViewController.swift
//  udacity-intro_swift
//
//  Created by Alexandro on 8/20/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func playWithRate(rateValue:Float) {
        audioPlayer.stop()
        audioPlayer.rate = rateValue
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func actionPlaySlow(sender: UIButton) {
        playWithRate(0.5)
    }
    
    @IBAction func actionPlayFast(sender: UIButton) {
        playWithRate(1.5)
    }

    @IBAction func actionStop(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func actionChipmunk(sender: UIButton) {
    }
    
}
