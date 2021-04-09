//
//  DateExtension.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/8/21.
//

import Foundation

extension Date {
    func string(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        
        return dateFormatter.string(from: self)
    }
    
    
    /// Create custom date
    /// - Parameters:
    ///   - year: The year as an `Int`
    ///   - month: The month as an `Int`
    ///   - day: The day as an `Int`
    /// - Returns: An optional `Date`
    static func customDate(year: Int, month: Int, day: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        return Calendar.current.date(from: components)
    }
}
