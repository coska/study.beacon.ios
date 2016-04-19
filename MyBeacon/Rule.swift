//
//  Rule.swift
//  BeaconData
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import RealmSwift

class Rule: Object, Applicable {
	
	dynamic var name = ""
	dynamic var done = false
	
	dynamic var time : Time?
	dynamic var location : Location?
	
	func Apply() -> Bool {
		
		//TODO validate time and/or location condition
		
		return false
	}
	
}
