//
//  ContentViewModel.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/9/21.
//

import Combine
import Foundation

class ContentViewModel: ObservableObject {
    private let apiManager = APIManager()
    private let locationManager = LocationManager.sharedInstance
    
    @Published var dateSpan: DateSpan = .oneWeek

    @Published var startDate = Date.date(.inPast, interval: .oneWeek)
    @Published var startDateString = ""
    
    @Published var endDate = Date().startOfDay
    @Published var endDateString = ""
    
    private var subscribers: Set<AnyCancellable> = []
        
    init() {
        // set up publishers
        setupStartDatePublishers()
        setupEndDatePublishers()
    }
    
    private func setupStartDatePublishers() {
        $startDate.sink { date in
            if let newStartDate = date,
               let newEndDate = Date.date(.inFuture,
                                          interval: self.dateSpan,
                                          referenceDate: newStartDate) {
                self.startDateString = newStartDate.string(style: .medium)
                self.endDate = newEndDate
            }
        }
        .store(in: &subscribers)
    }
    
    private func setupEndDatePublishers() {
        $endDate.sink { date in
            self.endDateString = date.string(style: .medium)
        }
        .store(in: &subscribers)
    }
}
