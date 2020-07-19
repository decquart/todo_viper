//
//  KeyChain.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 17.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum KeychainType: String {
	case username
	case email
	case password
}

protocol KeychainProtocol {
	func save(_ value: String, for key: KeychainType) -> Bool
	func load(for key: KeychainType) -> String?
}

final class Keychain: KeychainProtocol {
	func save(_ value: String, for key: KeychainType) -> Bool {
		let data = Data(value.utf8)

		let query = [
			String(kSecClass)		: String(kSecClassGenericPassword),
			String(kSecAttrAccount) : key.rawValue,
			String(kSecValueData)	: data ] as [String : Any]

		SecItemDelete(query as CFDictionary)

		let result = SecItemAdd(query as CFDictionary, nil)

		return result == noErr
	}

	func load(for key: KeychainType) -> String? {
        let query = [
            String(kSecClass)		  : kSecClassGenericPassword,
			String(kSecAttrAccount)   : key.rawValue,
            String(kSecReturnData)	  : kCFBooleanTrue!,
            String(kSecMatchLimit)	  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

		guard let data = dataTypeRef as? Data else {
			return nil
		}

		return String(decoding: data, as: UTF8.self)
    }
}
