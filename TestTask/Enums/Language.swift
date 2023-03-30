//
//  Language.swift
//  WConnect
//
//  Created by Dmytro Tarasovskyi on 10.06.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

enum Language: String, CaseIterable, Codable {
    case english = "English"
    
    var localeIdentifier: String {
        switch self {
        case .english:
            return "en"
            // return "en-US"

        }
    }
    
    init(languageCode: String?) {
        switch languageCode {
        case "uk", "us":
            self = .english
        default:
            self = .english
        }
    }
}
