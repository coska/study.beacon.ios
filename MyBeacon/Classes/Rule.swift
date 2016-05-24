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
	
	func isApplicable(cl:CLLocation) -> Bool {
		return (time!.isApplicable() && location!.isApplicable(cl))
	}
}
