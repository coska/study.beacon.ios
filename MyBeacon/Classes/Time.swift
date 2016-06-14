//
//  Time.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift


struct Days : OptionSetType
{
    let rawValue: Int
    
    static let None = Days(rawValue: 0)
    static let Sunday = Days(rawValue: 1 << 0)
    static let Monday = Days(rawValue: 1 << 1)
    static let Tuesday = Days(rawValue: 1 << 2)
    static let Wednesday = Days(rawValue: 1 << 3)
    static let Thursday = Days(rawValue: 1 << 4)
    static let Friday = Days(rawValue: 1 << 5)
    static let Saturday = Days(rawValue: 1 << 6)
    
    static func isApplicable(compare:Days, all:Days) -> Bool
    {
        return all.contains(compare)
    }
    
    static let names = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ]
}


struct Hours : OptionSetType
{
    var rawValue: Int
    
    static let None = Hours(rawValue: 0)
    
    static let _0100 = Hours(rawValue: 1 << 0)
    static let _0200 = Hours(rawValue: 1 << 1)
    static let _0300 = Hours(rawValue: 1 << 2)
    static let _0400 = Hours(rawValue: 1 << 3)
    static let _0500 = Hours(rawValue: 1 << 4)
    static let _0600 = Hours(rawValue: 1 << 5)
    static let _0700 = Hours(rawValue: 1 << 6)
    static let _0800 = Hours(rawValue: 1 << 7)
    static let _0900 = Hours(rawValue: 1 << 8)
    static let _1000 = Hours(rawValue: 1 << 9)
    static let _1100 = Hours(rawValue: 1 << 10)
    static let _1200 = Hours(rawValue: 1 << 11)
    
    static let _1300 = Hours(rawValue: 1 << 12)
    static let _1400 = Hours(rawValue: 1 << 13)
    static let _1500 = Hours(rawValue: 1 << 14)
    static let _1600 = Hours(rawValue: 1 << 15)
    static let _1700 = Hours(rawValue: 1 << 16)
    static let _1800 = Hours(rawValue: 1 << 17)
    static let _1900 = Hours(rawValue: 1 << 18)
    static let _2000 = Hours(rawValue: 1 << 19)
    static let _2100 = Hours(rawValue: 1 << 20)
    static let _2200 = Hours(rawValue: 1 << 21)
    static let _2300 = Hours(rawValue: 1 << 22)
    static let _2400 = Hours(rawValue: 1 << 23)
    
    
    static func isApplicable(compare:Hours, all:Hours) -> Bool
    {
        return all.contains(compare)
    }
    
    static let names = [
        "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM", "06:00 AM", "07:00 AM", "08:00 AM", "09:00 AM", "10:00 AM", "11:00 AM", "12:00 PM",
        "01:00 PM", "02:00 PM", "03:00 PM", "04:00 PM", "05:00 PM", "06:00 PM", "07:00 PM", "08:00 PM", "09:00 PM", "10:00 PM", "11:00 PM", "00:00 AM"
    ]
    
    static let values = [
        _0100, _0200, _0300, _0400, _0500, _0600,
        _0700, _0800, _0900, _1000, _1100, _1200,
        _1300, _1400, _1500, _1600, _1700, _1800,
        _1900, _2000, _2100, _2200, _2300, _2400
    ]
    
}

public class Day : Object
{
    dynamic var weekday : String = ""
    dynamic var hours : String = "000000000000000000000000"
    
    init(weekday:String)
    {
        self.weekday = weekday
        
        super.init()
    }
    
    required public init() {
        super.init()
    }
    
    override public static func primaryKey() -> String? {
        return "weekday"
    }
    
    public subscript(hour:Int) -> Bool
    {
    	get {
            let str = hours as NSString
            let comp = str.substringWithRange(NSRange(location: hour, length:1))
            return (comp == "1")
        }
    	set {
            let str = hours as NSString
            let head = str.substringToIndex(hour-1)
            let tail = str.substringFromIndex(hour+1)
            hours = head + (newValue ? "1" : "0") + tail
        }
    }
}

class TimeCondition : Object {
    
    let days = List<Day>()
    
    func initDays()
    {
    	if days.count == 0
    	{
        	for day in Days.names
        	{
            	days.append(Day(weekday: day))
        	}
    	}
    }
    
    func isApplicable(dateVal:NSDate) -> Bool {
        let cal = NSCalendar.currentCalendar()
        let date = cal.components([.Hour, .Weekday], fromDate: dateVal)
        return days[date.weekday][date.hour]
    }
    
    func isValid(row: Int, col:Int) -> Bool {
        return (row >= 0 && row < Hours.names.count) &&
               (col >= 0 && col < Days.names.count)
    }
    
    subscript(row:Int, col:Int) -> Bool {
        get {
            initDays()
            return days.count > row && days[col][row]
        }
        set {
            initDays()
            days[col][row] = newValue
        }
    }
    
}
