//
//  EntityMappable.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 07.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol EntityMappable {
	associatedtype DomainModelType

	func map(_ entity: DomainModelType)
}
