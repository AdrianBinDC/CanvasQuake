//
//  DateExtensionTests.swift
//  CombineQuakeTests
//
//  Created by Adrian Bolinger on 4/9/21.
//

import XCTest
@testable import CombineQuake

class DateExtensionTests: XCTestCase {
    
    lazy var mockDate: Date? = {
        var components = DateComponents()
        components.month = 11
        components.day = 5
        components.year = 1968
        
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    func testStringStyle() throws {
        let date = try XCTUnwrap(mockDate)
        
        XCTAssertEqual(date.string(style: .full), "Tuesday, November 5, 1968")
        XCTAssertEqual(date.string(style: .long), "November 5, 1968")
        XCTAssertEqual(date.string(style: .medium), "Nov 5, 1968")
        XCTAssertEqual(date.string(style: .none), "")
        XCTAssertEqual(date.string(style: .short), "11/5/68")
    }
}
