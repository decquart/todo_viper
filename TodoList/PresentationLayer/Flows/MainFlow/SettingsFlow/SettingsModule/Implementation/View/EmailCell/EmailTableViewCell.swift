//
//  EmailTableViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {
	@IBOutlet weak var emailLabel: UILabel!

	func configure(with sectionData: SettingsSection, and index: Int) {
		guard let emailSection = sectionData as? EmailSettingsSection else {
			return
		}

		emailLabel.text = emailSection.email
	}
}
