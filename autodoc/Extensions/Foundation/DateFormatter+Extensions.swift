//
//  DateFormatter+Extensions.swift
//  autodoc
//
//  Created by Kirill Faifer on 20.11.2025.
//

import Foundation

extension DateFormatter {

    private static let formatter = DateFormatter()

    static func formatDate(_ date: Date, dateFormat: DateFormat, timeZone: TimeZone?, locale: Locale?) -> String {
        formatter.dateFormat = dateFormat.rawValue
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.string(from: date)
    }

    static func formatString(_ string: String, dateFormat: DateFormat, timeZone: TimeZone?, locale: Locale?) -> Date? {
        guard !string.isEmpty else { return nil }
        formatter.dateFormat = dateFormat.rawValue
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.date(from: string)
    }

}

// MARK: - String to Date

extension String {

    func formatted(dateFormat: DateFormat, timeZone: TimeZone? = TimeZone(identifier: "UTC"), locale: Locale? = nil) -> Date? {
        DateFormatter.formatString(self, dateFormat: dateFormat, timeZone: timeZone, locale: locale)
    }

}

// MARK: - Date to String

extension Date {

    func formatted(dateFormat: DateFormat, timeZone: TimeZone? = TimeZone(identifier: "UTC"), locale: Locale? = nil) -> String {
        DateFormatter.formatDate(self, dateFormat: dateFormat, timeZone: timeZone, locale: locale)
    }

}
