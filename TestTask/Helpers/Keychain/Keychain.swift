//
//  Keychain.swift
//  WConnect
//
//  Created by Maksym Yevtukhivskiy on 13.04.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

protocol Keychainable {
    func save<T: Codable>(with key: String, value: T)
    func load<T: Codable>(with key: String) -> T?
    func remove(with key: String)
    func removeAllData()
}

class Keychain: Keychainable {
    func save<T: Codable>(with key: String, value: T) {
        DispatchQueue.global().sync(flags: .barrier) {
            self.save(value, forKey: key)
        }
    }
    
    func load<T: Codable>(with key: String) -> T? {
        let query = keychainQuery(with: key)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnAttributes as String)
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        
        guard
            let resultsDict = result as? NSDictionary,
            let resultsData = resultsDict.value(forKey: kSecValueData as String) as? Data,
            status == noErr
            else {
                print("Load status: ", status)
                return nil
        }

        return try? JSONDecoder().decode(T.self, from: resultsData)
    }
    
    func remove(with key: String) {
        DispatchQueue.global().sync(flags: .barrier) {
            let query = keychainQuery(with: key)
            SecItemDelete(query)
        }
    }
    
    func removeAllData() {
        let secItemClasses = [kSecClassGenericPassword,
                              kSecClassInternetPassword,
                              kSecClassCertificate,
                              kSecClassKey,
                              kSecClassIdentity]
        
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
    
    private func save<T: Codable>(_ value: T?, forKey key: String) {
        let query = keychainQuery(with: key)
        let objectData = try? JSONEncoder().encode(value)

        if SecItemCopyMatching(query, nil) == noErr {
            if let dictData = objectData {
                let status = SecItemUpdate(query, NSDictionary(dictionary: [kSecValueData: dictData]))
                print("Update status: ", status)
            } else {
                let status = SecItemDelete(query)
                print("Delete status: ", status)
            }
        } else {
            if let dictData = objectData {
                query.setValue(dictData, forKey: kSecValueData as String)
                let status = SecItemAdd(query, nil)
                print("Update status: ", status)
            }
        }
    }
    
    private func keychainQuery(with key: String) -> NSMutableDictionary {
        let result = NSMutableDictionary()
        result.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        result.setValue(key, forKey: kSecAttrService as String)
        result.setValue(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, forKey: kSecAttrAccessible as String)
        return result
    }
}
