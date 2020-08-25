//
//  LoginPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol LoginPresenterProtocol {
	func loginButtonPressed(with username: String?, and password: String?)
	func skipButtonPressed()
}
