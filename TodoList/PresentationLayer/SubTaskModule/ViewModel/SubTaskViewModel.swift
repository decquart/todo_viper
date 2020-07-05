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
	let description: String
	let checkmarkIcon: UIImage

	init(subTaskEntity: SubTaskEntity) {
		self.id = subTaskEntity.uuid
		self.description = subTaskEntity.description
		self.checkmarkIcon = subTaskEntity.completed
			? UIImage(systemName: "checkmark.circle.fill")!
			: UIImage(systemName: "circle")!
	}

	init(description: String) {
		self.id = UUID().uuidString
		self.description = description
		self.checkmarkIcon = UIImage(systemName: "circle")!
	}
}
