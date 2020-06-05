//
//  LocalSubTasksRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol SubTasksRepositoryType {
	func add(subtask: SubTaskEntity, to task: TaskEntity, completion: () -> Void)
	func getAll(where task: TaskEntity) -> [SubTaskEntity]
}
