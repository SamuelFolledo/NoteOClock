//
//  ContentView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

struct ContentView: View {
    let fakeCard = Card(type: .text, origin: .init(x: 200, y: 300), size: .init(width: 200, height: 200), id: "1")
    @StateObject var cardViewModel = CardViewModel()

    var body: some View {
        VStack {
            if !cardViewModel.cards.isEmpty {
                let index = 0
                ResizeableCard(index: index,
                               viewModel: cardViewModel,
                               isSelected: (cardViewModel.selectedCard != nil))
            } else {
                Text("No cards")
            }
        }
        .onAppear {
            cardViewModel.cards.append(fakeCard)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
