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
    case Far = "Far"
    case Near = "Near"
    case Immediate = "Immediate"
    case NoSignal = "No Signal"
    
    var description: String {
        return self.rawValue
    }
    
    static let names = [
        None.rawValue,
        Far.rawValue,
        Near.rawValue,
        Immediate.rawValue,
        NoSignal.rawValue
    ]
    
    static func getType(type:String) -> LocationType {
        switch (type)
        {
        case None.rawValue: return None
        case Far.rawValue: return Far
        case Near.rawValue: return Near
        case Immediate.rawValue: return Immediate
        case NoSignal.rawValue: return NoSignal
            
        default:
            return None
        }
    }
}

class LocationCondition : Object {
    
    private var _type = LocationType.None
    
    dynamic var type : String {
        get {
            return _type.rawValue
        }
        set {
            _type = LocationType.getType(newValue)
        }
    }
    
    func isApplicable(compare:LocationType) -> Bool {
        return compare == self._type
    }
    
    // reserved
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
