//
//  RegistrationModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class RegistrationModule {
	func build() -> UIViewController {
		let view = RegistrationViewController.instantiate(storyboard: .registration)
		let interactor = RegistrationInteractor()
		let presenter = RegistrationPresenter(view: view, interactor: interactor)
		view.presenter = presenter
		interactor.output = presenter
		return view
	}
}
