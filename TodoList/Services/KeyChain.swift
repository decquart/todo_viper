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
	func save(data: Data, for key: KeychainType) -> Bool
	func load(for key: KeychainType) -> Data?
}

class Keychain: KeychainProtocol {
	func save(data: Data, for key: KeychainType) -> Bool {
		let query = [
			kSecClass as String			: kSecClassGenericPassword as String,
			kSecAttrAccount as String	: key.rawValue,
			kSecValueData as String  	: data ] as [String : Any]

		SecItemDelete(query as CFDictionary)

		let result = SecItemAdd(query as CFDictionary, nil)

		return result == noErr
	}

	func load(for key: KeychainType) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
			kSecAttrAccount as String : key.rawValue,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
}
