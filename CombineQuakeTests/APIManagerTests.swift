//
//  APIManagerTests.swift
//  CombineQuakeTests
//
//  Created by Adrian Bolinger on 4/5/21.
//

@testable import CombineQuake
import XCTest

class APIManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGenerateURL() throws {
        let apiManager = APIManager()
        let startDate = try XCTUnwrap(mockDate(month: 1, day: 1, year: 2014))
        let endDate = try XCTUnwrap(mockDate(month: 1, day: 2, year: 2014))
        
        let sutURL = try XCTUnwrap(apiManager.generateURL(startDate: startDate,
                                                      endDate: endDate,
                                                      minMag: 5.0,
                                                      maxMag: nil))
        
        XCTAssertEqual(sutURL.absoluteString,
                       "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02&minmagnitude=5")
    }
}

extension XCTestCase {
    func mockDate(month: Int, day: Int, year: Int) -> Date? {
        var date = DateComponents()
        date.month = month
        date.day = day
        date.year = year
        
        return Calendar.current.date(from: date)
    }
}
