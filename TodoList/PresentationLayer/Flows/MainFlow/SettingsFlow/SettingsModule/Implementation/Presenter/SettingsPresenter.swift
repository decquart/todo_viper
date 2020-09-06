//
//  SettingsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 04.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class SettingsPresenter: SettingsPresenterProtocol {
	var onAccount: (() -> Void)?
	var onTheme: (() -> Void)?
	var onLogOut: (() -> Void)?

	private let session: UserSessionProtocol
	private let repository: AnyRepository<User>
	private var user: User?

	init(repository: AnyRepository<User>, session: UserSessionProtocol) {
		self.session = session
		self.repository = repository
	}

	func viewDidLoad() {
		let predicate = NSPredicate(format: "name = %@", session.currentUser!)
		repository.fetch(where: predicate) { [weak self] result in
			if case let .success(users) = result, let fetchedUser = users.first {
				self?.user = fetchedUser
			}
		}
	}

	private var sections: [SettingsSection] {
		return [
			UserInfoSettingsSection(items: [
				UserInfoCellModel(name: user?.name ?? "", imageData: user?.image)
			]),

			EmailSettingsSection(email: user?.email)

		]
	}

	var numberOfSections: Int {
		return sections.count
	}

	func numberOfRows(in section: Int) -> Int {
		return sections[section].rowCount
	}

	func sectionInfo(at index: Int) -> SettingsSection {
		return sections[index]
	}

	func titleForHeader(at index: Int) -> String {
		return sections[index].sectionTitle
	}

	func didSelectTableViewCell(at index: Int) {
		let type = sections[index].type

		switch type {
		//case .account:
			//onAccount?()
		case .theme:
			onTheme?()
//		case .logOut:
//			session.logOut()
//			onLogOut?()
		default:
			break
		}
	}
	
}
