//
//  LocationManagerTests.swift
//  CombineQuakeTests
//
//  Created by Adrian Bolinger on 4/5/21.
//

import Combine
import CoreLocation
import XCTest

@testable import CombineQuake

class LocationManagerTests: XCTestCase {
    
    var subscriptions: Set<AnyCancellable> = []
    
    private lazy var locationManager: LocationManager = {
        LocationManager.sharedInstance
    }()
    
    // FIXME: Figure out how to delay this test
    func testLatestLocationPublisher() {
        let exp = expectation(description: "testLatestLocationPublisher")
        
        locationManager.latestLocationPublisher.sink { actualLocation in
            let expectedLocation = CLLocation(latitude: 40.75921100,
                                              longitude: -73.98463800).coordinate
            XCTAssertEqual(actualLocation.coordinate, expectedLocation)
            exp.fulfill()
        }
        .store(in: &subscriptions)
        
        wait(for: [exp], timeout: 10)
    }
    
    func testGeocode() {
        let exp = expectation(description: "testGeocode")

        locationManager.geocode(locationString: "1600 Pennsylvania Avenue, Washington, DC") { placemark in
            XCTAssertNotNil(placemark)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
    }
    
    func testReverseGeocode() {
        let exp = expectation(description: "testReverseGeocode")
        let location = CLLocation(latitude: 40.75921100,
                                          longitude: -73.98463800)
        let expectedLocation = "New York, NY, US"
        
        locationManager.reverseGeocode(location: location) { actualLocation in
            XCTAssertEqual(actualLocation, expectedLocation)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
    }
}
