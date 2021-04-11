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
    
    @Published var dateSpan: DateSpan = .oneWeek {
        didSet {
            print(">>> dateSpan:", dateSpan.description)
        }
    }
    @Published private(set) var dateSpanString: String = "" {
        didSet {
            print(">>> dateSpanString", dateSpanString)
        }
    }
    
    @Published var startDate = Date.date(.inPast,
                                         interval: .oneWeek) {
        didSet {
            print(">>> startDate:", startDate.string(style: .short))
        }
    }
    @Published var endDate = Date().startOfDay {
        didSet {
            print(">>> endDate", endDate.string(style: .short))
        }
    }
        
    lazy var dateChangePublisher: Publishers.Merge<DatePublisher, DatePublisher> = {
        let publisher = Publishers.Merge<DatePublisher, DatePublisher>($startDate, $endDate)
        
        return publisher
    }()
        
    private var subscribers: Set<AnyCancellable> = []
    
    init() {
        // set up publishers
        setupStartDatePublishers()
        setupEndDatePublishers()
        setupDateSpanPublishers()
        setupDateChangePublisher()
    }
    
    private func setupStartDatePublishers() {
        $startDate.sink { date in
        }
        .store(in: &subscribers)
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
    
    private func setupDateChangePublisher() {
        dateChangePublisher.sink(receiveValue: { date in
            self.updateDateSpanString()
        })
        .store(in: &subscribers)
    }
    
    func updateDateSpanString() {
        dateSpanString = "\(self.startDate.string(style: .medium)) to \(self.endDate.string(style: .medium))"
    }
}
