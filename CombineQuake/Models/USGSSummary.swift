//
//  QuakeSummary.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/4/21.
//

import SwiftUI
import Foundation
import MapKit

// Documentation:
// https://earthquake.usgs.gov/fdsnws/event/1/

import Foundation

// API Specifications
// http://www.fdsn.org/webservices/FDSN-WS-Specifications-1.0.pdf

// GeoJSON documentation
// https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php
struct USGSSummary: Codable {
    let type: String
    let metadata: Metadata
    let features: [Feature]
    let bbox: [Double]
}

struct Feature: Codable, Identifiable {
    let type: String?
    let properties: EarthQuakeData
    let geometry: Geometry
    let id: String
}

struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

struct EarthQuakeData: Codable {
    let mag: Double?
    let place: String?
    let time: Int
    let updated: Int?
    let tz: Int?
    let url: String?
    let detail: String?
    let felt: Int?
    let cdi: Double?
    let mmi: Double?
    let alert: String?
    let status: String?
    let tsunami: Int?
    let sig: Int?
    let net: String?
    let code: String?
    let ids: String?
    let sources: String?
    let types: String?
    let nst: Int?
    let dmin: Double?
    let rms: Double
    let gap: Double?
    let magType: String?
    let type: String?
    let title: String?
}

struct Metadata: Codable {
    let generated: Int?
    let url: String?
    let title: String?
    let status: Int?
    let api: String?
    let count: Int?
}

extension Feature {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: geometry.coordinates[1],
                               longitude: geometry.coordinates[0])
    }
    
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 1.0,
                                    longitudeDelta: 1.0)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: span)
        
        return region
    }
    
    var quakeDate: Date {
        Date(timeIntervalSince1970: Double(properties.time / 1_000))
    }
    
    var lastUpdateDate: Date? {
        guard let updated = properties.updated else {
            return nil
        }
        
        return Date(timeIntervalSince1970: Double(updated / 1_000))
    }
}
