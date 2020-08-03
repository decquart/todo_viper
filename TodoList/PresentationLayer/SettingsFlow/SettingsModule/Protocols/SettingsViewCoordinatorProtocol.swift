//
//  SettingsViewCoordinatorProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SettingsViewCoordinatorProtocol {
	var onAccount: (() -> Void)? { get set }
	var onTheme: (() -> Void)? { get set }
}
