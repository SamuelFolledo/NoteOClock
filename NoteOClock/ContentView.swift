//
//  ContentView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height

struct ContentView: View {
    @StateObject var cardViewModel = CardViewModel()

    var body: some View {
        ForEach(cardViewModel.cards, id: \.id) { card in
            ResizeableCard(card: card,
                           viewModel: cardViewModel)
        }
        .onAppear {
            let fakeCard = Card(type: .text, origin: .init(x: 80, y: 90), size: .init(width: 200, height: 200), id: "1")
            cardViewModel.cards.append(fakeCard)
            let fakeCard2 = Card(type: .text, origin: .init(x: 150, y: 150), size: .init(width: 150, height: 150), id: "2")
            cardViewModel.cards.append(fakeCard2)
            let clockCard = Card(type: .clock, origin: .init(x: 100, y: 100), size: .init(width: screenWidth / 1.4, height: 250), id: "0")
            cardViewModel.cards.append(clockCard)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
