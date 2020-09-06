//
//  AccountInfoViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class AccountInfoViewModel: AccountInfoViewModelProtocol {

	let repository: AnyRepository<User>
	let currentUserName: String

	private var currentUser: User?

	private(set) var username: Box<String> = Box("")
	private(set) var email: Box<String> = Box("")
	private(set) var userImage: Box<Data?> = Box(nil)

	init(repository: AnyRepository<User>, currentUserName: String) {
		self.repository = repository
		self.currentUserName = currentUserName
	}

	func viewDidLoad() {
		let predicate = NSPredicate(format: "name = %@", currentUserName)
		repository.fetch(where: predicate) { [weak self] result in
			switch result {
			case .success(let users):
				guard let self = self, let user = users.first else { return }

				self.username.value = user.name
				self.email.value = user.email
				self.userImage.value = user.image
				self.currentUser = user
			case .failure(_):
				break
			}
		}
	}

	func saveUserImage(_ imageData: Data?) {
		guard var user = currentUser else {
			return
		}
		user.image = imageData

		repository.update(user) { [weak self] success in
			if success {
				self?.userImage.value = imageData
			}
		}
	}
}
