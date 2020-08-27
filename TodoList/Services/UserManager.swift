//
//  UserManager.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 27.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

final class UserManager {
	static let shared = UserManager()
	private init() {}

	private lazy var keychain: Keychain = {
		return Keychain()
	}()


}
