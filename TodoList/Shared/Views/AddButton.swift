//
//  AddButton.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class AddButton: UIButton {
	override func layoutSubviews() {
		super.layoutSubviews()

		self.layer.cornerRadius = frame.height / 2
		self.layer.backgroundColor = UIColor(red: 255/255, green: 152/255, blue: 0/255, alpha: 1).cgColor
		self.tintColor = .white
		self.setImage(UIImage(systemName: "plus"), for: .normal)
	}
}
