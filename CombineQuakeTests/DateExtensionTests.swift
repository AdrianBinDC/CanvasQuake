//
//  DateExtensionTests.swift
//  CombineQuakeTests
//
//  Created by Adrian Bolinger on 4/9/21.
//

import XCTest
@testable import CombineQuake

class DateExtensionTests: XCTestCase {
    
    private lazy var mockDate: Date? = {
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
    
    func testCustomDate() throws {
        let sutDate = Date.customDate(year: 1968,
                                      month: 11,
                                      day: 5)
        XCTAssertEqual(sutDate, try XCTUnwrap(mockDate))
    }
    
    func testDateIntervalEnum() {
        let expectedCases: [DateSpan] = [
            .oneDay,
            .oneWeek,
            .oneMonth,
            .threeMonths,
            .sixMonths,
            .oneYear
        ]
        
        let actualCases = DateSpan.allCases
        
        XCTAssertEqual(expectedCases, actualCases)
        
        let expectedValues = [1, 7, 30, 90, 180, 365]
        XCTAssertEqual(actualCases.map { $0.rawValue }, expectedValues)
        
        let expectedCaseDescriptions: [String] = ["1d", "1w", "1m", "3m", "6m", "1y"]
        let actualCaseDescriptions = actualCases.map { $0.description }
        XCTAssertEqual(expectedCaseDescriptions, actualCaseDescriptions)
        
    }
    
    func testCreateRelativeDate() throws {
        let referenceDate = try XCTUnwrap(Date.customDate(year: 2021,
                                                          month: 4,
                                                          day: 9))
        let expectedFutureDate = try XCTUnwrap(Date.customDate(year: 2022,
                                                               month: 4,
                                                               day: 9))
        let expectedPastDate = try XCTUnwrap(Date.customDate(year: 2020,
                                                             month: 4,
                                                             day: 9))
        
        XCTAssertEqual(expectedFutureDate, Date.date(.inFuture,
                                                     interval: .oneYear,
                                                     referenceDate: referenceDate))
        XCTAssertEqual(expectedPastDate, Date.date(.inPast,
                                                   interval: .oneYear,
                                                   referenceDate: referenceDate))
    }
}
