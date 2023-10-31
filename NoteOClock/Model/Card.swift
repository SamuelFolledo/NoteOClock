//
//  Card.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

enum CardType: Codable {
    case text
    case clock

    var defaultSize: CGSize {
        switch self {
        case .text:
            return CGSize(width: 150, height: 100)
        case .clock:
            return CGSize(width: 600, height: 160)
        }
    }

    func defaultOrigin(cardCount: Int, _ proxy: GeometryProxy) -> CGPoint {
        switch self {
        case .text:
            let divisible: Int = 6
            return CGPoint(x: Int(proxy.size.width) / (divisible * 2) + cardCount * 10, y: Int(proxy.size.height) / divisible + cardCount * 10)
        case .clock:
            return CGPoint(x: Int(proxy.size.width) / 2, y: Int(proxy.size.height) / 2)
        }
    }
}

class Cards: Codable {
    var cards: [Card]

    init(cards: [Card]) {
        self.cards = cards
    }
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
            return Color(uiColor: .label)
        case .text:
            return Color(uiColor: .label)
        }
    }

    init(type: CardType, origin: CGPoint, id: String, isSelected: Bool = false) {
        self.type = type
        self.origin = origin
        self.size = type.defaultSize
        self.id = id
        self.isSelected = isSelected
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(CardType.self, forKey: .type)
        origin = try container.decode(CGPoint.self, forKey: .origin)
        size = try container.decode(CGSize.self, forKey: .size)
        id = try container.decode(String.self, forKey: .id)
        isSelected = try container.decode(Bool.self, forKey: .isSelected)
        text = try container.decode(String.self, forKey: .text)
    }
}

//MARK: - Codable
extension Card: Codable {
    enum CodingKeys: CodingKey {
        case type,
             origin,
             size,
             id,
             isSelected,
             text
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(origin, forKey: .origin)
        try container.encode(size, forKey: .size)
        try container.encode(id, forKey: .id)
        try container.encode(isSelected, forKey: .isSelected)
        try container.encode(text, forKey: .text)
    }
}

//MARK: - Equatable
extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}
