//
//  Date+LocalDate.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 08.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

extension Date {
	var localDate: Date {
		let timezoneOffset =  TimeZone.current.secondsFromGMT()
		let epochDate = self.timeIntervalSince1970
		let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
		return Date(timeIntervalSince1970: timezoneEpochOffset)
	}
}
