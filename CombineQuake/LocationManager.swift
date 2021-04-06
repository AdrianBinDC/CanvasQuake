//
//  LocationManager.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/5/21.
//

import Combine
import CoreLocation
import Foundation

class LocationManager: NSObject {
    public static let sharedInstance = LocationManager()
    
    var latestLocationPublisher = PassthroughSubject<CLLocation, Never>()
    var locationLookupPublisher = PassthroughSubject<CLPlacemark, Error>()
    
    private let locationManager = CLLocationManager()
    
    private let timer = Timer.publish(every: 300,
                                      on: .main,
                                      in: .common).autoconnect()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Update the location every 5 minutes
        timer.sink { _ in
            self.locationManager.startUpdatingLocation()
        }
        .store(in: &subscriptions)
    }
    
    
    /// Get `CLPlacemark` from a `String`
    /// - Parameters:
    ///   - locationString: A location string (ex: "New York, NY")
    ///   - completion: Completion block with an optional `CLPlacemark`
    public func geocode(locationString: String, completion: @escaping (CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationString) { placemarks, error in
            if error == nil {
                completion(placemarks?.first)
            }
        }
    }
    
    
    /// Get a location String from a `CLLocation`
    /// - Parameters:
    ///   - location: a `CLLocation`
    ///   - completion: Completion block with an optional `String`
    ///
    /// The String in the location is formatted as "City, State, Country"
    public func reverseGeocode(location: CLLocation, completion: @escaping (_ location: String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?.first,
                   let city = placemark.locality,
                   let state = placemark.administrativeArea,
                   let country = placemark.isoCountryCode {
                    let locationString = String(format: "%@, %@, %@", city, state, country)
                    
                    completion(locationString)
                }
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latestLocationPublisher.send(location)
            // Once you get a location, turn it off until 5 minutes have passed 
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            print("location manager not authorized")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
