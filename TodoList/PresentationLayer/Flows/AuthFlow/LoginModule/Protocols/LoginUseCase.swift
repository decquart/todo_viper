//
//  LoginUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol LoginInteractorInput {
	func login(with userName: String?, and password: String?)
}

protocol LoginInteractorOutput {
	func loginSuccess()
	func loginFailure(error: LoginError)
}
