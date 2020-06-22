//
//  SubTaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 22.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct SubTaskViewModel {
	let description: String
	let checkmarkIcon: UIImage

	init(subTaskEntity: SubTaskEntity) {
		self.description = subTaskEntity.description
		self.checkmarkIcon = subTaskEntity.completed
			? UIImage(systemName: "checkmark.circle.fill")!
			: UIImage(systemName: "circle")!
	}

	init(description: String) {
		self.description = description
		self.checkmarkIcon = UIImage(systemName: "circle")!
	}
}
