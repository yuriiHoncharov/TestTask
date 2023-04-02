//
//  String+Extension.swift
//  WConnect
//
//  Created by Maksym Yevtukhivskiy on 11.02.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import UIKit

protocol OptionalString {}
extension String: OptionalString {}

extension Optional where Wrapped: OptionalString {
    var setEmptyIfNil: String {
        return (self as? String) ?? ""
    }
    
    var setNilIfEmpty: String? {
        guard let val = self as? String else { return nil }
        return val.isEmpty ? nil : val
    }
}
