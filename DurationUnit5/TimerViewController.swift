//
//  TimerViewController.swift
//  MultiPickerTest2
//
//  Created by Peter Saathoff-Harshfield on 11/12/18.
//  Copyright © 2018 Peter Saathoff-Harshfield. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var timer = DUTimer(du_unit: 0, du_minute: 0, du_second: 0, du_centi: 0)
    
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var picker3: UIPickerView!
    
    
    @IBOutlet weak var unitLabel1: UILabel!
    @IBOutlet weak var unitLabel2: UILabel!
    @IBOutlet weak var unitLabel3: UILabel!
    
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startPauseResume: UIButton!
    
    
    
    
    
    let pickerTextColor = UIColor(red: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 1.0)
    let greenColor = UIColor(red: 0.05, green: 0.3, blue: 0.05, alpha: 1.0)
    //    let redColor = UIColor(red: 0.3, green: 0.05, blue: 0.05, alpha: 1.0)
    let redColor = UIColor(red: 137.0/255.0, green: 94.0/255.0, blue: 0.0, alpha: 1.0)
    let greyColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    let yellowColor = UIColor(red: 228.0/255.0, green: 154.0/255.0, blue: 57.0/255.0, alpha: 1.0)
    
    let pickerData1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    let pickerData2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99]
    //    let pickerData3 = pickerData2
    
    var selectedTime: [Int] = [0, 0, 0] {
        didSet {
            timer.set(du_unit: selectedTime[0], du_minute: selectedTime[1], du_second: selectedTime[2], du_centi: 0)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker1 {
            return 10
        }
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String(pickerData2[row]), attributes: [NSAttributedString.Key.foregroundColor: pickerTextColor])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker1 {
            selectedTime[0] = pickerData1[row]
        }
        if pickerView == picker2 {
            selectedTime[1] = pickerData2[row]
        }
        if pickerView == picker3 {
            selectedTime[2] = pickerData2[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func startPauseResume(_ sender: UIButton) {
        if !timer.started {
            picker1.isHidden = true
            picker2.isHidden = true
            picker3.isHidden = true
            unitLabel1.isHidden = true
            unitLabel2.isHidden = true
            unitLabel3.isHidden = true
            
            display.isHidden = false
            
            sender.setBackgroundColor(color: redColor, forState: .normal)
            sender.setBackgroundColor(color: redColor, forState: .highlighted)
            
        }
        else if timer.running {
            
            
        }
        
        
        timer.startPauseResume()
        
        startPauseResume.setTitle(timer.buttonState(), for: .normal)
        if timer.buttonState() == "Pause" {
            startPauseResume.setBackgroundColor(color: redColor, forState: .normal)
            startPauseResume.setBackgroundColor(color: redColor, forState: .highlighted)
        }
        else if timer.buttonState() == "Resume" {
            startPauseResume.setBackgroundColor(color: greenColor, forState: .normal)
            startPauseResume.setBackgroundColor(color: greenColor, forState: .highlighted)
        }
        
        
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.reset()
        
        picker1.isHidden = false
        picker2.isHidden = false
        picker3.isHidden = false
        unitLabel1.isHidden = false
        unitLabel2.isHidden = false
        unitLabel3.isHidden = false
        
        display.isHidden = true
        
        startPauseResume.setBackgroundColor(color: greenColor, forState: .normal)
        startPauseResume.setBackgroundColor(color: greenColor, forState: .highlighted)
        startPauseResume.setTitle("Start", for: .normal)
        startPauseResume.setTitle("Start", for: .highlighted)
    }
    
    func continuouslyUpdate() {
        let _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { repeatingTimer in
            if self.timer.started {
                self.display.text = self.timer.remaining()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker1.delegate = self
        picker1.dataSource = self
        picker2.delegate = self
        picker2.dataSource = self
        picker3.delegate = self
        picker3.dataSource = self
        
        unitLabel1.textColor = yellowColor
        unitLabel2.textColor = yellowColor
        unitLabel3.textColor = yellowColor
        unitLabel1.text = "DU"
        unitLabel2.text = "min"
        unitLabel3.text = "sec"
        unitLabel1.font = unitLabel1.font.withSize(25)
        unitLabel2.font = unitLabel2.font.withSize(25)
        unitLabel3.font = unitLabel3.font.withSize(25)
        
        startPauseResume.layer.cornerRadius = 50;
        startPauseResume.layer.masksToBounds = true;
        resetButton.layer.cornerRadius = 50;
        resetButton.layer.masksToBounds = true;
        
        startPauseResume.setBackgroundColor(color: greenColor, forState: .normal)
        startPauseResume.setBackgroundColor(color: greenColor, forState: .highlighted)
        resetButton.setBackgroundColor(color: greyColor, forState: .normal)
        resetButton.setBackgroundColor(color: greyColor, forState: .normal)
        
        startPauseResume.setTitleColor(pickerTextColor, for: .normal)
        startPauseResume.setTitleColor(pickerTextColor, for: .highlighted)
        resetButton.setTitleColor(pickerTextColor, for: .normal)
        resetButton.setTitleColor(pickerTextColor, for: .highlighted)
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitle("Reset", for: .highlighted)
        startPauseResume.setTitle("Start", for: .normal)
        startPauseResume.setTitle("Start", for: .highlighted)
        
        continuouslyUpdate()
        display.textColor = pickerTextColor
        display.isHidden = true
        
    }
    
    
}

