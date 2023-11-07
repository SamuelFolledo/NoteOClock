//
//  WeatherView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 11/6/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct WeatherView: View {
    var card: Card

    @StateObject private var locationManager = LocationManager()
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @State private var currentHour = 0
    @State private var currentMinute = 0
    @State private var currentSecond = 0
    @State private var currentDay = 1
    @State private var currentMonth = 1
    @State private var currentYear = 2023

    var body: some View {
        VStack {
            if let location = locationManager.location {
                Text("Your coordinate are:\(location.longitude), \(location.latitude)")
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    LocationPermissionView()
                        .environmentObject(locationManager)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            WeatherView(card: fakeWeatherCard)
        } else {
            // TODO: Support iOS 15 and below
            ClockView(card: fakeClockCard)
        }
    }
}
