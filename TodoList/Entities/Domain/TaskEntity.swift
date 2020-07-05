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
	let imageColor: NSObject

	init(id: String = UUID().uuidString, name: String, imagePath: String, color: NSObject) {
		self.id = id
		self.name = name
		self.imagePath = imagePath
		self.imageColor = color
	}
}

// MARK: ViewModelMapping
extension TaskEntity: ViewModelMapping {
	var viewModel: TaskViewModel {
		TaskViewModel(id: id, imagePath: imagePath, color: imageColor, name: name)
	}
}
