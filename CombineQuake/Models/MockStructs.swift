//
//  MockStructs.swift
//  CombineQuake
//
//  Created by Adrian Bolinger on 4/6/21.
//

import Foundation


/*
 Feature(type: "Feature",
 properties: CombineQuake.EarthQuakeData(mag: 6.5, place: "32km W of Sola, Vanuatu", time: 1388592209000, updated: 1594407529032, tz: Optional(660), url: "https://earthquake.usgs.gov/earthquakes/eventpage/usc000lvb5", detail: "https://earthquake.usgs.gov/fdsnws/event/1/query?eventid=usc000lvb5&format=geojson", felt: nil, cdi: nil, mmi: Optional(4.262), alert: Optional("green"), status: "reviewed", tsunami: 1, sig: 650, net: "us", code: "c000lvb5", ids: ",pt14001000,at00myqcls,usc000lvb5,", sources: ",pt,at,us,", types: ",cap,geoserve,impact-link,losspager,moment-tensor,nearby-cities,origin,phase-data,shakemap,tectonic-summary,", nst: nil, dmin: Optional(3.997), rms: 0.76, gap: Optional(14.0), magType: "mww", type: "earthquake", title: "M 6.5 - 32km W of Sola, Vanuatu"), geometry: CombineQuake.Geometry(type: "Point", coordinates: [167.249, -13.8633, 187.0]), id: "usc000lvb5")
 
 */
enum MockStructs {
    static let quakeData = EarthQuakeData(mag: 6.5,
                                          place: "32km W of Sola, Vanuatu",
                                          time: 1388592209000,
                                          updated: 1594407529032,
                                          tz: 660,
                                          url: "https://earthquake.usgs.gov/earthquakes/eventpage/usc000lvb5",
                                          detail: "https://earthquake.usgs.gov/fdsnws/event/1/query?eventid=usc000lvb5&format=geojson",
                                          felt: nil,
                                          cdi: nil,
                                          mmi: nil,
                                          alert: nil,
                                          status: "reviewed",
                                          tsunami: 1,
                                          sig: 650,
                                          net: "us",
                                          code: "c0001vb5",
                                          ids: ",pt14001000,at00myqcls,usc000lvb5,",
                                          sources: "pt,at,us",
                                          types: "cap,geoserve,impact-link,losspager,moment-tensor,nearby-cities,origin,phase-data,shakemap,tectonic-summary",
                                          nst: nil,
                                          dmin: 3.997,
                                          rms: 0.76,
                                          gap: 14.0,
                                          magType: "mww",
                                          type: "earthquake",
                                          title: "M 6.5 - 32km W of Sola, Vanuatu")
    static let geometry = Geometry(type: "Point",
                                   coordinates: [167.249, -13.8633, 187.0])

    static let earthquake = Feature(type: "Feature",
                                    properties: quakeData,
                                    geometry: geometry,
                                    id: "usc000lvb5")
}
