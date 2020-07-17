//
//  SettingsVMProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SettingsVMProtocol: class {
	var router: SettingsRouterProtocol! { get }
	var numberOfRows: Int { get }
	func viewModelCell(at index: Int) -> SettingsCellViewModel
	func didSelectTableViewCell(at index: Int)
}
