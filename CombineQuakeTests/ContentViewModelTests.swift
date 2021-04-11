//
//  ContentViewModelTests.swift
//  CombineQuakeTests
//
//  Created by Adrian Bolinger on 4/9/21.
//

import Combine
import XCTest
@testable import CombineQuake

class ContentViewModelTests: XCTestCase {
    
    private lazy var today: Date = {
        return Calendar.current.startOfDay(for: Date())
    }()
    
    private lazy var oneWeekAgo: Date? = {
        let date = Calendar.current.date(byAdding: .day,
                              value: -7,
                              to: Date())
        
        return Calendar.current.startOfDay(for: date!)
    }()

    private var subscriptions: Set<AnyCancellable> = []
    
    func testStartDate() throws {
        let viewModel = ContentViewModel()
        
        // Verify
        XCTAssertEqual(viewModel.startDate, oneWeekAgo)
        XCTAssertEqual(viewModel.endDate, today)
        
        // Expected Dates
        let expectedStartDates = [
            createDate(month: 10, day: 1, year: 1972),
            createDate(month: 9, day: 12, year: 2006)
        ]
        
        let expectedEndDates = [
            createDate(month: 10, day: 8, year: 1972),
            createDate(month: 9, day: 19, year: 2006)
        ]
                
        viewModel.$startDate
            .collectNext(2)
            .sink { actualStartDates in
                XCTAssertEqual(actualStartDates, expectedStartDates)
            }
            .store(in: &subscriptions)
                
        viewModel.$endDate
            .collectNext(2)
            .sink { actualEndDates in
                XCTAssertEqual(actualEndDates, expectedEndDates)
            }
            .store(in: &subscriptions)
                
        expectedStartDates.forEach { date in
            viewModel.startDate = date
        }
    }
    
    // TODO: Write tests for endDate
}
