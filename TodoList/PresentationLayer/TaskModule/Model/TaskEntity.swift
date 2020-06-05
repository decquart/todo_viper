//
//  Task.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

struct TaskEntity {
	let id: String
	let name: String
	let imagePath: String

	init(id: String, name: String, imagePath: String) {
		self.id = id
		self.name = name
		self.imagePath = imagePath
	}
}
