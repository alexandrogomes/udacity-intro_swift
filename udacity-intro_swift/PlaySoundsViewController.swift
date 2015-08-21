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
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func playWithRate(rateValue:Float) {
        //stop and reset the audioEngine
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.stop()
        audioPlayer.rate = rateValue
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
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
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func actionDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
}
