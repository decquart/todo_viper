//
//  ThemesPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

final class ThemesPresenter {

	let interactor: ThemesInteractorInput!
	weak var view: ThemesViewProtocol!
	var onDismiss: Completion?

	init(view: ThemesViewProtocol, interactor: ThemesInteractorInput) {
		self.view = view
		self.interactor = interactor
	}
}

//MARK: - ThemesPresenterProtocol
extension ThemesPresenter: ThemesPresenterProtocol {
	func applyTheme() {
		interactor.applySelectedColor()
	}
}

//MARK: - ThemesInteractorOutput
extension ThemesPresenter: ThemesInteractorOutput {
	func didSaveColor() {
		view.updateButtonState()
	}

	func didApplyColor() {
		onDismiss?()
	}
}

//MARK: - ColorPickerPresenterOutput
extension ThemesPresenter: ColorPickerPresenterOutput {
	func updateColor(_ color: Color) {
		interactor.saveSelectedColor(color: color)
	}
}
