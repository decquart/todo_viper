//
//  SubTaskDetailsViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SubTaskDetailsViewController: UIViewController {
	static let identifire = "subTaskDetailsVC"
	var presenter: SubTaskDetailsOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SubTaskDetailsViewController: SubTaskDetailsInput {
	
}
