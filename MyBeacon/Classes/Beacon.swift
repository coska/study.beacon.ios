//
//  Beacon.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift

class Beacon: Object {
	
	dynamic var id : String = ""
	dynamic var major : Int = 0
	dynamic var minor : Int = 0
	dynamic var name : String = ""
	let battery = RealmOptional<Int>()
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
    func fromData(data:BeaconData)
    {
        id = data.id
        major = data.major
        minor = data.minor
        name = data.name
        battery.value = data.battery
    }
}

class BeaconData {
    var id : String = ""
    var major : Int = 0
    var minor : Int = 0
    var name : String = ""
    var battery : Int = 0
    
    private static var _editBeacon:BeaconData?
    static var editBeacon:BeaconData {
        get {
            if (_editBeacon == nil) {
                _editBeacon = BeaconData()
            }
            return _editBeacon!
        }
        set {
            _editBeacon = newValue
        }
    }
    
    func fromObject(o:Beacon)
    {
        id = o.id
        major = o.major
        minor = o.minor
        name = o.name
        if (o.battery.value != nil)
        {
        	battery = o.battery.value!
        }
    }
}