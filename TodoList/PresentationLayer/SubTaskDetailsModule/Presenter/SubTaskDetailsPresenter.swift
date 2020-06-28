//
//  SubTaskDetailsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SubTaskDetailsOutput: class {

}

protocol SubTaskDetailsInput: class {

}

class SubTaskDetailsPresenter: SubTaskDetailsOutput {
	weak var view: SubTaskDetailsInput!

	init(view: SubTaskDetailsInput) {
		self.view = view
	}
}
