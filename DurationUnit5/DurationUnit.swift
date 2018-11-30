import Foundation

class DurationUnit {
    
    var date:Date
    var calendar:Calendar
    
    //standard time
    var hour:Int
    var minute:Int
    var second:Int
    var nanosecond:Int
    
    //duration unit time
    var du_unit:Int
    var du_minute:Int
    var du_second:Int
    var du_centi: Int
    
    init() {
        date = Date()
        calendar = Calendar.current
        
        hour = calendar.component(.hour, from: date)
        minute = calendar.component(.minute, from: date)
        second = calendar.component(.second, from: date)
        nanosecond = calendar.component(.nanosecond, from: date)
        
        let nanosecondsInDay = 24*60*60*1000000000
        let nanosecondsSoFar = (hour*60*60 + minute*60 + second)*1000000000 + nanosecond
        let elapsedPortion = Double(nanosecondsSoFar) / Double(nanosecondsInDay)
        
        du_unit = Int(elapsedPortion * 10)
        du_minute = Int(elapsedPortion * 1000) % 100
        du_second = Int(elapsedPortion * 100000) % 100
        du_centi = Int(elapsedPortion * 10000000) % 100
    }
    
    func updateTime() {
        date = Date()
        calendar = Calendar.current
        
        hour = calendar.component(.hour, from: date)
        minute = calendar.component(.minute, from: date)
        second = calendar.component(.second, from: date)
        nanosecond = calendar.component(.nanosecond, from: date)
        
        let nanosecondsInDay = 24*60*60*1000000000
        let nanosecondsSoFar = (hour*60*60 + minute*60 + second)*1000000000 + nanosecond
        let elapsedPortion = Double(nanosecondsSoFar) / Double(nanosecondsInDay)
        
        du_unit = Int(elapsedPortion * 10)
        du_minute = Int(elapsedPortion * 1000) % 100
        du_second = Int(elapsedPortion * 100000) % 100
        du_centi = Int(elapsedPortion * 10000000) % 100
    }
    
    func zero() {
        du_unit = 0
        du_minute = 0
        du_second = 0
        du_centi = 0
    }
    
    func getTime() -> String {
        return "\(du_unit):\(String(format: "%02d", du_minute)):\(String(format: "%02d", du_second))"
    }
    
    func getTimeWithCenti() -> String {
        return "\(du_unit):\(String(format: "%02d", du_minute)):\(String(format: "%02d", du_second)):\(String(format: "%02d", du_centi))"
    }
    
    func getTimeWithCentiWithoutDU() -> String {
        return "\(String(format: "%02d", du_minute)):\(String(format: "%02d", du_second)):\(String(format: "%02d", du_centi))"
    }
    
    func getStandardTime() -> String {
        return "  \(hour):\(String(format: "%02d", minute)):\(String(format: "%02d", second))"
    }
    static func +(lhs: DurationUnit,  rhs: DurationUnit) ->DurationUnit {
        var result = DurationUnit()
        
        let lhs_int: Int = lhs.du_unit*1000000 +
            lhs.du_minute*10000 +
            lhs.du_second*100 +
            lhs.du_centi
        let rhs_int: Int = rhs.du_unit*1000000 +
            rhs.du_minute*10000 +
            rhs.du_second*100 +
            rhs.du_centi
        
        var result_int = lhs_int + rhs_int
        
        if (result_int > 10000000) {
            result_int = result_int - 10000000
        }
        
        result.du_unit = (result_int / 1000000) % 10
        result.du_minute = (result_int / 10000) % 100
        result.du_second = (result_int / 100) % 100
        result.du_centi = result_int % 100
        
        return result
        
    }
    
    static func -(lhs: DurationUnit, rhs: DurationUnit) -> DurationUnit {
        var result = DurationUnit()
        
        let lhs_int: Int = lhs.du_unit*1000000 +
            lhs.du_minute*10000 +
            lhs.du_second*100 +
            lhs.du_centi
        let rhs_int: Int = rhs.du_unit*1000000 +
            rhs.du_minute*10000 +
            rhs.du_second*100 +
            rhs.du_centi
        
        var result_int = lhs_int - rhs_int
        
        if (result_int < 0) {
            result_int = 10000000 + result_int
        }
        
        result.du_unit = (result_int / 1000000) % 10
        result.du_minute = (result_int / 10000) % 100
        result.du_second = (result_int / 100) % 100
        result.du_centi = result_int % 100
        
        return result
    }
    
    
}
extension DurationUnit: Equatable {
    static func == (lhs: DurationUnit, rhs: DurationUnit) -> Bool {
        let lhs_int: Int = lhs.du_unit*1000000 +
            lhs.du_minute*10000 +
            lhs.du_second*100 +
            lhs.du_centi
        let rhs_int: Int = rhs.du_unit*1000000 +
            rhs.du_minute*10000 +
            rhs.du_second*100 +
            rhs.du_centi
        if lhs_int == rhs_int {
            return true
        }
        return false
    }
}

extension DurationUnit: Comparable {
    static func < (lhs: DurationUnit, rhs: DurationUnit) -> Bool {
        let lhs_int: Int = lhs.du_unit*1000000 +
            lhs.du_minute*10000 +
            lhs.du_second*100 +
            lhs.du_centi
        let rhs_int: Int = rhs.du_unit*1000000 +
            rhs.du_minute*10000 +
            rhs.du_second*100 +
            rhs.du_centi
        
        if lhs_int < rhs_int {
            return true
        }
        return false
    }
}
