//
//  TasksRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol TasksRepositoryType {
	func getAll(completion: @escaping ([Task]) -> Void)
	func getSubTasksCount(for task: Task) -> Int
	func create(task: Task, completion: @escaping () -> Void)
	func update(task: Task, completion: @escaping () -> Void)
	func delete(task: Task)
}
