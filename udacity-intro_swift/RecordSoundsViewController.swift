//
//  RecordSoundsViewController.swift
//  udacity-intro_swift
//
//  Created by Alexandro on 8/19/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var recordedAudio:RecordedAudio!
    var audioRecorder:AVAudioRecorder!
    var isRecording = false
    
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblRecording: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        hideElementsWhenStopRecord()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("prepareForSegue")
        if (segue.identifier == "showPlaySounds") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
        
    }
    
    func hideElementsWhenStopRecord() {
        btnStop.hidden = true
        btnStop.alpha = 1
        lblRecording.alpha = 0
        self.lblRecording.layer.removeAllAnimations()
    }

    func recordAudio() {
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        self.audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        self.audioRecorder.delegate = self
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.record()
    }
    
    func stopAudio() {
        self.audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    //MARK: Actions
    
    @IBAction func actionRecord(sender: UIButton) {
        println("recording")
        
        if !isRecording {
            self.recordAudio()
            isRecording = true
            btnStop.hidden = false
            UIView.animateWithDuration(1.5, delay: 0.5, options: UIViewAnimationOptions.Repeat, animations: { () -> Void in
                self.lblRecording.alpha = 1
                }, completion: {(finish) -> Void in
                    
                })
            
        } else {
            hideElementsWhenStopRecord()
            self.isRecording = false
            self.stopAudio()
        }
    }


    @IBAction func actionStop(sender: UIButton) {
        self.isRecording = false
        self.stopAudio()
        UIView.animateWithDuration(1.5, delay: 0.5, options: nil, animations: { () -> Void in
                self.btnStop.alpha = 0
            }, completion: { (finish) -> Void in
                self.hideElementsWhenStopRecord()
            })

        
    }
    
    //MARK: AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        recordedAudio = RecordedAudio()
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
        self.performSegueWithIdentifier("showPlaySounds", sender: recordedAudio)
    }

}

