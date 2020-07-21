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
	var themeService: ThemeSettingsServiceProtocol?
	private(set) var isDarkMode: Box<Bool> = Box(false)

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
