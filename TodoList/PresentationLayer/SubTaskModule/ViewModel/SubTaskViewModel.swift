//
//  SubTaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 22.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct SubTaskViewModel {
	private let id: String
	private let isCompleted: Bool
	var description: String

	var checkmarkIcon: UIImage {
		isCompleted
			? UIImage(systemName: "checkmark.circle.fill")!
			: UIImage(systemName: "circle")!
	}

	init(uuid: String, description: String, isCompleted: Bool) {
		self.id = uuid
		self.isCompleted = isCompleted
		self.description = description
	}

	init(description: String) {
		self.id = UUID().uuidString
		self.isCompleted = false
		self.description = description
	}
}

// MARK: - DomainModelMapping
extension SubTaskViewModel: DomainModelMapping {
	var domainModel: SubTaskEntity {
		return SubTaskEntity(uuid: id, description: description, completed: isCompleted)
	}
}
