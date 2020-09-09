//
//  UserInfoTableViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
	
	@IBOutlet weak var userImageView: UIImageView! {
		didSet {
			userImageView.layer.cornerRadius = userImageView.frame.height / 2
		}
	}

	@IBOutlet weak var userNameLabel: UILabel!

	func configure(with model: UserInfoCellModel) {
		userImageView.image = UIImage(data: model.imageData ?? Data())
		userNameLabel.text = model.name
	}
}
