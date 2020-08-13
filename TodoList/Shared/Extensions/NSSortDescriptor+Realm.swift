//
//  NSSortDescriptor+Realm.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RealmSwift

extension NSSortDescriptor {
	var toSortDescriptor: SortDescriptor? {
		guard let keyPath = self.key else {
			return nil
		}

		return SortDescriptor(keyPath: keyPath, ascending: ascending)
	}
}
