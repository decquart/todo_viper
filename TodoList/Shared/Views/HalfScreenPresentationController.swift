//
//  HalfScreenPresentationController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 11.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class HalfScreenPresentationController: UIPresentationController {
	override var frameOfPresentedViewInContainerView: CGRect {
		guard let containerView = containerView else {
			return .zero
		}

		return CGRect(x: 0, y: containerView.bounds.height / 2, width: containerView.bounds.width, height: containerView.bounds.height / 2)
	}
}
