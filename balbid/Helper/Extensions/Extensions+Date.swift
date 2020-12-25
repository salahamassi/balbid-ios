//
//  Extensions+Date.swift
//  MSA
//
//  Created by Salah Amassi on 10/25/20.
//  Copyright © 2020 msa. All rights reserved.
//

import Foundation

extension Date {

    func toString(with format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current // Set timezone that you want
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = format // Specify your format that you want
        return dateFormatter.string(from: self)
    }

    func rangeDates(to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = self
        let calendar = Calendar(identifier: .gregorian)
        while date <= toDate {
            dates.append(date)
            guard let newDate = calendar.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }

    func isInSameWeek(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }

    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }

    var year: Int? {
        let components = Calendar.current.dateComponents([.year], from: self)
        return components.year
    }

    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date? {
        return Calendar.current.dateInterval(of: .month, for: self)?.start
    }

    var startOfWeek: Date? {
        return Calendar(identifier: .gregorian).date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }

    var dayAfter: Date? {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: 1, to: self)
    }

    var dayBefore: Date? {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: -1, to: self)
    }

    var weekBefore: Date? {
        return Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self)
    }

    var monthAfter: Date? {
        return Calendar(identifier: .gregorian).date(byAdding: .month, value: 1, to: self)
    }

    var monthBefore: Date? {
        return Calendar(identifier: .gregorian).date(byAdding: .month, value: -1, to: self)
    }

    var dayOfMonth: String? {
        let components = Calendar(identifier: .gregorian).dateComponents([.day], from: self)
        return String(format: "%02d", components.day ?? 0)
    }

    var dayNumberOfWeek: Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }

    var month: Int {
        let components = Calendar(identifier: .gregorian).dateComponents([.month], from: self)
        return components.month ?? 0
    }

    var nameOfDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).capitalized
    }

    var nameOfMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: self)
    }

    var fullNameOfMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }

    var isDateInToday: Bool {
        return Calendar(identifier: .gregorian).isDateInToday(self)
    }

    var isDateYesterday: Bool {
        return Calendar(identifier: .gregorian).isDateInYesterday(self)
    }

    var isDateInTomorrow: Bool {
        return Calendar(identifier: .gregorian).isDateInTomorrow(self)
    }

    func isInSameDay(of date: Date) -> Bool {
        return Calendar(identifier: .gregorian).isDate(self, inSameDayAs: date)
    }

    func isInSameMonth(date: Date) -> Bool {
        return Calendar(identifier: .gregorian).isDate(self, equalTo: date, toGranularity: .month)
    }

    var isInThisWeek: Bool {
        return isInSameWeek(date: Date())
    }

    var isInLastWeek: Bool {
        return isInSameWeek(date: Date().weekBefore ?? Date())
    }

    func isInSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }

    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar(identifier: .gregorian).dateComponents([.month], from: date, to: self).month ?? 0
    }

    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar(identifier: .gregorian).dateComponents([.day], from: date, to: self).day ?? 0
    }

    func seconds(from date: Date) -> Int? {
        Calendar.current.dateComponents([.second], from: date, to: self).second
    }
}
