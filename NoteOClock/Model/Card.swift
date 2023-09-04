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

    init(type: CardType, origin: CGPoint, size: CGSize, id: String) {
        self.type = type
        self.origin = origin
        self.size = size
        self.id = id
    }
}

enum CardType {
    case text

    var title: String {
        switch self {
        case .text:
            return "Text"
        }
    }

    var color: Color {
        switch self {
        case .text:
            return .mint
        }
    }
}
