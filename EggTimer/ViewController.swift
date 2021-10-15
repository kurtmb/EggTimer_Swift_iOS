//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

func playSound() {
    guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

        /* iOS 10 and earlier require the following line:
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

        guard let player = player else { return }

        player.play()

    } catch let error {
        print(error.localizedDescription)
    }
}

class ViewController: UIViewController {
    
    let eggTimes = ["Soft":5, "Medium":7, "Hard":12]
    
    var secondsRemaining = 30
    var totalTime = 60
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        secondsRemaining = eggTimes[hardness]!
        totalTime = eggTimes[hardness]!
//        print(totalTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
        }
    @objc func updateTimer(){
        if secondsRemaining >= 0{
            print("\(secondsRemaining) Seconds.")
            secondsRemaining -= 1
        }
        
        if secondsRemaining == -1 {
            thisLabel.text = "Done"
            playSound()
            secondsRemaining = -2
        } else if secondsRemaining == -2{
            thisLabel.text = "Done"
        } else {
            thisLabel.text = "How do you like your eggs?"
        }
        
        progressBar2.progress = (Float(totalTime)-Float(secondsRemaining))/Float(totalTime)
        
    }
    
    @IBOutlet weak var thisLabel: UILabel!
    @IBOutlet weak var progressBar2: UIProgressView!
}

