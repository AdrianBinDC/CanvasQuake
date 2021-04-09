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
}
