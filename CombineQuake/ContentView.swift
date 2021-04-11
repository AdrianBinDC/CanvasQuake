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
    
    @State private var isCalendarHidden: Bool = true
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                Picker("Date Span", selection: $viewModel.dateSpan) {
                    ForEach(DateSpan.allCases, id: \.rawValue) { value in
                        Text(value.description)
                            .tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Divider()
                
                HStack {
                    Text(viewModel.dateSpanString)
                        .bold()
                    Spacer()
                    Button(action: {
                        withAnimation { isCalendarHidden.toggle() }
                    }) {
                        Image(systemName: Icons.calendar)
                            .imageScale(.large)
                    }
                    .animation(.spring())
                }
                .padding(EdgeInsets(top: 8,
                                    leading: 0,
                                    bottom: 4,
                                    trailing: 0))
                
                Divider()
                    .isHidden(isCalendarHidden)
                
                if !isCalendarHidden {
                    DatePicker("Selected Date",
                               selection: $viewModel.endDate,
                               displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .animation(.default)
                        .transition(AnyTransition.opacity.animation(.easeOut))
                }
                Divider()
                Text("Stuff")
            }
            .padding()
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
