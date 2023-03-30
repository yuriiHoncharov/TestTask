//
//  LanguageManager.swift
//  WConnect
//
//  Created by Dmytro Tarasovskyi on 10.06.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

class LanguageManager {
    private let kLanguage = "kLanguage"
    
    static let shared = LanguageManager()
    
    // User UserDefaults instead of SecureStorage in order to avoid race conditions
    func setLanguage(_ language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: kLanguage)
    }
    
    func getCurrentLanguage() -> Language? {
        if let rawValue = UserDefaults.standard.string(forKey: "kLanguage") {
            return Language(rawValue: rawValue) ?? nil
        }
        return nil
    }
    
    private init() {}
}

protocol TranslationProtocol {
    var ru: String? { get set }
    var en: String? { get set }
    var tr: String? { get set }
    
    func localized() -> String?
}

extension TranslationProtocol {
    func localized() -> String? {
        switch LanguageManager.shared.getCurrentLanguage() {
        case .english:
            return en
        case .none:
            return en
        }
    }
}
