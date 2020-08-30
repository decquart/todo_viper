//
//  CategoryDetailsUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 24.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol CategoryDetailsInteractorInput {
	func create(_ category: Category)
	func update(_ category: Category)
}

protocol CategoryDetailsInteractorOutput: class {
	func didCategoryPersist()
}
