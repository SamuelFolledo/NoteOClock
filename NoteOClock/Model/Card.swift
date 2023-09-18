//
//  Card.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

class Card: ObservableObject {
    @Published var type: CardType = .text
    @Published var origin: CGPoint = .zero
    @Published var size: CGSize = .zero
    @Published var id: String = ""
    @Published var isSelected: Bool
    @Published var text: String = ""
    var deselectedBackgroundColor = Color(uiColor: .secondarySystemBackground)

    var backgroundColor: Color {
        switch type {
        case .clock:
            return isSelected ? type.selectedBackgroundColor : Color(uiColor: .clear)
        case .text:
            return isSelected ? type.selectedBackgroundColor : deselectedBackgroundColor
        }
    }
    var foregroundColor: Color {
        switch type {
        case .clock:
            return isSelected ? type.textColor : Color(uiColor: .label)
        case .text:
            return isSelected ? type.textColor : Color(uiColor: .label)
        }
    }

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

    ///Background color when selected
    var selectedBackgroundColor: Color {
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
            return Color(uiColor: .label)
        case .clock:
            return Color(uiColor: .label)
        }
    }
}
