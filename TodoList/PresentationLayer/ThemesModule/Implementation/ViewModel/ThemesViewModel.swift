//
//  ThemesViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import UIKit

class ThemesViewModel: ThemesViewModelProtocol {
	private var themeService: ThemeSettingsServiceProtocol?
	private(set) var isDarkMode: Box<Bool> = Box(false)

	init(themeService: ThemeSettingsServiceProtocol) {
		self.themeService = themeService
	}

	func didLoad() {
		isDarkMode.value = themeService?.userInterfaceStyle == .dark
	}

	func setDarkMode(_ isSwitchOn: Bool) {
		let mode: UIUserInterfaceStyle = isSwitchOn ? .dark : .light
		themeService?.userInterfaceStyle = mode
		themeService?.refreshDarkMode()

		isDarkMode.value = isSwitchOn
	}
}
