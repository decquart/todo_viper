//
//  LocalSubTasksRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SubTasksRepositoryType {
	func add(subtask: SubTask, to task: Task, completion: @escaping () -> Void)
	func getAll(where task: Task, completion: @escaping ([SubTask]) -> Void)
	func update(subtask: SubTask, completion: @escaping () -> Void)
	func markAsCompleted(where task: Task, completion: () -> Void)
}
