//
//  APIManager.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/4/21.
//

import Combine
import Foundation

class APIManager {
    
    // https://jeevatamil.medium.com/create-generic-apimanager-with-combine-framework-6456ca04452f
    
    private var subscriber: Set<AnyCancellable> = []
    
    
    /// Fetch a Codable struct from a URL
    /// - Parameters:
    ///   - url: a URL
    ///   - completion: a `Result<T, Error>` void
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void )  {
        // 1. Create 'dataTaskPusblisher'(Publisher) to make the API call
        URLSession.shared.dataTaskPublisher(for: url)
            // 2. Use 'map'(Operator) to get the data from the result
            .map { $0.data }
            // 3. Decode the data into the 'Decodable' struct using JSONDecoder
            .decode(type: T.self, decoder: JSONDecoder())
            // 4. Make this process in main thread. (you can do this in background thread as well)
            .receive(on: DispatchQueue.main)
            // 5. Use 'sink'(Subcriber) to get the decoaded value or error, and pass it to completion handler
            .sink { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    return
                }
            } receiveValue: { (resultArr) in
                completion(.success(resultArr))
            }
            // 6. saving the subscriber into an AnyCancellable Set (without this step this won't work)
            .store(in: &subscriber)
    }
    
    // TODO: Add documentation once fields are refined
    
    /// Generate an URL to hit
    /// - Parameters:
    ///   - startDate: the earliest `Date`
    ///   - endDate: the last `Date`
    ///   - minMag: a `Double` representing minimum magnitude
    ///   - maxMag: a `Double` maximum magnitude
    ///   - minlatitude: a `Double` minimum latitude
    ///   - maxlatitude: a `Double` maximum latitude
    ///   - minlongitude: a `Double` minimum longitude
    ///   - maxlongitude: a `Double` maximum longitude
    /// - Returns: An optional `URL`
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
