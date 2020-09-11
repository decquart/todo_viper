//
//  SettingsService.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import UIKit

protocol ThemeSettingsServiceProtocol {
	var userInterfaceStyle: UIUserInterfaceStyle? { get set }
	var isDarkModeEnabled: Bool { get }
	func refreshDarkMode()
	func setDarkModeVisble(_ isVisible: Bool)
	var applicationColor: Color { get set }
}

final class SettingsService {
	static let shared = SettingsService()
	private init() {}

	var isFirstLaunch: Bool {
		get { return UserDefaults.standard[#function] ?? true }
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

	func setDarkModeVisble(_ isVisible: Bool) {
		userInterfaceStyle = isVisible ? .dark : .light
		refreshDarkMode()
	}

	var isDarkModeEnabled: Bool {
		guard let userInterfaceStyle = userInterfaceStyle else {
			return false
		}

		return userInterfaceStyle == .dark
	}

	var applicationColor: Color {
		get { return UserDefaults.standard[#function] ?? Color.customBlue }
		set { UserDefaults.standard[#function] = newValue }
	}
}
