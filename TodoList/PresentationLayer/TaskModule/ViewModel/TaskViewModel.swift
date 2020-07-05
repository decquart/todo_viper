//
//  TaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 20.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct TaskViewModel {
	private let id: String
	var imagePath: String
	var color: UIColor
	var name: String

	var image: UIImage? {
		return UIImage(named: imagePath)?.withRenderingMode(.alwaysTemplate)
	}

	init(id: String = UUID().uuidString, imagePath: String, color: NSObject, name: String) {
		self.id = id
		self.imagePath = imagePath
		self.color = color as! UIColor
		self.name = name
	}
}

// MARK: - DomainModelMapping
extension TaskViewModel: DomainModelMapping {
	var domainModel: TaskEntity {
		return TaskEntity(id: id, name: name, imagePath: imagePath, color: color)
	}
}
