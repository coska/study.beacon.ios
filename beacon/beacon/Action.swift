//
//  Action.swift
//  beacon
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import Foundation
import RealmSwift

enum ActionType : String
{
	case None = "None"
   case Text = "Text"
   case Call = "Call"
   case Wifi = "Wifi"
	
	var description: String {
		return self.rawValue
	}
	
	static func getType(type:String) -> ActionType {
		switch (type)
		{
			case None.rawValue: return None
			case Text.rawValue: return Text
			case Call.rawValue: return Call
			case Wifi.rawValue: return Wifi
			default:
				return None
		}
	}
}

class Action: Object {
	
	private var _type = ActionType.None
	
	dynamic var name = ""
	dynamic var type : String {
		get {
			return _type.rawValue
		}
		set {
			_type = ActionType.getType(newValue)
		}
	}
	
}
