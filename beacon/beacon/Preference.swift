//
//  Preference.swift
//  beacon
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import Foundation
import RealmSwift

class Preference: Object {
	
	dynamic var periodBeacon = 1000
	dynamic var useGps = false
	dynamic var periodCampedOn = 10000

}

