//
//  Action.swift
//  BeaconData
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
	
	static let names = [None.rawValue, Text.rawValue, Call.rawValue]//, Wifi.rawValue]
	
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
    
    // additional utility function as view controller may need it
    static func getTypeIndex(type:String) -> Int {
        let index = names.indexOf(type)
        if (index == nil || index == 0)
        {
            return -1
        }
        else {
            return (index! - 1)
        }
    }
}


protocol ActionProtocol
{
	func perform(type:ActionType)
}


class Action: Object {
	
	private var _type = ActionType.None
	
	dynamic var name = ""
	dynamic var value = ""
	dynamic var type : String {
		get {
			return _type.rawValue
		}
		set {
			_type = ActionType.getType(newValue)
		}
	}
    
    func fromData(data:ActionData)
    {
        name = data.name
        value = data.value
        type = data.type
    }
}


class ActionData {
    
    private var _type = ActionType.None
    
    var name = ""
    var value = ""
    var type : String {
        get {
            return _type.rawValue
        }
        set {
            _type = ActionType.getType(newValue)
        }
    }
    
    func fromObject(o:Action)
    {
        name = o.name
        value = o.value
        type = o.type
    }
}
