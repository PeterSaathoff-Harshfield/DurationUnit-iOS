//
//  Stopwatch.swift
//  DurationUnit2
//
//  Created by Peter Saathoff-Harshfield on 10/28/18.
//  Copyright © 2018 Peter Saathoff-Harshfield. All rights reserved.
//

import Foundation

class Stopwatch {
    
    var rollingTime: DurationUnit
    var sessionStartTime: DurationUnit
    var currentTime: DurationUnit
    var laps: [DurationUnit]
    var started: Bool
    var running: Bool
    
    init() {
        rollingTime = DurationUnit()
        rollingTime.zero()
        sessionStartTime = DurationUnit()
        currentTime = DurationUnit()
        //        currentTime.du_unit = 0
        //        currentTime.du_minute = 0
        //        currentTime.du_second = 0
        //        currentTime.du_centi = 0
        
        laps = [DurationUnit]()
        started = false
        running = false
    }
    
    func rolling() -> DurationUnit {
        if running {
            currentTime.updateTime()
            return rollingTime + currentTime - sessionStartTime
        }
        else {
            return rollingTime
        }
        
    }
    
    
    func startStop() {
        if !started {
            started = true
            running = true
            rollingTime.zero()
            sessionStartTime.updateTime()
            currentTime.updateTime()
        }
        else {
            if running {
                running = false
                currentTime.updateTime()
                rollingTime = rollingTime + (currentTime - sessionStartTime)
            }
            else {
                running = true
                sessionStartTime.updateTime()
                currentTime.updateTime()
            }
        }
        
    }
    
    func buttonState() -> String {
        if !started {
            return "Start"
        }
        else {
            if running {
                return "Pause"
            }
            else {
                return "Resume"
            }
        }
    }
    
    func reset() {
        if !running {
            sessionStartTime = DurationUnit()
            currentTime = DurationUnit()
            rollingTime.zero()
            
            laps = [DurationUnit]()
            started = false
            running = false
        }
    }
}
