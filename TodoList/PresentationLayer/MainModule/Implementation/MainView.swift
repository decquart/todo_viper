//
//  MainView.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class MainView: UITabBarController, MainViewProtocol {

	var presenter: MainPresenterProtocol!

	override func viewDidAppear(_ animated: Bool) {
		presenter.viewDidAppear()
	}
}
