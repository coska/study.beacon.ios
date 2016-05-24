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
	
	static let names = [None.rawValue, Text.rawValue, Call.rawValue, Wifi.rawValue]
	
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
	
	
	//TODO move these to ViewControllers and implement ActionProtocol
	
	/*
   func perform()
	{
		
		switch (_type)
		{
		case .None:
			break
		case .Call:
			callNumber(value)
			break
		case .Text:
			let arr = value.componentsSeparatedByString("|")
			sendText(arr[0], msg: arr[1])
			break
		case .Wifi:
			break
		}
	}
	
	private func callNumber(phoneNo:String)
	{
  		if let url:NSURL = NSURL(string:"telprompt://\(phoneNo.stringByReplacingOccurrencesOfString(" ", withString: ""))") {
			let app:UIApplication = UIApplication.sharedApplication()
			if (app.canOpenURL(url)) {
				app.openURL(url);
			}
		}
	}
	
	private func sendText(phoneNo:String, msg:String)
	{
		
		//		if let url:NSURL = NSURL(string:"sms://\(phoneNo)") {
		//			let app:UIApplication = UIApplication.sharedApplication()
		//			if (app.canOpenURL(url)) {
		//				app.openURL(url);
		//			}
		//		}
		
		let vc = SmsViewController()
		vc.setText(phoneNo, message: msg)
		vc.sendText(self)
		
	}
   */
}

