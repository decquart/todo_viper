//
//  AuthCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class AuthCoordinator: BaseCoordinator {

	var onFinish: (() -> Void)?

	override func start() {
		showLoginScreen()
	}
}

private extension AuthCoordinator {
	func showLoginScreen() {
		let module = LoginModule().build(onFinish: onFinish)
		self.router.setRootModule(module, animated: false)
	}
}
