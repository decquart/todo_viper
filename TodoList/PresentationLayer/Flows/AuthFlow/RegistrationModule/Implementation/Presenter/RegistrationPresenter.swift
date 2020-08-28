//
//  RegistrationPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class RegistrationPresenter {
	weak var view: RegistrationViewProtocol!
	private var interactor: RegistrationInteractorInput

	init(view: RegistrationViewProtocol, interactor: RegistrationInteractorInput) {
		self.view = view
		self.interactor = interactor
	}
}


//MARK: - RegistrationViewProtocol
extension RegistrationPresenter: RegistrationPresenterProtocol {
	
}

//MARK: - RegistrationInteractorOutput
extension RegistrationPresenter: RegistrationInteractorOutput {
	
}
