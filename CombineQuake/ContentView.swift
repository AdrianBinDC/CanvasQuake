//
//  ContentView.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/4/21.
//

import Combine
import Foundation
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.dateSpanString)
            }
            
            Picker("Date Span", selection: $viewModel.dateSpan) {
                ForEach(DateSpan.allCases, id: \.rawValue) { value in
                    Text(value.description)
                        .tag(value)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            DatePicker("Selected Date",
                       selection: $viewModel.endDate)
                .datePickerStyle(GraphicalDatePickerStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ContentViewModel()
        ContentView(viewModel: viewModel)
        //        ContentView(viewModel: viewModel)
    }
}
