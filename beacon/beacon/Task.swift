//
//  Task.swift
//  beacon
//
//  Created by thomas on 2016-04-17.
//  Copyright © 2016 coska.com. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
	
	dynamic var name = ""
	dynamic var rules : [Rule] = []
	dynamic var actions : [Action] = []
	dynamic var beacons : [Beacon] = []
	
}