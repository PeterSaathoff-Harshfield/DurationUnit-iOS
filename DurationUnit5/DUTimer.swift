//
//  DUTimer.swift
//  DurationUnitTimer
//
//  Created by Peter Saathoff-Harshfield on 10/31/18.
//  Copyright © 2018 Peter Saathoff-Harshfield. All rights reserved.
//

import Foundation

class DUTimer {
    
    var totalDuration: DurationUnit
    var elapsedDuration: DurationUnit
    
    //    var startTime: DurationUnit
    var sessionStartTime: DurationUnit
    var currentTime: DurationUnit
    
    var started: Bool
    var running: Bool
    
    init(du_unit: Int, du_minute: Int, du_second: Int, du_centi: Int) {
        
        totalDuration = DurationUnit()
        totalDuration.du_unit = du_unit
        totalDuration.du_minute = du_minute
        totalDuration.du_second = du_second
        totalDuration.du_centi = du_centi
        
        elapsedDuration = DurationUnit()
        elapsedDuration.zero()
        
        //        startTime = DurationUnit()
        sessionStartTime = DurationUnit()
        currentTime = DurationUnit()
        
        started = false
        running = false
        
        
        
    }
    
    func set(du_unit: Int, du_minute: Int, du_second: Int, du_centi: Int) { //set to a different duration than duation at initialization
        if !started && !running {
            totalDuration.du_unit = du_unit
            totalDuration.du_minute = du_minute
            totalDuration.du_second = du_second
            totalDuration.du_centi = du_centi
            
        }
        
    }
    
    func reset() {
        started = false
        running = false
        elapsedDuration.zero()
        currentTime.updateTime()
        
    }
    
    func startPauseResume() {
        if !started {
            started = true
            running = true
            sessionStartTime.updateTime()
            currentTime.updateTime()
            
            elapsedDuration.zero()
            
        }
        else if running {
            running = false
            currentTime.updateTime()
            
            elapsedDuration = elapsedDuration + (currentTime - sessionStartTime)
            
            
        }
        else if !running {
            running = true
            sessionStartTime.updateTime()
            currentTime.updateTime()
            
            
        }
    }
    
    func didFinish() -> Bool {
        if !started {
            return false
        }
        else {
            if running {
                currentTime.updateTime()
                if totalDuration <= elapsedDuration + (currentTime - sessionStartTime) {
                    return true
                }
                return false
            }
            else {
                if elapsedDuration < totalDuration {
                    return false
                }
                return true
            }
        }
    }
    
    func buttonState() -> String {
        if !started {
            return "Start"
        }
        if running {
            return "Pause"
        }
        if !running {
            return "Resume"
        }
        return "fail"
    }
    
    func remaining() -> String {
        if self.didFinish() {
            return "0:00:00"
        }
        if !started {
            return (totalDuration - elapsedDuration).getTime()
        }
        if running {
            currentTime.updateTime()
            return (totalDuration - (elapsedDuration + (currentTime - sessionStartTime))).getTime()
        }
        else if !running {
            return (totalDuration - elapsedDuration).getTime()
        }
        
        return "fail"
        //        let result = totalDuration - elapsedDuration
        //        return result.getTime()
    }
    
}
