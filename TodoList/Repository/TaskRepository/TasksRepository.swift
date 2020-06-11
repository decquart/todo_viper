//
//  TasksRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol TasksRepositoryType {
	func getAll() -> [TaskEntity]
	func getSubTasksCount(for task: TaskEntity) -> Int
	func create(task: TaskEntity, completion: @escaping () -> Void)
	func delete(task: TaskEntity)
}
