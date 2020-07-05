//
//  Mappable.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 07.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol Mappable {
	associatedtype ModelType
	func map(_ entity: ModelType)
}

protocol DomainModelMapping {
	associatedtype DomainModelType
	var domainModel: DomainModelType { get }
}

protocol ViewModelMapping {
	associatedtype ViewModelType
	var viewModel: ViewModelType { get }
}
