//
//  Rule.swift
//  beacon
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import Foundation
import RealmSwift

enum RuleType : String
{
	case None = "None"
	case Time = "Time"
	case Location = "Location"
	
	var description: String {
		return self.rawValue
	}
	
	static func getType(type:String) -> RuleType {
		switch (type)
		{
		case None.rawValue: return None
		case Time.rawValue: return Time
		case Location.rawValue: return Location
		default:
			return None
		}
	}
}

class Rule: Object {
	
	private var _type = RuleType.None
	
	dynamic var name = ""
	dynamic var type : String {
		get {
			return _type.rawValue
		}
		set {
			_type = RuleType.getType(newValue)
		}
	}
	
}