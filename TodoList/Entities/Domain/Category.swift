//
//  Category.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

struct Category {
	let id: String
	let name: String
	let imagePath: String
	let imageColor: NSObject
	let tasksCount: Int

	init(id: String = UUID().uuidString, name: String, imagePath: String, color: NSObject, subtasksCount: Int = 0) {
		self.id = id
		self.name = name
		self.imagePath = imagePath
		self.imageColor = color
		self.tasksCount = subtasksCount
	}
}