//
//  LocalSubTasksRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SubTasksRepositoryType {
	func add(subtask: SubTaskEntity, to task: TaskEntity)
	func getAll(where task: TaskEntity, completion: @escaping ([SubTaskEntity]) -> Void)
	func update(subtask: SubTaskEntity)
	func markAsCompleted(where task: TaskEntity, completion: () -> Void)
}
