//
//  SettingsRouter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsRouter: SettingsRouterProtocol {
	weak var viewModel: SettingsVMProtocol!
	weak var view: SettingsViewProtocol!

	func showAccountInfoViewController() {
		//TODO
		//let navCtrl = UINavigationController(rootViewController: vc)
		//navCtrl.modalPresentationStyle = .formSheet
		let vc = AccountInfoModule().build()
		view.navigationController?.pushViewController(vc, animated: true)
	}

	func showThemesViewController() {
		let vc = ThemesModule().build()
		view.navigationController?.pushViewController(vc, animated: true)
	}
}
