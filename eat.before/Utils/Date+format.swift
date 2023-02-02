//
//  Date+Format.swift
//  eat.before
//
//  Created by Дарья Тимофеева on 08.04.2022.
//

import Foundation

extension Date {
    func format() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }

    func getDate(stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: stringDate) 
    }
    
    func getDateWithoutTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let expirationDate = Calendar.current.date(from: components) ?? self
        return expirationDate
    }
}
