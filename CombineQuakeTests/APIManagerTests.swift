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
    
    func testGenerateURLWithNils() throws {
        let apiManager = APIManager()
        let sutURL = try XCTUnwrap(apiManager.generateURL(startDate: nil,
                                                      endDate: nil,
                                                      minMag: nil,
                                                      maxMag: nil,
                                                      minlatitude: nil,
                                                      maxlatitude: nil,
                                                      minlongitude: nil,
                                                      maxlongitude: nil))
        XCTAssertEqual(sutURL.absoluteString,
                       "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson")
    }
    
    func testGenerateURLWithoutNils() throws {
        let apiManager = APIManager()
        let startDate = try XCTUnwrap(mockDate(month: 1, day: 1, year: 2014))
        let endDate = try XCTUnwrap(mockDate(month: 1, day: 2, year: 2014))
        let sutURL = try XCTUnwrap(apiManager.generateURL(startDate: startDate,
                                                      endDate: endDate,
                                                      minMag: 5.0,
                                                      maxMag: 8.0,
                                                      minlatitude: -5,
                                                      maxlatitude: 5,
                                                      minlongitude: -5,
                                                      maxlongitude: 5))
        XCTAssertEqual(sutURL.absoluteString,
                       "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02&minmagnitude=5&maxmagnitude=8&minlatitude=-5&maxlatitude=5&minlongitude=-5&maxlongitude=5")
    }

    
    func testFetchHappyPath() throws {
        let exp = expectation(description: "testFetch")
        
        let apiManager = APIManager()
        let startDate = try XCTUnwrap(mockDate(month: 1, day: 1, year: 2014))
        let endDate = try XCTUnwrap(mockDate(month: 1, day: 2, year: 2014))
        let url = try XCTUnwrap(apiManager.generateURL(startDate: startDate,
                                                       endDate: endDate,
                                                       minMag: 5.0,
                                                       maxMag: nil))
        apiManager.fetch(url: url) { (result: Result<USGSSummary, Error>) in
            switch result {
            case .success(let result):
                XCTAssertTrue(true)
                let earthquakes = result.features
                XCTAssertEqual(earthquakes.count, 2)
                print(earthquakes[0])
                exp.fulfill()
            case .failure(_):
                XCTFail("fetch(url:completion) failed")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchUnappyPath() throws {
        let exp = expectation(description: "testFetch")
        
        let apiManager = APIManager()
        let url = try XCTUnwrap(URL(string: "cnn.com"))
        apiManager.fetch(url: url) { (result: Result<USGSSummary, Error>) in
            switch result {
            case .success(_):
                XCTFail("fetch(url:completion:) should fail")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "unsupported URL")
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
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
