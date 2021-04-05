//
//  APIManager.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/4/21.
//

import Combine
import Foundation

struct APIManager {
    
    // TODO: Add documentation once fields are refined
    func generateURL(startDate: Date?,
                     endDate: Date?,
                     minMag: Double?,
                     maxMag: Double?,
                     minlatitude: Double? = nil,
                     maxlatitude: Double? = nil,
                     minlongitude: Double? = nil,
                     maxlongitude: Double? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "earthquake.usgs.gov"
        components.path = "/fdsnws/event/1/query"
        
        var queryItems: [URLQueryItem] = []
        
        let formatQuery = URLQueryItem(name: "format", value: "geojson")
        queryItems.append(formatQuery)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let startDate = startDate {
            let startDateQuery = URLQueryItem(name: "starttime", value: dateFormatter.string(from: startDate))
            queryItems.append(startDateQuery)
        }
        
        if let endDate = endDate {
            let endDateQuery = URLQueryItem(name: "endtime", value: dateFormatter.string(from: endDate))
            queryItems.append(endDateQuery)
        }
        
        if let minMag = minMag {
            let minMagQuery = URLQueryItem(name: "minmagnitude", value: String(format: "%.0f", minMag))
            queryItems.append(minMagQuery)
        }
        
        if let maxMag = maxMag {
            let maxMagQuery = URLQueryItem(name: "maxmagnitude", value: String(format: "%.0f", maxMag))
            queryItems.append(maxMagQuery)
        }
        
        if let minLat = minlatitude {
            let minLatQuery = URLQueryItem(name: "minlatitude", value: String(format: "%.0f", minLat))
            queryItems.append(minLatQuery)
        }
        
        if let maxLat = maxlatitude {
            let minLatQuery = URLQueryItem(name: "maxlatitude", value: String(format: "%.0f", maxLat))
            queryItems.append(minLatQuery)
        }
        
        if let minLong = minlongitude {
            let minLatQuery = URLQueryItem(name: "minlongitude", value: String(format: "%.0f", minLong))
            queryItems.append(minLatQuery)
        }

        if let maxLong = maxlongitude {
            let minLatQuery = URLQueryItem(name: "maxlongitude", value: String(format: "%.0f", maxLong))
            queryItems.append(minLatQuery)
        }

        
        components.queryItems = queryItems
        
        return components.url
    }
}
