//
//  TaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 20.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct TaskViewModel {
	let image: UIImage?
	let name: String
	let subTasksCount: Int

	init(taskEntity: TaskEntity, subTasksCount: Int) {
		self.image = UIImage(data: taskEntity.imageData)?.withTintColor(taskEntity.imageColor as! UIColor)
		self.name = taskEntity.name
		self.subTasksCount = subTasksCount
	}
}
