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
    @Published var isSelected: Bool

    init(type: CardType, origin: CGPoint, size: CGSize, id: String, isSelected: Bool = false) {
        self.type = type
        self.origin = origin
        self.size = size
        self.id = id
        self.isSelected = isSelected
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

    ///Background color when selected
    var backgroundColor: Color {
        switch self {
        case .text:
            return .teal
        case .clock:
            return .indigo
        }
    }

    ///Text color when selected
    var textColor: Color {
        switch self {
        case .text:
            return Color(uiColor: .systemBackground)
        case .clock:
            return Color(uiColor: .systemBackground)
        }
    }
}
