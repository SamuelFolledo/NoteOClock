//
//  Card.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

enum CardType {
    case text
    case clock
}

class Card: ObservableObject {
    @Published var type: CardType = .text
    @Published var origin: CGPoint = .zero
    @Published var size: CGSize = .zero
    @Published var id: String = ""
    @Published var isSelected: Bool
    @Published var text: String = ""

    var backgroundColor: Color {
        switch type {
        case .clock:
            return isSelected ? .indigo : Color(uiColor: .clear)
        case .text:
            return isSelected ? .teal : Color(uiColor: .secondarySystemBackground)
        }
    }
    var foregroundColor: Color {
        switch type {
        case .clock:
            return isSelected ? Color(uiColor: .systemBackground) : Color(uiColor: .label)
        case .text:
            return isSelected ? Color(uiColor: .systemBackground) : Color(uiColor: .label)
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

//MARK:
extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}
