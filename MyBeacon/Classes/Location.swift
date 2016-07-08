//
//  Location.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift
import CoreLocation


struct Locations : OptionSetType
{
    let rawValue: Int
    
    static let None = Locations(rawValue: 0)
    static let NoSignal = Locations(rawValue: 1 << 0)
    static let Far = Locations(rawValue: 1 << 1)
    static let Near = Locations(rawValue: 1 << 2)
    static let Immediate = Locations(rawValue: 1 << 3)
    
    static func isApplicable(compare:Locations, all:Locations) -> Bool
    {
        return all.contains(compare)
    }
    
    static let names = [ "NoSignal", "Far", "Near", "Immediate" ]
    static let types:[Locations] = [ .NoSignal, .Far, .Near, .Immediate ]
}


class LocationCondition : Object {
    
    private var _type = Locations.None
    
    dynamic var type : Int {
        get {
            return _type.rawValue
        }
        set {
            _type = Locations(rawValue:newValue)
        }
    }
    
    func isApplicable(compare:Locations) -> Bool {
        return _type.contains(compare)
    }
    
    func add(type:Locations) {
        _type.insert(type)
    }
    
    func remove(type:Locations) {
        _type.remove(type)
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
