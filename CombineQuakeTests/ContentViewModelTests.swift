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
        let expectedEndDates = [
            createDate(month: 10, day: 8, year: 1972),
            createDate(month: 9, day: 19, year: 2006),
            createDate(month: 8, day: 10, year: 1971),
        ]

        let expectedStartDates = [
            createDate(month: 10, day: 1, year: 1972),
            createDate(month: 9, day: 12, year: 2006),
            createDate(month: 8, day: 3, year: 1971),
            createDate(month: 8, day: 9, year: 1971),
        ]
                
//        let expectedDateSpanStrings = [
//            "",
//            "",
//            "",
//        ]
                
        viewModel.$startDate
            .collectNext(4)
            .sink { actualStartDates in
                XCTAssertEqual(actualStartDates, expectedStartDates)
                actualStartDates.forEach { date in
                    print(">>> startDate", date.string(style: .short))
                }
            }
            .store(in: &subscriptions)
                
        viewModel.$endDate
            .collectNext(3)
            .sink { actualEndDates in
                XCTAssertEqual(actualEndDates, expectedEndDates)
            }
            .store(in: &subscriptions)
        
        // FIXME: this works, but not able to pick it up here for some reason
//        viewModel.$dateSpanString
//            .collectNext(4)
//            .sink { actualDateSpanStrings in
//                XCTAssertEqual(actualDateSpanStrings, expectedDateSpanStrings)
//            }
//            .store(in: &subscriptions)
                
        expectedEndDates.forEach { date in
            viewModel.endDate = date
        }
        
        viewModel.dateSpan = .oneDay
        
    }
    
    // TODO: Write tests for endDate
}
