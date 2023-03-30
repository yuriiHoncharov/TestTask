//
//  LanguageType.swift
//  TestTask
//
//  Created by Yurii Honcharov on 28.03.2023.
//

import Foundation

enum LanguageType: String, CaseIterable, Codable {
    case english = "en"
    
    var localeIdentifier: String {
        switch self {
        case .english:
            return "en-US"
        }
    }
}
