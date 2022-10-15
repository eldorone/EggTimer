//  ViewController.swift
//  EggTimer
//
//  Created by Eldor Alikuvvatov on 2022/10/15
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }
    
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var eggLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness: String = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progress.progress = 0.0
        secondsPassed = 0
        eggLabel.text = hardness
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progress.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            eggLabel.text = "DONE!"
            playSound()
        }
          
    }
        
}
