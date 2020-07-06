//
//  TaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 20.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct TaskViewModel {
	private var id: String = UUID().uuidString
	var name: String = ""
	var imagePath: String = ""
	var color: UIColor = .clear

	var image: UIImage? {
		return UIImage(named: imagePath)?.withRenderingMode(.alwaysTemplate)
	}

	init() {}

	init(model: Task) {
		id = model.id
		imagePath = model.imagePath
		color = model.imageColor.toColor
		name = model.name
	}
}

// MARK: - MappingOutput
extension TaskViewModel: MappingOutput {
	var mapToModel: Task {
		return Task(id: id,
					name: name,
					imagePath: imagePath,
					color: color)
	}
}
