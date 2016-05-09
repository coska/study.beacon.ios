//
//  Location.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift
import CoreLocation


enum LocationType : String
{
    case None = "None"
    case Close = "Close to Beacon"
    case Arrived = "Arrived at Beacon"
    case Stay = "Stay close to Beacon"
    case Leaving = "Leaving Beacon"
    case Away = "Far away from Beacon"
    
    var description: String {
        return self.rawValue
    }
    
    static let names = [
        None.rawValue,
        Close.rawValue,
        Arrived.rawValue,
        Stay.rawValue,
        Leaving.rawValue,
        Away.rawValue
    ]
    
    static func getType(type:String) -> LocationType {
        switch (type)
        {
        case None.rawValue: return None
        case Close.rawValue: return Close
        case Arrived.rawValue: return Arrived
        case Stay.rawValue: return Stay
        case Leaving.rawValue: return Leaving
        case Away.rawValue: return Away
            
        default:
            return None
        }
    }
}

class Location : Object {
	
	dynamic var name = ""
	dynamic var lat : Double = 0.0
	dynamic var long : Double = 0.0
	dynamic var alt : Double = 0.0
	dynamic var radius : Double = 1.0 // meter
	dynamic var duration = 60 // seconds
	
	func isApplicable(compare:CLLocation) -> Bool {
		let me = CLLocation(latitude: lat, longitude: long)
		let disctance = compare.distanceFromLocation(me)
		return (disctance < radius && abs(alt-compare.altitude) < radius)
	}
	
}
