//
//  WeatherManager.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 11/6/23.
//

import Foundation
import CoreLocation
import WeatherKit

@available(iOS 16.0, *)
@MainActor class WeatherKitManager: ObservableObject {
    @Published var weather: Weather?
    var symbol: String {
        weather?.currentWeather.symbolName ?? "xmark"
    }
    var temp: String {
        let temp =
        weather?.currentWeather.temperature

        let convert = temp?.converted(to: .fahrenheit).description
        return convert ?? "Loading Weather Data"

    }

    //MARK: - Public Methods
    func getWeather() async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: .init(latitude: 37.322998, longitude: -122.032181))  // Coordinates for Apple Park just as example coordinates
            }.value
        } catch {
            fatalError("\(error)")
        }
    }
}
