//
//  ContentViewModel.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/9/21.
//

import Combine
import Foundation

class ContentViewModel: ObservableObject {
    typealias DatePublisher = Published<Date>.Publisher
    typealias DateSpanPublisher = Published<DateSpan>.Publisher
    
    private let apiManager = APIManager()
    private let locationManager = LocationManager.sharedInstance
    
    @Published var dateSpan: DateSpan = .oneWeek
    @Published private(set) var dateSpanString: String = ""
    @Published var startDate = Date.date(.inPast,
                                         interval: .oneWeek)
    @Published var endDate = Date().startOfDay {
        didSet {
            guard endDate <= Date() else {
                endDate = oldValue
                return
            }
        }
    }
                
    private lazy var latestDatesPublisher: Publishers.CombineLatest = {
        Publishers.CombineLatest($startDate, $endDate)
    }()
    
    private var subscribers: Set<AnyCancellable> = []
    
    init() {
        // set up publishers
        setupEndDatePublishers()
        setupDateSpanPublishers()
        setupLatestDatesPublisher()
    }
    
    private func setupEndDatePublishers() {
        // TODO: update unit tests
        $endDate.sink { date in
            self.startDate = Date.date(.inPast,
                                     interval: self.dateSpan,
                                     referenceDate: date)
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
    
    private func setupLatestDatesPublisher() {
        latestDatesPublisher.sink { start, end in
            self.dateSpanString = "\(start.string(style: .medium)) to \(end.string(style: .medium))"
        }
        .store(in: &subscribers)
    }
}
