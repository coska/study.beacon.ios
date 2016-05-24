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
	
}
