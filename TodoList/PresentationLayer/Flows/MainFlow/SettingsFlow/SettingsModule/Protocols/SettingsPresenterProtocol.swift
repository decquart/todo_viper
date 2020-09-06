//
//  SettingsPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 04.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SettingsPresenterProtocol {

	var interactor: SettingsInteractorInput! { get }
	var numberOfSections: Int { get }

	func viewDidLoad()
	func numberOfRows(in section: Int) -> Int
	func sectionInfo(at index: Int) -> SettingsSection
	func titleForHeader(at index: Int) -> String
	func didSelectTableViewCell(at index: Int)
}
