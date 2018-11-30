//
//  StopwatchViewController.swift
//  DurationUnit4
//
//  Created by Peter Saathoff-Harshfield on 11/8/18.
//  Copyright © 2018 Peter Saathoff-Harshfield. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    var started = false
    var buttonState = "Start"
    var stopwatch = Stopwatch()
    
//    let redButtonColor = UIColor(red: 80.0/255.0, green: 0.0, blue: 0.0, alpha: 1.0)
    let redButtonColor = UIColor(red: 137.0/255.0, green: 94.0/255.0, blue: 0.0, alpha: 1.0)
    let greenButtonColor = UIColor(red: 0.0, green: 80.0/255.0, blue: 0.0, alpha: 1.0)
    let greyColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
    
//    let blueColor = UIColor(red: 0.0, green: 0.0, blue: 0.99, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Stopwatch view loaded")
        
        startStopButton.layer.cornerRadius = 50;
        startStopButton.layer.masksToBounds = true;
        startStopButton.setTitle("Start", for: .normal)
        
        resetButton.layer.cornerRadius = 50;
        resetButton.layer.masksToBounds = true;
        resetButton.setTitle("Reset", for: .normal) //change to lap
        resetButton.backgroundColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        
        updateButtons()
        
        continuousUpdate()
    }
    
    func continuousUpdate() {
        let _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            self.stopwatchDisplay.text = self.stopwatch.rolling().getTimeWithCentiWithoutDU()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var stopwatchDisplay: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    
    func setButtonColor(color: String) {
        print("color: \(color)")
        if color == "Start" || color == "Resume" {
            print("green")
            startStopButton.setBackgroundColor(color: UIColor(red: 0.05, green: 0.3, blue: 0.05, alpha: 1.0), forState: .normal)
            startStopButton.setBackgroundColor(color: UIColor(red: 0.05, green: 0.3, blue: 0.05, alpha: 1.0), forState: .highlighted)
        }
        if color == "Pause" {
            print("red")
            startStopButton.setBackgroundColor(color: redButtonColor, forState: .normal)
            startStopButton.setBackgroundColor(color: redButtonColor, forState: .highlighted)
        }
    }
    
    @IBAction func startStop(_ sender: UIButton) {
        stopwatch.startStop()
        updateButtons()
    }
    
    
    @IBAction func reset(_ sender: UIButton) {
        stopwatch.reset()
        updateButtons()
    }
    
    func updateButtons() {
        print("updating buttons...")
        let state = stopwatch.buttonState()
        startStopButton.setTitle(state, for: .normal)
        setButtonColor(color: state)
        
        if state == "Start" {
            resetButton.isHidden = true
        }
        else if state == "Pause" {
            resetButton.isHidden = true
        }
        else if state == "Resume" {
            resetButton.isHidden = false
        }
    }
}


extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}

