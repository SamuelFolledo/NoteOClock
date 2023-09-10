//
//  ClockView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

struct ClockView: View {
    @State private var currentHour = 0
    @State private var currentMinute = 0
    @State private var currentSecond = 0
    @State private var currentDay = 1
    @State private var currentMonth = 1
    @State private var currentYear = 2023

    var body: some View {
        VStack {
            Text(String(format: "%02d/%02d/%04d", currentMonth, currentDay, currentYear))
                .font(.system(size: 20))
            Text(String(format: "%02d:%02d:%02d", currentHour, currentMinute, currentSecond))
                .font(.system(size: 60))
        }
        .padding()
        .onAppear {
            // Update the time every second
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                let calendar = Calendar.current
                let components = calendar.dateComponents([.hour, .minute, .second, .day, .month, .year], from: Date())
                currentHour = components.hour ?? 0
                currentMinute = components.minute ?? 0
                currentSecond = components.second ?? 0
                currentDay = components.day ?? 1
                currentMonth = components.month ?? 1
                currentYear = components.year ?? 2023
            }
            RunLoop.current.add(timer, forMode: .common)
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
