//
//  UserMO+CoreDataClass.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 27.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UserMO)
public class UserMO: NSManagedObject {

}

// MARK: - Mappable
extension UserMO: Mappable {
	var mapToModel: User {
		return User(name: name, email: email)
	}

	func map(_ entity: User) {
		self.name = name
		self.email = email
	}
}
