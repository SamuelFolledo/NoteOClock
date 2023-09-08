//
//  Card.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

class Card {
    @Published var type: CardType = .text
    @Published var origin: CGPoint = .zero
    @Published var size: CGSize = .zero
    @Published var id: String = ""

//    @Published var time: String = ""
//    @Published var date: String = ""
//    @Published private var currentHour = 0
//    @Published private var currentMinute = 0
//    @Published private var currentSecond = 0
//    @Published private var currentDay = 1
//    @Published private var currentMonth = 1
//    @Published private var currentYear = 2023

    init(type: CardType, origin: CGPoint, size: CGSize, id: String) {
        self.type = type
        self.origin = origin
        self.size = size
        self.id = id
    }
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}

enum CardType {
    case text
    case clock

    var title: String {
        switch self {
        case .text:
            return "Text\nTextTextTextTextText\nTextText"
        case .clock:
            return "Clock"
        }
    }

    var color: Color {
        switch self {
        case .text:
            return .mint
        case .clock:
            return .indigo
        }
    }
}
