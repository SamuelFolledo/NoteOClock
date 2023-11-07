//
//  LocationPermissionView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 11/6/23.
//

import SwiftUI
import CoreLocationUI

struct LocationPermissionView: View {

    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to NoteOClock")
                    .bold()
                    .font(.title)

                Text("Please share your location in order to give provide accurate weather data")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()


            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LocationPermissionView()
}
