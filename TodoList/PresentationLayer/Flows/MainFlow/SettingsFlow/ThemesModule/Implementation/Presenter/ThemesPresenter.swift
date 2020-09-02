//
//  ThemesPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

final class ThemesPresenter {

	let interactor: ThemesInteractorInput!
	let view: ThemesViewProtocol

	init(view: ThemesViewProtocol, interactor: ThemesInteractorInput) {
		self.view = view
		self.interactor = interactor
	}
}

//MARK: - ThemesPresenterProtocol
extension ThemesPresenter: ThemesPresenterProtocol {
	func setDarkMode(_ isSwitchOn: Bool) {
		interactor.setDarkMode(isSwitchOn)
	}

	func didLoad() {
		let isDarkModeEnabled = interactor.isDarkModeEnabled
		view.updateDarkModeSwitch(isDarkModeEnabled)
	}
}

//MARK: - ThemesInteractorOutput
extension ThemesPresenter: ThemesInteractorOutput {
	func didDarkModeChange(_ isOn: Bool) {
		view.updateDarkModeSwitch(isOn)
	}
}
