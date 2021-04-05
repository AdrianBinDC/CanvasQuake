//
//  QuakeSummary.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/4/21.
//

import Foundation

// Documentation:
// https://earthquake.usgs.gov/fdsnws/event/1/

import Foundation

// API Specifications
// http://www.fdsn.org/webservices/FDSN-WS-Specifications-1.0.pdf

// GeoJSON documentation
// https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php
struct USGSSummary {
    let type: String
    let metadata: Metadata
    let features: [Feature]
    let bbox: [Double]
}

struct Feature {
    let type: FeatureType
    let properties: EarthQuakeData
    let geometry: Geometry
    let id: String
}

struct Geometry {
    let type: String
    let coordinates: [Double]
}

struct EarthQuakeData {
    let mag: Double
    let place: String
    let time: Int
    let updated: Int
    let tz: Int?
    let url: String
    let detail: String
    let felt: Int?
    let cdi: Double?
    let mmi: Double?
    let alert: String?
    let status: String
    let tsunami: Int
    let sig: Int
    let net: String
    let code: String
    let ids: String
    let sources: String
    let types: String
    let nst: Int?
    let dmin: Double?
    let rms: Double
    let gap: Double?
    let magType: String
    let type: PropertiesType
    let title: String
}

enum PropertiesType {
    case earthquake
    case explosion
}

enum FeatureType {
    case feature
}

struct Metadata {
    let generated: Int
    let url: String
    let title: String
    let status: Int
    let api: String
    let count: Int
}
