//
//  Rule.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift
import CoreLocation

class Rule: Object {
    
    dynamic var name = ""
    dynamic var done = false
    dynamic var time : Time?
    dynamic var location : Location?
    
    func fromData(data:RuleData)
    {
        name = data.name
        done = data.done
        if (time == nil)
        {
            time = Time()
        }
        time!.fromData(data.time)
        
        if (location == nil)
        {
            location = Location()
        }
        location!.fromData(data.location)
    }
    
    func isApplicable(cl:CLLocation) -> Bool {
        return (time!.isApplicable(NSDate()) && location!.isApplicable(cl))
    }
    
    func isApplicable(type:Locations) -> Bool {
        return (time!.isApplicable(NSDate()) && location!.isApplicable(type))
    }
}

class RuleData
{
    var name = ""
    var done = false
    var time = TimeData()
    var location = LocationData()
    
    func fromObject(o:Rule)
    {
        name = o.name
        done = o.done
        time.fromObject(o.time!)
        location.fromObject(o.location!)
    }
}

