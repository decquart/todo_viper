//
//  SubTaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 22.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct SubTaskViewModel {
	private var id: String = UUID().uuidString
	private var isCompleted: Bool = false
	var description: String = ""
	var date: Date = Date()

	var checkmarkIcon: UIImage {
		isCompleted
			? UIImage(systemName: "checkmark.circle.fill")!
			: UIImage(systemName: "circle")!
	}

	init() {}

	init(model: SubTask) {
		id = model.uuid
		isCompleted = model.completed
		description = model.description
		date = model.date
	}
}

// MARK: - MappingOutput
extension SubTaskViewModel: MappingOutput {
	var mapToModel: SubTask {
		SubTask(uuid: id, description: description, completed: isCompleted, date: date)
	}
}
