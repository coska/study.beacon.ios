//
//  Time.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift

enum TimeType : String
{
	case None = "None"
    case TimeOfDay = "Time of day"
    case DayOfWeek = "Day in week"
    case DayOfMonth = "Day of month"
    case WeekOfMonth = "Week of month"
    case MonthOfYear = "Month of year"
    
	var description: String {
		return self.rawValue
	}
	
	static let names = [
		None.rawValue,
		TimeOfDay.rawValue,
		DayOfWeek.rawValue,
		DayOfMonth.rawValue,
		WeekOfMonth.rawValue,
		MonthOfYear.rawValue
	]
    
    //TODO
    // 2. Change title as When & Where
    // 3. Google Map 
    // 4. Icons
    // 5. Each screen can have guidance graphics

    static let pickerNone = []
    
    static let pickerTime = [
        [ "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" ],
        [ "00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55" ],
        [ "AM", "PM" ]
    ]
    
    static let pickerDayOfWeek = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ]
    
    static let pickerDayOfMonth = [
        "1st",   "2nd",  "3rd",  "4th",  "5th",  "6th",  "7th",  "8th",  "9th", "10th",
        "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th",
        "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th",
        "31st"
    ]
    
    static let pickerWeek = [
        "1st week", "2nd week", "3rd week", "4th week", "5th week"
    ]
    
    static let pickerMonth = [
    "January", "Feburary", "March", "April", "May", "June", "July", "August", "September", "November", "December"
    ]
    
    static let pickers = [
        TimeType.None : pickerNone,
		TimeType.TimeOfDay: pickerTime,
		TimeType.DayOfWeek: pickerDayOfWeek,
		TimeType.DayOfMonth: pickerDayOfMonth,
		TimeType.WeekOfMonth: pickerWeek,
		TimeType.MonthOfYear: pickerMonth
    ]
    
	static func getType(type:String) -> TimeType {
		switch (type)
		{
		case None.rawValue: return None
		case TimeOfDay.rawValue: return TimeOfDay
		case DayOfWeek.rawValue: return DayOfWeek
        case DayOfMonth.rawValue: return DayOfMonth
        case WeekOfMonth.rawValue: return WeekOfMonth
		case MonthOfYear.rawValue: return MonthOfYear
			
		default:
			return None
		}
	}
}

class Time : Object {
	
	private var _type = TimeType.None
	
	dynamic var name = ""
	
	dynamic var year = 1970
	dynamic var month = 1
	dynamic var day = 1
	dynamic var hour = 0
	dynamic var minute = 0
	dynamic var second = 0
	dynamic var type : String {
		get {
			return _type.rawValue
		}
		set {
			_type = TimeType.getType(newValue)
		}
	}
	
	func isApplicable() -> Bool {
		
		let fmt = NSDateFormatter()
		fmt.dateFormat = "yyyy-MM-dd hh:mm:ss"
		let dateVal = fmt.dateFromString("\(year)-\(month)-\(day) \(hour):\(minute):\(second)")
		let cal = NSCalendar.currentCalendar()
		let date = cal.components([.Hour, .Minute, .Weekday, .WeekOfMonth, .WeekOfYear], fromDate: dateVal!)
		let now = cal.components([.Hour, .Minute, .Weekday, .WeekOfMonth, .WeekOfYear], fromDate: NSDate())
		
		switch (_type)
		{
		case .None:
			return false
		case .TimeOfDay:
			return (date.hour == now.hour && date.minute == now.minute)
		case .DayOfWeek:
			return (date.weekday == now.weekday)
        case .DayOfMonth:
            return (date.day == now.day)
        case .WeekOfMonth:
			return (date.weekOfMonth == now.weekOfMonth)
		case .MonthOfYear:
			return (date.weekOfYear == now.weekOfYear)
		}
	}
	
}
