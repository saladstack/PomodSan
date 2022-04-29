//
//  ViewController.swift
//  PomodoroCoreData
//
//  Created by Shaqina Yasmin on 28/04/22.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var focusLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var breakButton: UIButton!
    
    var timer:Timer = Timer()
    var breakTimer:Timer = Timer()
    var count:Int = 1500
    var breakCount:Int = 300
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func resetTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reset Timer", message: "Are you sure you would like to reset timer?", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
             // do nothing
         }))
         alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
             self.count = 1500
             self.timer.invalidate()
             self.timerLabel.text = self.makeTimeString(minutes: 25, seconds: 0)
             self.startStopButton.setTitle("Start", for: .normal)
             
         }))
         
         self.present(alert, animated: true, completion: nil)
     }
    
    @IBAction func startStopTapped(_ sender: UIButton) {
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("Start", for: .normal)
        }
        else{
            timerCounting = true
            startStopButton.setTitle("Pause", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func breakTapped(_ sender: UIButton) {
        timer.invalidate()
        count = 300
        focusLabel.text = "Time to break"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(breakCounter), userInfo: nil, repeats: true)
    }
    
    @objc func timerCounter() -> Void{
        if (count >= 0){ //check if timer is greater than 0
            let time = secondsToMinutesSeconds(seconds: count)
            let timeString = makeTimeString(minutes: time.0, seconds: time.1)
                timerLabel.text = timeString
            count -= 1
        }
        
        else {
            count = 0// stop timer if it has reached 0
            
        }
    }
    
    @objc func breakCounter() -> Void{
        breakCount -= 1
        let time1 = secondsToMinutesSeconds(seconds: count)
        let timeString1 = makeTimeString(minutes: time1.0, seconds: time1.1)
        timerLabel.text = timeString1
        
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int){
        return (((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(minutes : Int, seconds : Int) -> String{
        var timeString = ""

        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

