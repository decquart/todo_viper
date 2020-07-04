//
//  TaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 20.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct TaskViewModel {
	private var id = UUID().uuidString
	var imagePath = ""
	var color = UIColor()
	var name = ""
	var subTasksCount = 0

	var image: UIImage? {
		return UIImage(named: imagePath)?.withRenderingMode(.alwaysTemplate)
	}

	var domainModel: TaskEntity {
		return TaskEntity(id: id, name: name, imagePath: imagePath, color: color)
	}

	init() {}

	init(taskEntity: TaskEntity, subTasksCount: Int) {
		self.id = taskEntity.id
		self.imagePath = taskEntity.imagePath
		self.color = taskEntity.imageColor as! UIColor
		self.name = taskEntity.name
		self.subTasksCount = subTasksCount
	}
}
