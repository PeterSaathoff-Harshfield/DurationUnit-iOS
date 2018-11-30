//
//  TimeViewController.swift
//  DurationUnit4
//
//  Created by Peter Saathoff-Harshfield on 11/8/18.
//  Copyright © 2018 Peter Saathoff-Harshfield. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    
    @IBOutlet weak var introText: UILabel!
    
    @IBOutlet weak var display: UILabel!
    
    var du = DurationUnit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("time view loaded")
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            self.du.updateTime()
            self.display.text = self.du.getTime()
        }

        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

