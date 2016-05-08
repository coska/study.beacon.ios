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
	case TimeOfDay = "TimeOfDay"
	case DayOfWeek = "DayOfWeek"
	case WeekOfMonth = "WeekOfMonth"
	case MonthOfYear = "MonthOfYear"
	
	var description: String {
		return self.rawValue
	}
	
	static let names = [
		None.rawValue,
		TimeOfDay.rawValue,
		DayOfWeek.rawValue,
		WeekOfMonth.rawValue,
		MonthOfYear.rawValue
	]
	
	static func getType(type:String) -> TimeType {
		switch (type)
		{
		case None.rawValue: return None
		case TimeOfDay.rawValue: return TimeOfDay
		case DayOfWeek.rawValue: return DayOfWeek
		case WeekOfMonth.rawValue: return WeekOfMonth
		case MonthOfYear.rawValue: return MonthOfYear
			
		default:
			return None
		}
	}
}

class Time : Object, Applicable {
	
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
	
	func Apply() -> Bool {
		
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
		case .WeekOfMonth:
			return (date.weekOfMonth == now.weekOfMonth)
		case .MonthOfYear:
			return (date.weekOfYear == now.weekOfYear)
			//default:
			//return false
		}
	}
	
}
