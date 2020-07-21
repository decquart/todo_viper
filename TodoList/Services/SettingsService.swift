//
//  SettingsService.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import UIKit

protocol AccountSettingsServiceProtocol {
	var userImage: Data? { get set }
}

protocol ThemeSettingsServiceProtocol {
	var userInterfaceStyle: UIUserInterfaceStyle? { get set }
	func refreshDarkMode()
}

final class SettingsService: AccountSettingsServiceProtocol {
	var userImage: Data? {
		get { return UserDefaults.standard[#function] }
		set { UserDefaults.standard[#function] = newValue }
	}
}

// MARK: - ThemeSettingsServiceProtocol
extension SettingsService: ThemeSettingsServiceProtocol {
	var userInterfaceStyle: UIUserInterfaceStyle? {
		get { return UserDefaults.standard[#function] }
		set { UserDefaults.standard[#function] = newValue }
	}

	func refreshDarkMode() {
		let theme = userInterfaceStyle ?? .light

		UIApplication.shared.windows.forEach {
			$0.overrideUserInterfaceStyle = theme
		}
	}
}
