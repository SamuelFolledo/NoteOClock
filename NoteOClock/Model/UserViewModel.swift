//
//  UserViewModel.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/17/23.
//

import SwiftUI

class UserViewModel: ObservableObject {
    static let shared = UserViewModel()
    private let userCardsKey: String = "UserCardsKey"

    private init() {}

    func getCards() -> [Card] {
        let cards = UserDefaults.standard.retrieve(object: Cards.self, fromKey: userCardsKey)
        return cards?.cards ?? []
    }

    func saveCards(_ cards: [Card]) {
        let userCards = Cards(cards: cards)
        UserDefaults.standard.save(customObject: userCards, inKey: userCardsKey)
    }
}
