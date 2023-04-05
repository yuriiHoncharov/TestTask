//
//  DateFormatterUtility.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import Foundation

struct DateFormatterUtility {
    private let isoDateFormatter = ISO8601DateFormatter()
    private var now: Date { Date() }
    
    func date(from serverString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: serverString) ?? Date()
    }
    
    func dayMonthYear(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func refactoringDate(from string: String) -> String {
        isoDateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]

        let date = isoDateFormatter.date(from: string)

        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd.MM.yyyy"
        let output = dateFormatterOutput.string(from: date ?? now)
        return output
    }
}
