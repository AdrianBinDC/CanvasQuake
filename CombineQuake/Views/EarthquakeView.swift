//
//  EarthquakeView.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/6/21.
//

import Combine
import MapKit
import SwiftUI

class EarthquakeViewModel: ObservableObject {
    @Published private(set) var quakeData: Feature
    @State var region: MKCoordinateRegion
    
    
    init(quakeData: Feature) {
        self.quakeData = quakeData
        region = quakeData.region
    }
    
    public lazy var title: String = {
        quakeData.properties.title
    }()
}

struct EarthquakeView: View {
    @ObservedObject var viewModel: EarthquakeViewModel
    @State var region: MKCoordinateRegion
    
    init(viewModel: EarthquakeViewModel) {
        self.viewModel = viewModel
        _region = State(initialValue: viewModel.region)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.title)
            Map(coordinateRegion: $region)
        }
    }
}

extension EarthquakeView {
    @ViewBuilder func makeMapView() -> some View {
        Map(coordinateRegion: $region)
    }
}

struct EarthquakeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EarthquakeViewModel(quakeData: MockStructs.earthquake)
        
        EarthquakeView(viewModel: viewModel)
    }
}
