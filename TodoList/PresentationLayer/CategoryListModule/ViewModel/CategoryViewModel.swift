//
//  TaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 20.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct CategoryViewModel {
	private var id: String = UUID().uuidString
	var name: String = ""
	var imagePath: String = ""
	var color: UIColor = .clear

	var image: UIImage? {
		return UIImage(named: imagePath)?.withRenderingMode(.alwaysTemplate)
	}

	init() {}

	init(model: Category) {
		id = model.id
		imagePath = model.imagePath
		color = model.imageColor.toColor
		name = model.name
	}
}

// MARK: - MappingOutput
extension CategoryViewModel: MappingOutput {
	var mapToModel: Category {
		return Category(id: id,
					name: name,
					imagePath: imagePath,
					color: color)
	}
}
