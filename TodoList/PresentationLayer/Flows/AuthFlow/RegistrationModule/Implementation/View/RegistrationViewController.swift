//
//  RegistrationViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

	var presenter: RegistrationPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - RegistrationViewProtocol
extension RegistrationViewController: RegistrationViewProtocol {

}
