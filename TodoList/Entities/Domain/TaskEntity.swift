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
	let imageData: Data
	let imageColor: NSObject

	init(id: String = UUID().uuidString, name: String, image: Data, color: NSObject) {
		self.id = id
		self.name = name
		self.imageData = image
		self.imageColor = color
	}
}
