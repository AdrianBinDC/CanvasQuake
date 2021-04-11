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
    @Published private(set) var dateSpanString: String = ""
    
    @Published var startDate = Date.date(.inPast,
                                         interval: .oneWeek)
    @Published var endDate = Date().startOfDay
    
    @Published var showCalendar: Bool = false
    
    private var subscribers: Set<AnyCancellable> = []
    
    init() {
        // set up publishers
        setupStartDatePublishers()
        setupEndDatePublishers()
        setupDateSpanPublishers()
    }
    
    private func setupStartDatePublishers() {
        $startDate.sink { date in
            self.updateDateSpanString()
        }
        .store(in: &subscribers)
    }
    
    private func setupEndDatePublishers() {
        // TODO: update unit tests
        $endDate.sink { date in
            self.startDate = Date.date(.inPast,
                                     interval: self.dateSpan,
                                     referenceDate: date)
            self.updateDateSpanString()
        }
        .store(in: &subscribers)
    }
    
    private func setupDateSpanPublishers() {
        $dateSpan.sink { dateSpan in
            self.startDate = Date.date(.inPast,
                                       interval: dateSpan,
                                       referenceDate: self.endDate)
        }
        .store(in: &subscribers)
        
    }
    
    func updateDateSpanString() {
        dateSpanString = "\(self.startDate.string(style: .medium)) to \(self.endDate.string(style: .medium))"
    }
}
