//
//  ViewModelMapping.swift
//  TodoList
//
//  Created by volodymyr on 20.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ViewModelMapping {
	associatedtype ViewModelType

	var viewModel: ViewModelType { get }
}
