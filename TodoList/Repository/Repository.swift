//
//  Repository.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

protocol Repository {
	associatedtype Item

	func fetch(completion: @escaping (Result<[Item], Error>) -> Void)
	func add(_ item: Item, completion: @escaping (Bool) -> Void)
	func update(_ item: Item, completion: @escaping (Bool) -> Void)
	func delete(_ item: Item, completion: @escaping (Bool) -> Void)
}

class AnyRepository<Item>: Repository {
	func fetch(completion: @escaping (Result<[Item], Error>) -> Void) {
		fatalError("")
	}

	func add(_ item: Item, completion: @escaping (Bool) -> Void) {
		fatalError("")
	}

	func update(_ item: Item, completion: @escaping (Bool) -> Void) {
		fatalError("")
	}

	func delete(_ item: Item, completion: @escaping (Bool) -> Void) {
		fatalError("")
	}
}
