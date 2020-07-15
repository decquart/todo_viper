//
//  SettingsRouterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SettingsRouterProtocol: class {
	var viewModel: SettingsVMProtocol! { get }
	var view: SettingsViewProtocol! { get }

	func showAccountInfoViewController()
	func showThemesViewController()
}
