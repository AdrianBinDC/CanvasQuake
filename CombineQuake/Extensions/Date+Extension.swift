//
//  DateExtension.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/8/21.
//

import Foundation

public enum DateSpan: Int, CaseIterable {
    case oneDay = 1
    case oneWeek = 7
    case oneMonth = 30
    case threeMonths = 90
    case sixMonths = 180
    case oneYear = 365
}

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
        
        let date =  Calendar.current.date(from: components)
        
        guard let unwrappedDate = date else {
            return nil
        }
        
        return Calendar.current.startOfDay(for: unwrappedDate)
    }
    
    enum CQRelativeTime {
        case inFuture
        case inPast
    }
    
    
    /// Generate a Date for a specified interval
    /// - Parameters:
    ///   - relativeTime: A `CQRelativeTime` value (past or future)
    ///   - interval: A `DateSpan` (day, month, etc.)
    ///   - referenceDate: The starting `Date` for the reference
    /// - Returns: An optional `Date` value
    static func date(_ relativeTime: CQRelativeTime,
                     interval: DateSpan,
                     referenceDate: Date = Date()) -> Date? {
        var inPast: Bool
        
        switch relativeTime {
        case .inFuture:
            inPast = false
        case .inPast:
            inPast = true
        }
        
        let interval = inPast ? (interval.rawValue * -1) : interval.rawValue
        
        let date = Calendar.current.date(byAdding: .day,
                                         value: interval,
                                         to: referenceDate)
        
        guard let unwrappedDate = date else {
            return nil
        }
    
        return Calendar.current.startOfDay(for: unwrappedDate)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
