//
//  Location.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift

class Location : Object, Applicable {
	
	dynamic var name = ""
	
	dynamic var lat = 0.0
	dynamic var long = 0.0
	dynamic var alt = 0.0
	
	dynamic var radius = 1 // meter
	dynamic var duration = 60 // seconds
	
	func Apply() -> Bool {
		
		//TODO check location and verify the location condition applies
		return false
	}
	
}
